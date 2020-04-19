#!/bin/user/env bash

OH_MY_ZSH_CUSTOM="$DOTFILES_PATH/modules/oh-my-zsh/custom"
FZF="$DOTFILES_PATH/modules/fzf"
NAVI="$DOTFILES_PATH/bin/external"

install_linux_custom() {
  log::note "📦 Installing snap packages..."
  sudo snap install code --classic
  sudo snap install intellij-idea-ultimate --classic
  sudo snap install webstorm --classic

  log::note "📦 Installing apt packages..."
  sudo apt install fzf

  log::note "📦 Installing external packages..."
  _install_navi
}

remember_install() {
  log::warning "CHEAT -> https://github.com/cheat/cheat"
  log::warning "EXA -> https://github.com/ogham/exa"
  log::warning "LAZYDOCKER -> https://github.com/jesseduffield/lazydocker"
}

install_oh_my_zsh_plugins() {
  rm -rf "$OH_MY_ZSH_CUSTOM/plugins/zsh-autosuggestions" || true
  git::clone_if_not_exists https://github.com/zsh-users/zsh-autosuggestions "$OH_MY_ZSH_CUSTOM/plugins/zsh-autosuggestions"
  rm -rf "$OH_MY_ZSH_CUSTOM/plugins/zsh-syntax-highlighting" || true
  git::clone_if_not_exists https://github.com/zsh-users/zsh-syntax-highlighting.git "$OH_MY_ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
  rm -rf "$OH_MY_ZSH_CUSTOM/plugins/you-should-use" || true
  git::clone_if_not_exists https://github.com/MichaelAquilina/zsh-you-should-use.git "$OH_MY_ZSH_CUSTOM/plugins/you-should-use"
}

_install_navi() {
  rm -rf "$NAVI/navi" || true
  BIN_DIR=$NAVI bash <(curl -sL https://raw.githubusercontent.com/denisidoro/navi/master/scripts/install)
}

