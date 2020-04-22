#!/bin/user/env bash

OH_MY_ZSH_CUSTOM="$DOTFILES_PATH/modules/oh-my-zsh/custom"
NAVI_BIN="$DOTFILES_PATH/bin/external"

ubuntu::add_repositories() {
  log::note "📥 Adding PPA repositories..."
  xargs -a <(awk '! /^ *(#|$)/' "$DOTFILES_PATH/ubuntu/repositories/ppa") -r -- sudo add-apt-repository -y
}

ubuntu::install_tools() {
  log::note "📦 Installing snap packages..."
  grep -vE "^(\s*$|#)" "$DOTFILES_PATH/ubuntu/packages/snap" | while read line; do
    sudo snap install $line
  done

  log::note "📦 Installing apt packages..."
  xargs -a <(awk '! /^ *(#|$)/' "$DOTFILES_PATH/ubuntu/packages/apt") -r -- sudo apt-get install -y

  log::note "📦 Installing external packages..."
  _install_navi
}

ubuntu::configure_tools() {
  log::note "⚙️ Configuring tools..."
  _configure_docker
}

ubuntu::install_manually() {
  log::warning "CHEAT -> https://github.com/cheat/cheat"
  log::warning "EXA -> https://github.com/ogham/exa"
  log::warning "LAZYDOCKER -> https://github.com/jesseduffield/lazydocker"
}

langs::install_npm_packages() {
  xargs -a <(awk '! /^ *(#|$)/' "$DOTFILES_PATH/langs/js/npm") -r -- sudo npm install -g
}

oh_my_zsh::install_plugins() {
  rm -rf "$OH_MY_ZSH_CUSTOM/plugins/zsh-autosuggestions" || true
  git::clone_if_not_exists https://github.com/zsh-users/zsh-autosuggestions "$OH_MY_ZSH_CUSTOM/plugins/zsh-autosuggestions"
  rm -rf "$OH_MY_ZSH_CUSTOM/plugins/zsh-syntax-highlighting" || true
  git::clone_if_not_exists https://github.com/zsh-users/zsh-syntax-highlighting.git "$OH_MY_ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
  rm -rf "$OH_MY_ZSH_CUSTOM/plugins/you-should-use" || true
  git::clone_if_not_exists https://github.com/MichaelAquilina/zsh-you-should-use.git "$OH_MY_ZSH_CUSTOM/plugins/you-should-use"
}

_install_navi() {
  rm -rf "$NAVI_BIN/navi" || true
  BIN_DIR=$NAVI_BIN bash <(curl -sL https://raw.githubusercontent.com/denisidoro/navi/master/scripts/install)
}

_configure_docker() {
  sudo systemctl enable --now docker
  sudo groupadd docker
  sudo usermod -aG docker $USER
  newgrp docker
  docker run hello-world
}