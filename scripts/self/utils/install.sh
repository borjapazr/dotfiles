source "$DOTFILES_PATH/scripts/self/recipes/_main.sh"

install_requirements() {
  log::info "📦 Setting up common requirements"
  _install_common_requirements

  if platform::is_linux; then
    log::info "🐧 Setting up Linux platform"
    _install_linux_requirements
  elif platform::is_macos; then
    log::info "🍎 Setting up MacOS platform"
    _install_macos_requirements
  fi
}

_install_common_requirements() {
  recipes::install brew
  recipes::install docker
  recipes::install podman
}

_install_macos_requirements() {
  _install_brew_package() {
    brew install $1 2>&1 | log::file "📦 Installing brew $1"
  }

  log::info "🐐 Installing needed GNU packages"
  _install_brew_package bash
  _install_brew_package zsh
  _install_brew_package coreutils
  _install_brew_package make
  _install_brew_package gnu-sed
  _install_brew_package findutils
  _install_brew_package bat
  _install_brew_package hyperfine

  log::info "🍎 Installing mas"
  _install_brew_package mas
}

_install_linux_requirements() {
  _install_apt_package() {
    sudo apt-get install -y $1 2>&1 | log::file "📦 Installing apt $1"
  }

  if platform::command_exists apt-mark; then
    _install_apt_package zsh
    _install_apt_package gcc
  fi
}
