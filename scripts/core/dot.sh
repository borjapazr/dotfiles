#!/usr/bin/env bash

dot::script_exist() {
  [[ -x "${1}/scripts/${2}/${3}" ]]
}

dot::list_scripts_path() {
  find "$DOTFILES_PATH/scripts" -maxdepth 2 -executable -type f \
      | grep -v "$DOTFILES_PATH/scripts/core" \
      | sort
}