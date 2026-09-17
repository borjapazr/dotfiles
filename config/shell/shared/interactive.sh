#!/usr/bin/env bash
# ═════════════════════════════════════════════════════════════════════════════
# interactive.sh — sourced ONLY by interactive shells (.zshrc / .bashrc).
#
# Everything that changes the behaviour of standard commands lives below this
# line: aliases that shadow coreutils, convenience functions, tool UIs, prompt
# hooks. Keeping it out of env.sh is what makes `bash -lc ls` return the real
# `ls` for CI runners and AI agent harnesses.
#
# This file only orchestrates. Add behaviour to interactive/aliases/,
# interactive/functions/ or interactive/tools/, never here.
# ═════════════════════════════════════════════════════════════════════════════

# Defensive: never run this layer in a non-interactive shell, even if something
# sources it by mistake.
case $- in
*i*) ;;
*) return 0 ;;
esac

# `bash -i` without login never reads .bash_profile, so this is the only place
# that can set up the environment for that shell. That shell also arrives with
# $DOTFILES_PATH unset, hence the fallback; env.sh exports it and is idempotent.
. "${DOTFILES_PATH:-$HOME/.dotfiles}/config/shell/shared/env.sh"

# Alphabetical: aliases, functions, tools. Number the dirs if order ever matters.
for _dotfiles_file in "$DOTFILES_PATH"/config/shell/shared/interactive/*/*.sh; do
  [ -r "$_dotfiles_file" ] && . "$_dotfiles_file"
done
unset _dotfiles_file

# Machine-local interactive overrides (optional, gitignored).
[ -f "$DOTFILES_PATH/config/shell/local.interactive.sh" ] &&
  . "$DOTFILES_PATH/config/shell/local.interactive.sh"

return 0
