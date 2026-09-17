#!/usr/bin/env bats
#
# Agent mode: what a shell exports when no human is watching.
#
# Every case runs through a real login shell because the bug this guards
# against was a shell that *looked* configured but exported nothing.

setup() {
  load helpers/load
  require_installed_shell
  PROBE='echo "AGENT=${DOTFILES_AGENT:-unset} EDITOR=${EDITOR:-unset} PAGER=${PAGER:-unset} PROMPT=${GIT_TERMINAL_PROMPT:-unset}"'
}

@test "a known agent harness switches the shell into agent mode" {
  run clean_login_shell zsh "$PROBE" COPILOT_AGENT=1
  [ "$status" -eq 0 ]
  [[ $output == *"AGENT=1"* ]]
  [[ $output == *"EDITOR=true"* ]]
  [[ $output == *"PAGER=cat"* ]]
  [[ $output == *"PROMPT=0"* ]]
}

# Regression: these names were misspelled (COPILOT_AGENT_ID, CLAUDE_CODE), so
# detection failed open and silently inside the editor's own terminal.
@test "each supported harness variable is spelled exactly right" {
  local var
  for var in CLAUDECODE COPILOT_AGENT CURSOR_AGENT AIDER_MODEL OPENAI_CODEX; do
    run clean_login_shell zsh "$PROBE" "$var=1"
    [[ $output == *"AGENT=1"* ]] || {
      echo "$var did not trigger agent mode"
      return 1
    }
  done
}

@test "CI switches the shell into agent mode" {
  run clean_login_shell zsh "$PROBE" CI=true
  [[ $output == *"AGENT=1"* ]]
}

@test "a dumb terminal switches the shell into agent mode" {
  run clean_login_shell zsh "$PROBE" TERM=dumb
  [[ $output == *"AGENT=1"* ]]
}

@test "DOTFILES_AGENT=0 opts out even inside a harness" {
  run clean_login_shell zsh "$PROBE" COPILOT_AGENT=1 DOTFILES_AGENT=0
  [[ $output == *"EDITOR=vim"* ]]
}

@test "DOTFILES_AGENT=1 opts in with no other signal present" {
  run clean_login_shell zsh "$PROBE" DOTFILES_AGENT=1
  [[ $output == *"EDITOR=true"* ]]
}

@test "bash agrees with zsh about agent mode" {
  run clean_login_shell bash "$PROBE" COPILOT_AGENT=1
  [[ $output == *"AGENT=1"* ]]
  [[ $output == *"EDITOR=true"* ]]
}

@test "agent mode never leaves an editor that can block a commit" {
  run clean_login_shell zsh 'echo "${GIT_EDITOR:-unset}|${VISUAL:-unset}|${BROWSER:-unset}"' COPILOT_AGENT=1
  [ "$output" = "true|true|true" ]
}
