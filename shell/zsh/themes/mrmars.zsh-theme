ROOT_EMOJI=""
if [[ $USER == 'root' ]]; then
  ROOT_EMOJI="✨"
fi
parent_pid=$$
while [[ -z "${tty_bits-}" || $tty_bits -ne 0 ]]; do
  read initiator_name parent_pid tty_bits < <(
    awk '{ print substr($2, 2, length($2) - 2) " " $4 " " $7 }' /proc/$parent_pid/stat
  )
done
REMOTE_EMOJI=""
if [[ $initiator_name == 'sshd' ]]; then
  REMOTE_EMOJI="☁️ "
fi

PROMPT="%(?:%{$fg_bold[green]%}[%{$fg_bold[blue]%}p%{$fg_bold[red]%}l%{$fg_bold[green]%}x%{$fg_bold[yellow]%}s%{$fg_bold[green]%}]:%{$fg_bold[red]%}[%{$fg_bold[blue]%}p%{$fg_bold[red]%}l%{$fg_bold[green]%}x%{$fg_bold[yellow]%}s%{$fg_bold[red]%}])"
PROMPT+='${REMOTE_EMOJI}${ROOT_EMOJI} %{$fg[cyan]%}$(dot filesystem short_pwd)%{$reset_color%} $(git_prompt_info)'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"
