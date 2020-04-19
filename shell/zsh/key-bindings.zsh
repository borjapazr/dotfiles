__fzfcmd() {
  echo "fzf --reverse"
}

# ctrl+r - Paste the selected command from history into the command line
fzf-history-widget() {
  local selected num
  setopt localoptions noglobsubst noposixbuiltins pipefail HIST_FIND_NO_DUPS 2> /dev/null

  selected=( $(fc -rl 1 |
    FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} $FZF_DEFAULT_OPTS -n2..,.. --tiebreak=index --bind=ctrl-r:toggle-sort $FZF_CTRL_R_OPTS --query=${(qqq)LBUFFER} +m" $(__fzfcmd)) )
  local ret=$?
  if [ -n "$selected" ]; then
    num=$selected[1]
    if [ -n "$num" ]; then
      zle vi-fetch-history -n $num
    fi
  fi
  zle redisplay
  typeset -f zle-line-init >/dev/null && zle zle-line-init
  return $ret
}
zle -N fzf-history-widget
bindkey '^R' fzf-history-widget

# ctrl+g - Navi cheat sheet
_call_navi() {
  local navi_path=$(command -v navi)
  local buff="$BUFFER"
  zle kill-whole-line
  local cmd="$(NAVI_USE_FZF_ALL_INPUTS=true "$navi_path" --print <> /dev/tty)"
  zle -U "${buff}${cmd}"
}
zle -N _call_navi
bindkey '^g' _call_navi

_list_command_paths() {
  find "$DOTFILES_PATH/scripts" -maxdepth 2 -executable -type f \
      | grep -v core \
      | sort
}

_fzf_prompt() {
  local paths="$1"
  match="$(echo "$paths" |
    xargs -I % sh -c 'echo "$(basename $(dirname %)) $(basename %)"' |
    $(__fzfcmd) --height 100% --preview 'dot $(echo {} | cut -d" " -f 1) $(echo {} | cut -d" " -f 2) -h')"
  if [ -n "$match" ]; then
    LBUFFER="dot $match"
    zle -U " "
  fi
}

# ctrl+e - Paste the selected dot command from dot commands into the command line
fzf_show_dot_commands() {
  _fzf_prompt "$(_list_command_paths)"
}
zle -N fzf_show_dot_commands
bindkey '^E' fzf_show_dot_commands
