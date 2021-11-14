DOTFILES_LOG_FILE=${DOTFILES_LOG_FILE:-$HOME/dotfiles.log}

log::ansi() {
  local bg=false
  case "$@" in
  *reset*)
    echo "\e[0m"
    return 0
    ;;
  *black*) color=30 ;;
  *red*) color=31 ;;
  *green*) color=32 ;;
  *yellow*) color=33 ;;
  *blue*) color=34 ;;
  *purple*) color=35 ;;
  *cyan*) color=36 ;;
  *white*) color=37 ;;
  esac
  case "$@" in
  *regular*) mod=0 ;;
  *bold*) mod=1 ;;
  *underline*) mod=4 ;;
  esac
  case "$@" in
  *background*) bg=true ;;
  *bg*) bg=true ;;
  esac

  if $bg; then
    echo "\e[${color}m"
  else
    echo "\e[${mod:-0};${color}m"
  fi
}

_log() {
  local template=$1
  shift
  echo -e "$(printf "$template" "$@")"
}

log::success() { _log "$(log::ansi green)✔ %s$(log::ansi reset)\n" "$@"; }
log::error() { _log "$(log::ansi red)✖ %s$(log::ansi reset)\n" "$@"; }
log::info() { _log "➜ $(log::ansi cyan)%s$(log::ansi reset)\n" "$@"; }
log::file() {
  local -r log_name="$1"
  local -r current_date=$(date "+%Y-%m-%d %H:%M:%S")

  touch "$DOTFILES_LOG_FILE"
  echo "----- $current_date - $log_name -----" >>"$DOTFILES_LOG_FILE"

  while IFS= read -r log_message; do
    echo "$log_message" >>"$DOTFILES_LOG_FILE"
  done

  echo "" >>"$DOTFILES_LOG_FILE"
}
