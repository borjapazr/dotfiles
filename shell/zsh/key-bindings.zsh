source "$DOTFILES_PATH/scripts/core/_main.sh"

# fzf key bindings
source "$(brew --prefix)/opt/fzf/shell/key-bindings.zsh"
[[ $- == *i* ]] && source "$(brew --prefix)/opt/fzf/shell/completion.zsh" 2> /dev/null

# navi key bindings
eval "$(navi widget zsh)"

# dot command key bindings
_fzf_prompt() {
  local paths="$1"
  script="$(
    echo "$paths" |
      xargs -I % sh -c 'echo "$(basename $(dirname %)) $(basename %)"' |
      fzf \
        --height 50% \
        --preview '"$DOTFILES_PATH/bin/dot" $(echo {} | cut -d" " -f 1) $(echo {} | cut -d" " -f 2) -h'
  )"
  if [ -n "$script" ]; then
    LBUFFER="dot $script"
  fi
  zle redisplay
}

# CTRL+E - Paste the selected dot command from dot commands into the command line
fzf_show_dot_commands() {
  _fzf_prompt "$(dot::list_scripts_path)"
}
zle -N fzf_show_dot_commands
bindkey '^E' fzf_show_dot_commands
