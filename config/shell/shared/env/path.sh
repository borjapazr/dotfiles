#!/usr/bin/env bash
# path.sh — $PATH construction. Composed by env.sh; not an entry point.
# Requires bash or zsh (uses ${var//pattern/repl} to stay fork-free).

# Prepend directory to $PATH. No per-entry existence check on purpose: stat'ing
# every candidate is costly under endpoint security (Defender), and non-existent
# directories in $PATH are harmless. The already-present check is a plain string
# match — no fork, no stat.
_pathadd() {
  case ":$PATH:" in
  *":$1:"*) ;;
  *) PATH="$1${PATH:+":$PATH"}" ;;
  esac
}

# Remove a directory from $PATH. Same fork-free string surgery as _pathadd; also
# collapses any duplicate occurrences of $1.
_pathdel() {
  case ":$PATH:" in
  *":$1:"*)
    PATH=":$PATH:"
    PATH=${PATH//":$1:"/":"}
    PATH=${PATH#:}
    PATH=${PATH%:}
    ;;
  esac
}

# Entries are prepended in order, so the LAST one listed ends up FIRST in $PATH.
_dotfiles_path_entries=(
  "/sbin"
  "/usr/bin"
  "/bin"
  "/usr/local/bin"
  "$HOME/.local/bin"
  "/home/linuxbrew/.linuxbrew/bin"
  "/home/linuxbrew/.linuxbrew/sbin"
  "$HOMEBREW_PREFIX/bin"
  "$HOMEBREW_PREFIX/sbin"
  "$HOME/.composer/vendor/bin"
  "$HOME/.config/composer/vendor/bin"
  "${GOBIN:-$HOME/.go/bin}"
  "$HOME/.rd/bin"
  "$HOME/bin"
  "${ASDF_DATA_DIR:-$HOME/.asdf}/shims"
  "$DOTFILES_PATH/bin"
)

# Delete before prepending so this list — not whatever seeded $PATH first —
# decides the order, and so re-sourcing is idempotent (nested shells inherit
# $PATH and re-source this file). Without the delete, macOS's path_helper keeps
# /etc/paths.d/homebrew ahead of the asdf shims and behind /usr/bin, so `python3`
# resolved to brew while `python` came from asdf.
for _dotfiles_path_entry in "${_dotfiles_path_entries[@]}"; do
  _pathdel "$_dotfiles_path_entry"
  _pathadd "$_dotfiles_path_entry"
done
unset _dotfiles_path_entry _dotfiles_path_entries

export PATH
