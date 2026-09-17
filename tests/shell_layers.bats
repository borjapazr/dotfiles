#!/usr/bin/env bats
#
# Shell loading layers.
#
# The contract: a non-interactive shell gets environment only. Aliases and
# functions belong to interactive sessions. A tool that runs `zsh -lc ls` must
# get the real `ls`, not a human-facing replacement with different flags and
# different output.

setup() {
  load helpers/load
  require_installed_shell
  # The real PATH, so the guarded aliases actually have something to bind to.
  # With a scrubbed PATH they would skip themselves and the test would pass
  # without proving anything.
  REAL_PATH="$PATH"
}

login_shell() {
  clean_login_shell "$1" "$2" PATH="$REAL_PATH"
}

@test "a login shell prints nothing at all" {
  run login_shell zsh 'true'
  [ "$status" -eq 0 ]
  [ -z "$output" ]
}

# zsh always ships run-help and which-command; anything else would be ours.
@test "a non-interactive shell defines no aliases of our own" {
  run login_shell zsh 'alias'
  run bash -c "printf '%s\n' \"\$1\" | grep -vE '^(run-help|which-command)=' | grep -c ." _ "$output"
  [ "$output" -eq 0 ]
}

# Regression: `chmod --preserve-root -v` is a GNU spelling that BSD rejects
# outright, so every chmod in an interactive session failed.
@test "destructive commands keep flags the local platform accepts" {
  if [ "$(uname -s)" != "Darwin" ]; then skip "macOS only"; fi
  run zsh -ic 'alias chmod chown'
  [[ $output != *preserve-root* ]]
}

# Regression: .zprofile sourced the interactive layer, so `ls` reached every
# tool as eza, with different flags and different output.
@test "ls is the real ls in a non-interactive shell" {
  run login_shell zsh 'command -v ls; type ls'
  [[ $output != *eza* ]]
}

@test "df and ping are not replaced in a non-interactive shell" {
  run login_shell zsh 'type df; type ping'
  [[ $output != *pydf* ]]
  [[ $output != *prettyping* ]]
}

@test "open is the system binary, not the dotfiles wrapper" {
  if ! platform_is_macos; then skip "macOS only"; fi
  run login_shell zsh 'type open'
  [[ $output == *"/usr/bin/open"* ]]
}

# Regression: this was exported and grew on every shell startup, reaching over
# a kilobyte and leaking fzf UI settings into every child process.
@test "FZF_DEFAULT_OPTS does not leak out of interactive shells" {
  run login_shell zsh 'echo "${FZF_DEFAULT_OPTS:-unset}"'
  [ "$output" = "unset" ]
}

@test "an interactive shell does get the human-facing aliases" {
  if ! command -v eza >/dev/null; then skip "eza not installed"; fi
  run zsh -ic 'alias ls'
  [[ $output == *eza* ]]
}

@test "PATH has no duplicate entries" {
  run login_shell zsh 'printf "%s\n" "${PATH//:/$'"'"'\n'"'"'}" | sort | uniq -d'
  [ -z "$output" ]
}

@test "the environment layer is idempotent" {
  run login_shell zsh 'before=$PATH; source "$DOTFILES_PATH/config/shell/shared/env.sh"; [ "$before" = "$PATH" ] && echo same'
  [ "$output" = "same" ]
}

@test "DOTFILES_PATH is exported to every shell" {
  run login_shell zsh 'echo "$DOTFILES_PATH"'
  [ -d "$output" ]
}

# Regression: `bash -i` without login never reads .bash_profile, so it reaches
# interactive.sh with $DOTFILES_PATH unset. Without a fallback there, the source
# resolved to "/config/shell/shared/env.sh" and the shell came up bare.
@test "a non-login interactive bash still gets the environment" {
  command -v bash >/dev/null || skip "bash is not installed"
  [ -e "$HOME/.bashrc" ] || skip "dotfiles are not installed for this user"

  run env -i HOME="$HOME" TERM=xterm-256color PATH=/usr/local/bin:/usr/bin:/bin \
    bash -i <<<'echo "probe=$DOTFILES_PATH"'
  [[ $output == *"probe=$DOTFILES_PATH"* ]]
}

@test "bash and zsh agree on the exported environment" {
  local probe='echo "$EDITOR|$PAGER|$DOTFILES_PATH"'
  run login_shell zsh "$probe"
  local from_zsh="$output"
  run login_shell bash "$probe"
  [ "$output" = "$from_zsh" ]
}

# A shell slow enough to be annoying is a shell that gets bypassed. The budget
# is deliberately loose: it exists to catch a regression of seconds, not to
# police milliseconds on a noisy CI runner.
@test "an interactive shell starts within budget" {
  local -r budget_ms=1500
  local start end
  start=$(date +%s)
  zsh -ic 'true' >/dev/null 2>&1
  zsh -ic 'true' >/dev/null 2>&1
  zsh -ic 'true' >/dev/null 2>&1
  end=$(date +%s)
  local -r avg_ms=$(((end - start) * 1000 / 3))
  echo "average interactive startup: ${avg_ms}ms (budget ${budget_ms}ms)"
  [ "$avg_ms" -le "$budget_ms" ]
}

platform_is_macos() {
  [ "$(uname -s)" = "Darwin" ]
}
