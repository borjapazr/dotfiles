local root_emoji
if [[ $USER == 'root' ]]; then
  root_emoji="✨"
fi
local cloud_emoji
if [[ -n $SSH_CONNECTION ]]; then
  cloud_emoji="☁️ "
fi

PROMPT="%(?:%{$fg_bold[green]%}[%{$fg_bold[blue]%}m%{$fg_bold[red]%}a%{$fg_bold[green]%}r%{$fg_bold[yellow]%}s%{$fg_bold[green]%}]:%{$fg_bold[red]%}[%{$fg_bold[blue]%}m%{$fg_bold[red]%}a%{$fg_bold[green]%}r%{$fg_bold[yellow]%}s%{$fg_bold[red]%}])"
PROMPT+='$cloud_emoji$root_emoji %{$fg[cyan]%}$(dot filesystem short_pwd)%{$reset_color%} $(git_prompt_info)'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"