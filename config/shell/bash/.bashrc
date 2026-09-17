# Bail out early for non-interactive shells: everything below shadows standard
# commands and is only meant for a human at a prompt.
case $- in
*i*) ;;
*) return 0 ;;
esac

source "${DOTFILES_PATH:-$HOME/.dotfiles}/config/shell/shared/interactive.sh"

# ─── Right-aligned prompt ────────────────────────────────────────────────────
__right_prompt() {
  local right_prompt="${RPS1:-$RPROMPT}"
  [ -n "$right_prompt" ] || return 0
  printf "%$((COLUMNS - ${#right_prompt}))s%s\\r" "" "$right_prompt"
}
PROMPT_COMMAND="__right_prompt"

# ─── Theme ───────────────────────────────────────────────────────────────────
[ -r "$DOTFILES_PATH/config/shell/bash/themes/mrmars.sh" ] &&
  source "$DOTFILES_PATH/config/shell/bash/themes/mrmars.sh"

# ─── Completions ─────────────────────────────────────────────────────────────
for bash_file in "$DOTFILES_PATH"/config/shell/bash/completions/_*; do
  [ -r "$bash_file" ] && source "$bash_file"
done
unset bash_file
