source "$DOTFILES_PATH/scripts/self/recipes/_main.sh"

OH_MY_ZSH_CUSTOM="$DOTFILES_PATH/modules/oh-my-zsh/custom"

install_requirements() {
  log::info "📦 Setting up common requirements"
  _install_common_requirements

  if platform::is_linux; then
    log::info "🐧 Setting up Linux platform"
    _install_linux_requirements
  elif platform::is_macos; then
    log::info "🍎 Setting up MacOS platform"
    _install_macos_requirements
  elif platform::is_wsl; then
    log::info"🚀 Setting up WSL platform"
    _install_wsl_requirements
  fi
}

install_ohmyzsh_plugins() {
  log::info "💄 Installing oh-my-zsh plugins"

  rm -rf "$OH_MY_ZSH_CUSTOM/plugins/zsh-autosuggestions" || true
  git::clone_if_not_exists https://github.com/zsh-users/zsh-autosuggestions "$OH_MY_ZSH_CUSTOM/plugins/zsh-autosuggestions" 2>&1 | log::file "💄 Installing zsh-autosuggestions"

  rm -rf "$OH_MY_ZSH_CUSTOM/plugins/zsh-syntax-highlighting" || true
  git::clone_if_not_exists https://github.com/zsh-users/zsh-syntax-highlighting.git "$OH_MY_ZSH_CUSTOM/plugins/zsh-syntax-highlighting" 2>&1 | log::file "💄 Installing zsh-syntax-highlighting"

  rm -rf "$OH_MY_ZSH_CUSTOM/plugins/fast-syntax-highlighting" || true
  git::clone_if_not_exists https://github.com/zdharma-continuum/fast-syntax-highlighting "$OH_MY_ZSH_CUSTOM/plugins/fast-syntax-highlighting" 2>&1 | log::file "💄 Installing fast-syntax-highlighting"

  rm -rf "$OH_MY_ZSH_CUSTOM/plugins/zsh-completions" || true
  git::clone_if_not_exists https://github.com/zsh-users/zsh-completions.git "$OH_MY_ZSH_CUSTOM/plugins/zsh-completions" 2>&1 | log::file "💄 Installing zsh-completions"

  rm -rf "$OH_MY_ZSH_CUSTOM/plugins/you-should-use" || true
  git::clone_if_not_exists https://github.com/MichaelAquilina/zsh-you-should-use.git "$OH_MY_ZSH_CUSTOM/plugins/you-should-use" 2>&1 | log::file "💄 Installing you-should-use"

  rm -rf "$OH_MY_ZSH_CUSTOM/plugins/forgit" || true
  git::clone_if_not_exists https://github.com/wfxr/forgit.git "$OH_MY_ZSH_CUSTOM/plugins/forgit" 2>&1 | log::file "💄 Installing forgit"
}

_install_common_requirements() {
  recipes::install brew
  recipes::install docker
}

_install_macos_requirements() {
  _install_package() {
    brew install $1 2>&1 | log::file "📦 Installing brew $1"
  }

  log::info "🐐 Installing needed GNU packages"
  _install_package bash
  _install_package zsh
  _install_package coreutils
  _install_package make
  _install_package gnu-sed
  _install_package findutils
  _install_package bat
  _install_package hyperfine

  log::info "🍎 Installing mas"
  _install_package mas
}

_install_linux_requirements() {
  _install_apt_package() {
    sudo apt-get install -y $1 2>&1 | log::file "📦 Installing apt $1"
  }

  if platform::command_exists apt-mark; then
    _install_apt_package zsh
    _install_apt_package build-essential
    _install_apt_package gcc
  fi
}

_install_wsl_requirements() {
  _install_apt_package() {
    sudo apt-get install -y $1 2>&1 | log::file "📦 Installing apt $1"
  }

  if platform::command_exists apt-mark; then
    _install_apt_package zsh
    _install_apt_package build-essential
    _install_apt_package gcc
  fi
}
