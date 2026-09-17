#!/usr/bin/env bats
#
# Core library: script and context discovery.

setup() {
  load helpers/load
  load_core
}

@test "dot::script_exists finds an executable script" {
  run dot::script_exists "$DOTFILES_PATH" git commit
  [ "$status" -eq 0 ]
}

@test "dot::script_exists rejects a missing script" {
  run dot::script_exists "$DOTFILES_PATH" git definitely-not-here
  [ "$status" -ne 0 ]
}

@test "dot::context_exists accepts a real context" {
  run dot::context_exists "$DOTFILES_PATH" git
  [ "$status" -eq 0 ]
}

@test "dot::context_exists rejects core, which holds the library and not commands" {
  run dot::context_exists "$DOTFILES_PATH" core
  [ "$status" -ne 0 ]
}

@test "dot::list_contexts never leaks the core context" {
  run dot::list_contexts
  [ "$status" -eq 0 ]
  [[ $output == *git* ]]
  [[ $output != *core* ]]
}

@test "dot::list_context_scripts lists commands of a context" {
  run dot::list_context_scripts git
  [ "$status" -eq 0 ]
  [[ $output == *commit* ]]
}

# Regression: this used `find -perm /+111`, a GNU-only spelling that BSD find
# rejects. It silently returned nothing on macOS and broke the whole CLI.
@test "dot::list_scripts_path returns results on this platform's find" {
  run dot::list_scripts_path
  [ "$status" -eq 0 ]
  [ -n "$output" ]
  [[ $output == *"/commands/git/commit"* ]]
}

@test "dot::list_scripts prints invocable command lines" {
  run dot::list_scripts
  [ "$status" -eq 0 ]
  [[ $output == *"dot git commit"* ]]
}

@test "dot::script_summary returns the first docblock line, not the usage" {
  run dot::script_summary git commit
  [ "$status" -eq 0 ]
  [ -n "$output" ]
  [[ $output != *Usage* ]]
  [ "$(printf '%s' "$output" | wc -l)" -eq 0 ]
}

@test "dot::script_summary stays quiet for a missing script" {
  run dot::script_summary git definitely-not-here
  [ "$status" -eq 0 ]
  [ -z "$output" ]
}

# Regression: shellcheck quotes offending lines and `shfmt -d` prints diffs, so
# a machine-local secrets file reaching this list would print its contents into
# the CI log.
@test "dot::list_bash_files never yields machine-local secret files" {
  run dot::list_bash_files
  [ "$status" -eq 0 ]
  [[ $output != *local.sh* ]]
  [[ $output != *local.interactive.sh* ]]
  [[ $output != *private-* ]]
}

@test "dot::list_bash_files includes the shell layers and the dot entrypoint" {
  run dot::list_bash_files
  [[ $output == *"config/shell/shared/env.sh"* ]]
  [[ $output == *"config/shell/shared/env/agent.sh"* ]]
  [[ $output == *"/bin/dot"* ]]
}
