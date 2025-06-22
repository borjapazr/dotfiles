source "$DOTFILES_PATH/scripts/core/_main.sh"

# fzf key bindings
source "$(brew --prefix)/opt/fzf/shell/key-bindings.zsh"
[[ $- == *i* ]] && source "$(brew --prefix)/opt/fzf/shell/completion.zsh" 2>/dev/null

# navi key bindings
eval "$(navi widget zsh)"

# CTRL+E - Paste the selected dot command from dot commands into the command line
fzf_show_dot_commands() {
  LBUFFER=$("$DOTFILES_PATH/bin/dot" -p)
  zle redisplay
}
zle -N fzf_show_dot_commands
bindkey '^E' fzf_show_dot_commands
