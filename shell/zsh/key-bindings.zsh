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

# zsh-users/zsh-history-substring-search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
