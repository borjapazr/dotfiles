dot::script_exists() {
  [[ -x "${1}/scripts/${2}/${3}" ]]
}

dot::list_contexts() {
  /bin/ls "$DOTFILES_PATH/scripts" | grep -v core | sort -u
}

dot::list_context_scripts() {
  /bin/ls -p "$DOTFILES_PATH/scripts/$1" 2>/dev/null | grep -v '/' | sort -u
}

dot::list_scripts() {
  _list_scripts() {
    scripts=$(dot::list_context_scripts "$1" | xargs -I_ echo "dot $1 _")

    echo "$scripts"
  }

  dot::list_contexts | coll::map _list_scripts
}

dot::list_scripts_path() {
  find "$DOTFILES_PATH/scripts" -maxdepth 2 -perm /+111 -type f | grep -v "$DOTFILES_PATH/scripts/core" | sort -u
}

dot::list_bash_files() {
  grep '#!/usr/bin/env bash' "$DOTFILES_PATH"/{bin,scripts,shell,installer} -R | awk -F':' '{print $1}'
  find "$DOTFILES_PATH"/{bin,scripts,shell} -type f -name "*.sh"
}
