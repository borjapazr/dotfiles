#!/usr/bin/env bats
#
# The `dot` entrypoint, exercised as an agent would: no TTY, no environment.

setup() {
  load helpers/load
  DOT="$DOTFILES_PATH/bin/dot"
}

@test "dot --list prints commands with summaries instead of hanging on fzf" {
  run "$DOT" --list </dev/null
  [ "$status" -eq 0 ]
  [[ $output == *"dot git commit"* ]]
}

# Regression: with no arguments the CLI used to open fzf and then block on
# `read`, which is an unrecoverable hang for a non-interactive caller.
@test "dot with no arguments falls back to the list when there is no TTY" {
  run "$DOT" </dev/null
  [ "$status" -eq 0 ]
  [[ $output == *"dot git commit"* ]]
}

@test "dot --json emits parseable JSON" {
  run "$DOT" --json </dev/null
  [ "$status" -eq 0 ]
  printf '%s' "$output" | python3 -c 'import json,sys; d=json.load(sys.stdin); assert d, "empty"; assert {"context","script","command","summary"} <= set(d[0])'
}

@test "dot -h prints usage" {
  run "$DOT" -h </dev/null
  [ "$status" -eq 0 ]
  [[ $output == *Usage* ]]
}

@test "dot passes -h through to the dispatched script" {
  run "$DOT" git commit -h </dev/null
  [ "$status" -eq 0 ]
  [[ $output == *Usage* ]]
}

@test "an unknown context fails and lists the available ones" {
  run "$DOT" not-a-context </dev/null
  [ "$status" -ne 0 ]
  [[ $output == *git* ]]
}

@test "an unknown script fails and lists the scripts of its context" {
  run "$DOT" git not-a-script </dev/null
  [ "$status" -ne 0 ]
  [[ $output == *commit* ]]
}

# Regression: `source "$DOTFILES_PATH/..."` fails under `set -u` before the
# library has any chance to derive the path itself, so the entrypoint has to
# resolve the repo root on its own and export it for the scripts it dispatches.
@test "dot works when DOTFILES_PATH is not set in the environment" {
  run env -u DOTFILES_PATH "$DOT" --list </dev/null
  [ "$status" -eq 0 ]
  [[ $output == *"dot git commit"* ]]
}

@test "dot exports DOTFILES_PATH to the scripts it dispatches" {
  run env -u DOTFILES_PATH "$DOT" utils timestamp_to_date 1700000000000 </dev/null
  [ "$status" -eq 0 ]
  [[ $output == *2023* ]]
}

@test "dot is reachable through PATH without DOTFILES_PATH" {
  run env -u DOTFILES_PATH PATH="$DOTFILES_PATH/bin:/usr/bin:/bin" \
    dot utils timestamp_to_date 1700000000000 </dev/null
  [ "$status" -eq 0 ]
  [[ $output == *2023* ]]
}
