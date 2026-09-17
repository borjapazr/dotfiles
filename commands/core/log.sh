DOTFILES_LOG_FILE=${DOTFILES_LOG_FILE:-$HOME/dotfiles.log}

# Colour only when a human is looking at a terminal. Escape codes in captured
# output corrupt diffs, greps and anything an agent or CI job tries to parse;
# NO_COLOR is the cross-tool convention for opting out.
log::use_color() {
  [[ -z ${NO_COLOR:-} && ${DOTFILES_AGENT:-0} != 1 && -t 2 ]]
}

log::ansi() {
  log::use_color || return 0

  local bg=false
  local color=37
  local mod=0

  case "$*" in
  *reset*)
    printf '\033[0m'
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

  case "$*" in
  *regular*) mod=0 ;;
  *bold*) mod=1 ;;
  *underline*) mod=4 ;;
  esac

  case "$*" in
  *background* | *bg*) bg=true ;;
  esac

  if $bg; then
    printf '\033[%sm' "$color"
  else
    printf '\033[%s;%sm' "$mod" "$color"
  fi
}

# Diagnostics go to stderr so they never pollute a command's real output —
# `dot --json | jq` must not have a success message spliced into the JSON.
# %s rather than an interpolated format string: a message containing a literal
# `%s` would otherwise consume the next argument or print garbage.
_log() {
  local prefix=$1 color=$2
  shift 2
  printf '%s%s%s%s\n' "$(log::ansi "$color")" "$prefix" "$*" "$(log::ansi reset)" >&2
}

log::success() { _log '✔ ' green "$@"; }
log::error() { _log '✖ ' red "$@"; }
log::warn() { _log '⚠ ' yellow "$@"; }
log::info() { _log '➜ ' cyan "$@"; }

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
