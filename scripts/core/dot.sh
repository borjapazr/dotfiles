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

# Every *.sh plus every file whose first line is a bash shebang, in any of its
# spellings. `private-*` is pruned on purpose: shellcheck quotes the offending
# line and `shfmt -d` prints a diff, so linting the secrets file would print its
# contents to stdout and into CI logs.
dot::list_bash_files() {
  local file shebang

  find "$DOTFILES_PATH"/{bin,scripts,dots/shell,installer} \
    \( -name .zim -o -name 'private-*' \) -prune -o -type f -print 2>/dev/null |
    while IFS= read -r file; do
      case $file in
      *.zwc | *.zwc.old | *.bak) continue ;;
      *.sh)
        printf '%s\n' "$file"
        continue
        ;;
      esac

      IFS= read -r shebang <"$file" 2>/dev/null || continue

      case $shebang in
      '#!'*bash*) printf '%s\n' "$file" ;;
      esac
    done | sort -u
}
