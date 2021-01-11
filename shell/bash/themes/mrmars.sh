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

mrmars_theme() {
  LAST_CODE="$?"
  CURRENT_DIR=$(dot filesystem short_pwd)
  STATUS_COLOR=$GREEN_COLOR

  if [ $LAST_CODE -ne 0 ]; then
    STATUS_COLOR=$RED_COLOR
  fi

  export PS1="\[\e[1m\]\[\e[${STATUS_COLOR}m\][\[\e[${YELLOW_COLOR}m\]s\[\e[${GREEN_COLOR}m\]r\[\e[${RED_COLOR}m\]a\[\e[${BLUE_COLOR}m\]m\[\e[${STATUS_COLOR}m\]]\[\e[m\]\[\e[m\]${REMOTE_EMOJI}${ROOT_EMOJI} \[\e[1m\]\[\e[${CYAN_COLOR}m\]${CURRENT_DIR}\[\e[m\]\[\e[m\] "

}
