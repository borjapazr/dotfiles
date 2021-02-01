#!/bin/user/env bash

DOTBOT_DIR="modules/dotbot"
DOTBOT_BIN="bin/dotbot"
OH_MY_ZSH_CUSTOM="$DOTFILES_PATH/modules/oh-my-zsh/custom"

generic::install_npm_packages() {
  xargs -a <(awk '! /^ *(#|$)/' "$DOTFILES_PATH/langs/js/npm") -r -- sudo npm install -g || true
}

generic::install_ohmyzsh_plugins() {
  rm -rf "$OH_MY_ZSH_CUSTOM/plugins/zsh-autosuggestions" || true
  git::clone_if_not_exists https://github.com/zsh-users/zsh-autosuggestions "$OH_MY_ZSH_CUSTOM/plugins/zsh-autosuggestions"
  rm -rf "$OH_MY_ZSH_CUSTOM/plugins/zsh-syntax-highlighting" || true
  git::clone_if_not_exists https://github.com/zsh-users/zsh-syntax-highlighting.git "$OH_MY_ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
  rm -rf "$OH_MY_ZSH_CUSTOM/plugins/fast-syntax-highlighting" || true
  git::clone_if_not_exists https://github.com/zdharma/fast-syntax-highlighting.git "$OH_MY_ZSH_CUSTOM/plugins/fast-syntax-highlighting"
  rm -rf "$OH_MY_ZSH_CUSTOM/plugins/you-should-use" || true
  git::clone_if_not_exists https://github.com/MichaelAquilina/zsh-you-should-use.git "$OH_MY_ZSH_CUSTOM/plugins/you-should-use"
  rm -rf "$OH_MY_ZSH_CUSTOM/plugins/forgit" || true
  git::clone_if_not_exists https://github.com/wfxr/forgit.git "$OH_MY_ZSH_CUSTOM/plugins/forgit"
}

generic::self_update() {
  cd "$DOTFILES_PATH" || exit
  git fetch
  if [[ $(_project_status) == "behind" ]]; then
    log::note "⤵️ .dotfiles needs to pull!"
    git pull && exit 0 || log::error "❌ Failed trying to pull .dotfiles!"
  fi
}

generic::update_submodules() {
  cd "$DOTFILES_PATH" || exit

  git pull
  git submodule init
  git submodule update
  git submodule status
  git submodule update --init --recursive
}

generic::apply_common_symlinks() {
  _apply_symlinks "common.yml"
  touch "$HOME/.z"
}

generic::create_private_files() {
  touch "$DOTFILES_PATH/shell/private-stuff.sh"
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

  local -r UPSTREAM="main"
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
