#!/usr/bin/env bash
# Search helpers. Interactive shells only.

# Find-in-file: ripgrep for a string, pick a match with fzf, preview in context.
fif() {
  if [ "$#" -eq 0 ]; then
    echo "fif: need a string to search for" >&2
    return 1
  fi
  command -v rg >/dev/null 2>&1 && command -v fzf >/dev/null 2>&1 || {
    echo "fif: requires rg and fzf" >&2
    return 1
  }
  rg --files-with-matches --no-messages -- "$1" |
    fzf --preview "rg --ignore-case --pretty --context 10 -- '$1' {}"
}
