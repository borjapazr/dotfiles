#!/bin/user/env bash

OH_MY_ZSH_CUSTOM="$DOTFILES_PATH/modules/oh-my-zsh/custom"
EXTERNAL_BIN="$DOTFILES_PATH/bin/external"
HOMEBREW_BIN="/home/linuxbrew/.linuxbrew/bin"

ubuntu::add_repositories() {
  log::note "📥 Adding PPA repositories..."
  grep -vE "^(\s*$|#)" "$DOTFILES_PATH/os/ubuntu/repositories/ppa" | while read line; do
    sudo add-apt-repository -y $line
  done
}

ubuntu::install_tools() {
  log::note "📦 Installing snap packages..."
  grep -vE "^(\s*$|#)" "$DOTFILES_PATH/os/ubuntu/packages/snap" | while read line; do
    sudo snap install $line
  done

  log::note "📦 Installing apt packages..."
  xargs -a <(awk '! /^ *(#|$)/' "$DOTFILES_PATH/os/ubuntu/packages/apt") -r -- sudo apt-get install -y

  if ! platform::command_exists brew; then
    log::note "📦 Installing Homebrew..."
    _install_homebrew
  fi

  log::note "📦 Installing Homebrew packages..."
  # All apps (This line is 2 times because there are dependencies between brew cask and brew)
  "$HOMEBREW_BIN/brew" bundle --file="$DOTFILES_PATH/os/ubuntu/packages/Brewfile" || true
  "$HOMEBREW_BIN/brew" bundle --file="$DOTFILES_PATH/os/ubuntu/packages/Brewfile"

  log::note "📦 Installing external packages..."
  if ! platform::command_exists google-chrome; then
    _install_google_chrome
  fi
}

ubuntu::configure_tools() {
  log::note "⚙️ Configuring tools..."
  _configure_docker
  _configure_tlp
}

ubuntu::install_manually() {
  log::warning "Nothing at the moment!"
}

ubuntu::update_system() {
  sudo apt update -y
  sudo apt upgrade -y
  sudo apt autoremove -y
  sudo snap refresh
  if platform::command_exists brew; then
    "$HOMEBREW_BIN/brew" update && brew upgrade
  fi
}

ubuntu::update_external_tools() {
  log::warning "Nothing at the moment!"
}

_install_homebrew() {
  bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  eval $("$HOMEBREW_BIN/brew" shellenv)
  "$HOMEBREW_BIN/brew" update
}

_install_google_chrome() {
  sudo wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -P /tmp
  sudo gdebi -n /tmp/google-chrome-stable_current_amd64.deb
  sudo rm -rf /tmp/google-chrome-stable_current_amd64.deb
}

_configure_docker() {
  sudo groupadd docker
  sudo gpasswd -a $USER docker
  newgrp docker
}

_configure_tlp() {
  sudo systemctl enable tlp
  sudo tlp start
}
