platform::command_exists() {
  command -v "$1" >/dev/null 2>&1
}

# Fail fast, with the missing tool named, instead of letting the script die
# later on a cryptic "command not found".
platform::require() {
  local cmd missing=()

  for cmd in "$@"; do
    platform::command_exists "$cmd" || missing+=("$cmd")
  done

  if [[ ${#missing[@]} -gt 0 ]]; then
    log::error "Missing required $([[ ${#missing[@]} -eq 1 ]] && echo dependency || echo dependencies): ${missing[*]}"
    return 1
  fi
}

# `uname` is a fork; every is_* predicate below would pay for it on each call.
platform::uname_s() {
  printf '%s' "${_DOTFILES_UNAME_S:=$(uname -s)}"
}

platform::is_macos() {
  [[ $(platform::uname_s) == "Darwin" ]]
}

platform::is_macos_arm() {
  platform::is_macos && [[ ${_DOTFILES_UNAME_M:=$(uname -m)} == arm64 ]]
}

platform::is_linux() {
  [[ $(platform::uname_s) == "Linux" ]]
}

platform::is_linux_desktop() {
  platform::is_linux && [[ -n ${DESKTOP_SESSION:-} ]]
}

platform::is_wsl() {
  [[ -r /proc/version ]] && grep -qEi "(microsoft|wsl)" /proc/version
}

platform::wsl_home_path() {
  wslpath "$(wslvar USERPROFILE 2>/dev/null)"
}
