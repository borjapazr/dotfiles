#!/bin/user/env bash

DOTBOT_DIR="modules/dotbot"
DOTBOT_BIN="bin/dotbot"

self_update() {
  cd "$DOTFILES_PATH" || exit
  git fetch
  if [[ $(_project_status) == "behind" ]]; then
    log::note "⤵️ .dotfiles needs to pull!"
    git pull && exit 0 || log::error "❌ Failed trying to pull .dotfiles"
  fi
}

update_submodules() {
  cd "$DOTFILES_PATH" || exit

  git pull
  git submodule init
  git submodule update
  git submodule status
  git submodule update --init --recursive
}

apply_common_symlinks() {
  _apply_symlinks "common.yml"
}

ubuntu::update() {
  sudo apt update -y
  #sudo apt upgrade -y
  #sudo apt autoremove -y
  #sudo snap refresh
}

_apply_symlinks() {
  local -r CONFIG="$DOTFILES_PATH/links/$1"
  shift
  echo
  "$DOTFILES_PATH/$DOTBOT_DIR/$DOTBOT_BIN" -d "$DOTFILES_PATH" -c "$CONFIG" "$@"
  echo
}

_project_status() {
  cd "$DOTFILES_PATH" || exit

  local -r UPSTREAM="master"
  local -r LOCAL=$(git rev-parse @)
  local -r REMOTE=$(git rev-parse "$UPSTREAM")
  local -r BASE=$(git merge-base @ "$UPSTREAM")

  if [[ "$LOCAL" == "$REMOTE" ]]; then
    echo "synced"
  elif [[ "$LOCAL" == "$BASE" ]]; then
    echo "behind"
  elif [[ "$REMOTE" == "$BASE" ]]; then
    echo "ahead"
  else
    echo "diverged"
  fi
}