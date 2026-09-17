# fzf key bindings and completion. $HOMEBREW_PREFIX is set fork-free by .zshenv,
# so this avoids two `brew --prefix` subshells on every interactive startup.
if [[ -r ${HOMEBREW_PREFIX}/opt/fzf/shell/key-bindings.zsh ]]; then
  source "${HOMEBREW_PREFIX}/opt/fzf/shell/key-bindings.zsh"
  source "${HOMEBREW_PREFIX}/opt/fzf/shell/completion.zsh"
fi

# navi key bindings
(( $+commands[navi] )) && eval "$(navi widget zsh)"

# CTRL+E - Paste the selected dot command from dot commands into the command line
fzf_show_dot_commands() {
  LBUFFER=$("$DOTFILES_PATH/bin/dot" -p)
  zle redisplay
}
zle -N fzf_show_dot_commands
bindkey '^E' fzf_show_dot_commands

# zsh-users/zsh-history-substring-search
for key ('^[[A' '^P' ${terminfo[kcuu1]}) bindkey ${key} history-substring-search-up
for key ('^[[B' '^N' ${terminfo[kcud1]}) bindkey ${key} history-substring-search-down
for key ('k') bindkey -M vicmd ${key} history-substring-search-up
for key ('j') bindkey -M vicmd ${key} history-substring-search-down
unset key
