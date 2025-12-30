source "$DOTFILES_PATH/scripts/self/recipes/_main.sh"

update_dotfiles() {
  cd "$DOTFILES_PATH" || exit

  git pull
  git submodule init
  git submodule update
  git submodule status
  git submodule update --init --recursive
  git submodule update --init --recursive --remote
  git submodule update --init --recursive --remote --merge
}

update_system() {
  if platform::is_linux; then
    log::info "🔁 Updating Linux platform"
    _update_linux 2>&1 | log::file "🔁 Updating Linux platform"
  elif platform::is_macos; then
    log::info "🔁 Updating MacOS platform"
    _update_macos 2>&1 | log::file "🔁 Updating MacOS platform"
  elif platform::is_wsl; then
    log::info"🔁 Updating WSL platform"
    _update_wsl 2>&1 | log::file "🔁 Updating WSL platform"
  fi
}

_update_macos() {
  if platform::command_exists brew; then
    brew update && brew upgrade && brew upgrade --cask && brew cleanup
  fi
}

_update_linux() {
  if platform::command_exists apt-mark; then
    sudo apt-get update -y
    sudo apt-get upgrade -y
    sudo apt-get autoremove -y
  fi
  if platform::command_exists snap; then
    sudo snap refresh
  fi
  if platform::command_exists brew; then
    brew update && brew upgrade && brew cleanup
  fi
}

_update_wsl() {
  if platform::command_exists apt-mark; then
    sudo apt-get update -y
    sudo apt-get upgrade -y
    sudo apt-get autoremove -y
  fi
  if platform::command_exists snap; then
    sudo snap refresh
  fi
  if platform::command_exists brew; then
    brew update && brew upgrade && brew cleanup
  fi
}
