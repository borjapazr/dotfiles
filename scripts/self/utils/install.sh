#!/bin/user/env bash

OH_MY_ZSH_CUSTOM="$DOTFILES_PATH/modules/oh-my-zsh/custom"
EXTERNAL_BIN="$DOTFILES_PATH/bin/external"

ubuntu::add_repositories() {
  log::note "📥 Adding PPA repositories..."
  xargs -a <(awk '! /^ *(#|$)/' "$DOTFILES_PATH/os/ubuntu/repositories/ppa") -r -- sudo add-apt-repository -y
}

ubuntu::install_tools() {
  log::note "📦 Installing snap packages..."
  grep -vE "^(\s*$|#)" "$DOTFILES_PATH/os/ubuntu/packages/snap" | while read line; do
    sudo snap install $line
  done

  log::note "📦 Installing apt packages..."
  xargs -a <(awk '! /^ *(#|$)/' "$DOTFILES_PATH/os/ubuntu/packages/apt") -r -- sudo apt-get install -y

  log::note "📦 Installing external packages..."
  _install_navi
  _install_lazydocker
  _install_exa
}

ubuntu::configure_tools() {
  log::note "⚙️ Configuring tools..."
  _configure_docker
}

ubuntu::install_manually() {
  log::warning "Nothing at the moment!"
}

langs::install_npm_packages() {
  xargs -a <(awk '! /^ *(#|$)/' "$DOTFILES_PATH/langs/js/npm") -r -- sudo npm install -g || true
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
  rm -rf "$EXTERNAL_BIN/navi" || true
  BIN_DIR=$EXTERNAL_BIN bash <(curl -sL https://raw.githubusercontent.com/denisidoro/navi/master/scripts/install)
}

_install_lazydocker() {
  rm -rf "$EXTERNAL_BIN/lazydocker" || true
  curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | DIR=$EXTERNAL_BIN bash
}

_install_exa() {
  rm -rf "$EXTERNAL_BIN/exa" || true
  cargo install --root=$EXTERNAL_BIN exa
  mv "$EXTERNAL_BIN/bin/exa" $EXTERNAL_BIN
  rm -rf $EXTERNAL_BIN/bin
}

_configure_docker() {
  # sudo groupadd docker
  sudo gpasswd -a $USER docker
  sudo service docker restart
}