ROOT_EMOJI=""
if [[ $USER == 'root' ]]; then
  ROOT_EMOJI="✨"
fi
REMOTE_EMOJI=""
if [[ $IS_SSH_CONNECTION == 1 ]]; then
  REMOTE_EMOJI="☁️ "
fi

PROMPT="%(?:%{$fg_bold[green]%}[%{$fg_bold[blue]%}m%{$fg_bold[red]%}a%{$fg_bold[green]%}r%{$fg_bold[yellow]%}s%{$fg_bold[green]%}]:%{$fg_bold[red]%}[%{$fg_bold[blue]%}m%{$fg_bold[red]%}a%{$fg_bold[green]%}r%{$fg_bold[yellow]%}s%{$fg_bold[red]%}])"
PROMPT+='${REMOTE_EMOJI}${ROOT_EMOJI} %{$fg[cyan]%}$(dot filesystem short_pwd)%{$reset_color%} $(git_prompt_info)'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"