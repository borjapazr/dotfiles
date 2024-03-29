PROMPT_COMMAND="mrmars_theme"

CYAN_COLOR="36"
BLUE_COLOR="34"
YELLOW_COLOR="33"
GREEN_COLOR="32"
RED_COLOR="31"

ROOT_EMOJI=""
if [[ $USER == 'root' ]]; then
  ROOT_EMOJI="✨"
fi
REMOTE_EMOJI=""
if [[ -n "$SSH_CLIENT" ]] || [[ -n "$SSH_TTY" ]]; then
  REMOTE_EMOJI="☁️ "
fi

mrmars_theme() {
  LAST_CODE="$?"
  CURRENT_DIR=$(dot filesystem short_pwd)
  STATUS_COLOR=$GREEN_COLOR

  if [ $LAST_CODE -ne 0 ]; then
    STATUS_COLOR=$RED_COLOR
  fi

  export PS1="\[\e[1m\]\[\e[${STATUS_COLOR}m\][\[\e[${YELLOW_COLOR}m\]m\[\e[${GREEN_COLOR}m\]a\[\e[${RED_COLOR}m\]r\[\e[${BLUE_COLOR}m\]s\[\e[${STATUS_COLOR}m\]]\[\e[m\]\[\e[m\]${REMOTE_EMOJI}${ROOT_EMOJI} \[\e[1m\]\[\e[${CYAN_COLOR}m\]${CURRENT_DIR}\[\e[m\]\[\e[m\] "

}
