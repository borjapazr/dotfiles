if ! ${DOT_MAIN_SOURCED:-false}; then
  # Derive the repo root from this file rather than trusting the environment:
  # a script invoked by absolute path from cron, an editor task or an AI agent
  # gets no $DOTFILES_PATH, and every `source` below would then silently fail.
  if [[ -z ${DOTFILES_PATH:-} ]]; then
    if [[ -n ${BASH_SOURCE[0]:-} ]]; then
      DOTFILES_PATH="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/../.." && pwd)"
    else
      # zsh has no BASH_SOURCE; `${(%):-%x}` is its equivalent. It lives inside
      # an eval of a fixed literal so bash-oriented linters (shellcheck, shfmt)
      # never have to parse a zsh-only expansion flag.
      eval 'DOTFILES_PATH="$(cd -- "$(dirname -- "${(%):-%x}")/../.." && pwd)"'
    fi
    export DOTFILES_PATH
  fi

  for file in "$DOTFILES_PATH"/commands/core/{args,docs,dot,git,log,platform}.sh; do
    # shellcheck source=/dev/null
    source "$file"
  done
  unset file

  # zsh sources this file too (the completion script does), and neither
  # `errtrace` nor a bash-style ERR trap exist there.
  if [[ -n ${BASH_VERSION:-} ]]; then
    # Report where a `set -e` script actually died. Without this the shell exits
    # silently and the caller only sees a non-zero status.
    dot::on_error() {
      local exit_code=$1 line=$2 command=$3
      # Only scripts running under `set -e` are about to die here. Linters and
      # validators deliberately run without errexit and let commands fail, so
      # reporting those would turn normal output into noise.
      case $- in
      *e*) ;;
      *) return 0 ;;
      esac
      # An explicit `return N` is a deliberate failure the function already
      # reported; anything else is an unexpected command failure worth locating.
      case $command in
      return*) exit "$exit_code" ;;
      esac
      # Negative array indices need bash 4.3; macOS ships 3.2.
      local -r top=${BASH_SOURCE[$((${#BASH_SOURCE[@]} - 1))]}
      log::error "${top##*/}:${line}: \`${command}\` failed (exit ${exit_code})"
      exit "$exit_code"
    }
    set -o errtrace
    trap 'dot::on_error "$?" "$LINENO" "$BASH_COMMAND"' ERR
  fi

  readonly DOT_MAIN_SOURCED=true
fi
