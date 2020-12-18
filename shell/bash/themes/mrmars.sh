PROMPT_COMMAND="mrmars_theme"

CYAN_COLOR="36"
BLUE_COLOR="34"
YELLOW_COLOR="33"
GREEN_COLOR="32"
RED_COLOR="31"

mrmars_theme() {
  local root_emoji
  if [[ $USER == 'root' ]]; then
    root_emoji="✨"
  fi
  local cloud_emoji
  if [[ -n $SSH_CONNECTION ]]; then
    cloud_emoji="☁️ "
  fi

  LAST_CODE="$?"
  CURRENT_DIR=$(dot filesystem short_pwd)
  STATUS_COLOR=$GREEN_COLOR

  if [ $LAST_CODE -ne 0 ]; then
    STATUS_COLOR=$RED_COLOR
  fi

  export PS1="\[\e[1m\]\[\e[${STATUS_COLOR}m\][\[\e[${YELLOW_COLOR}m\]s\[\e[${GREEN_COLOR}m\]r\[\e[${RED_COLOR}m\]a\[\e[${BLUE_COLOR}m\]m\[\e[${STATUS_COLOR}m\]]\[\e[m\]\[\e[m\]$cloud_emoji$root_emoji \[\e[1m\]\[\e[${CYAN_COLOR}m\]${CURRENT_DIR}\[\e[m\]\[\e[m\] "

}
