dot::script_exists() {
  [[ -x "${1}/commands/${2}/${3}" ]]
}

dot::context_exists() {
  [[ -d "${1}/commands/${2}" && ${2} != core ]]
}

dot::list_contexts() {
  local dir
  for dir in "$DOTFILES_PATH"/commands/*/; do
    dir=${dir%/}
    dir=${dir##*/}
    [[ $dir == core ]] && continue
    printf '%s\n' "$dir"
  done
}

dot::list_context_scripts() {
  local file
  for file in "$DOTFILES_PATH/commands/$1"/*; do
    [[ -f $file && -x $file ]] || continue
    printf '%s\n' "${file##*/}"
  done
}

dot::list_scripts() {
  local context script
  while IFS= read -r context; do
    while IFS= read -r script; do
      printf 'dot %s %s\n' "$context" "$script"
    done < <(dot::list_context_scripts "$context")
  done < <(dot::list_contexts)
}

# -perm -u+x rather than -perm /+111: the latter is a GNU-only spelling that
# BSD find (macOS) rejects outright.
dot::list_scripts_path() {
  find "$DOTFILES_PATH/commands" -maxdepth 2 -perm -u+x -type f |
    grep -v "$DOTFILES_PATH/commands/core" | sort -u
}

# First line of a script's ##? docblock, used as a one-line description.
dot::script_summary() {
  local file="$DOTFILES_PATH/commands/$1/$2" line
  [[ -r $file ]] || return 0
  while IFS= read -r line; do
    case $line in
    '##? Usage:'*) return 0 ;;
    '##?'?*)
      printf '%s\n' "${line#'##? '}"
      return 0
      ;;
    esac
  done <"$file"
}

# Every *.sh plus every file whose first line is a bash shebang, in any of its
# spellings. Machine-local files are pruned on purpose: shellcheck quotes the
# offending line and `shfmt -d` prints a diff, so linting the secrets file would
# print its contents to stdout and into CI logs.
dot::list_bash_files() {
  local file shebang

  find "$DOTFILES_PATH"/{bin,commands,config/shell,installer} \
    \( -name .zim -o -name 'private-*' -o -name 'local.sh' -o -name 'local.interactive.sh' \) -prune \
    -o -type f -print 2>/dev/null |
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
