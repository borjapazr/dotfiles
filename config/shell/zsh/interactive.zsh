#!/usr/bin/env zsh
# The interactive layer of shared/interactive.sh that only zsh can express.
# Everything here relies on a zsh hook with no bash equivalent; anything that
# works in both shells belongs in shared/interactive/{aliases,functions}/.

# `clear` normally wipes the scrollback. This keeps history and just pushes the
# prompt to the top, relying on precmd to re-insert the blank line afterwards.
precmd() {
  precmd() {
    echo
  }
}
alias clear="precmd() { precmd() { echo } } && clear && printf '\e[3J'"
