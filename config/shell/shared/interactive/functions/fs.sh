#!/usr/bin/env bash
# Filesystem helpers. Interactive shells only.

# Create a directory tree and cd into it.
mkd() {
  mkdir -p -- "$@" && cd -- "$_" || return 1
}

# Same as mkd, then open the directory in VS Code.
mkdc() {
  mkd "$@" && code . || return 1
}

# Pick a subdirectory with fzf and cd into it.
cdd() {
  command -v fzf >/dev/null 2>&1 || {
    echo "cdd: fzf is not installed" >&2
    return 1
  }
  local target
  target="$(command ls -d -- */ 2>/dev/null | fzf --height 50%)" || return 1
  [ -n "$target" ] || return 0
  cd -- "$target" || return 1
}

# Paged, colourised tree ignoring the usual noise directories.
tre() {
  tree -aC -I '.git|node_modules|bower_components' --dirsfirst "$@" | less -FRNX
}
