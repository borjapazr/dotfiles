#!/bin/user/env bash

source "$DOTFILES_PATH/scripts/self/recipes/_main.sh"

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

  log::note "📦 Installing recipes..."
  recipes::install

  if platform::command_exists brew; then
    log::note "📦 Installing Homebrew packages..."
    # All apps (This line is 2 times because there are dependencies between brew cask and brew)
    "$HOMEBREW_BIN/brew" bundle --file="$DOTFILES_PATH/os/ubuntu/packages/Brewfile" || true
    "$HOMEBREW_BIN/brew" bundle --file="$DOTFILES_PATH/os/ubuntu/packages/Brewfile"
  fi
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
