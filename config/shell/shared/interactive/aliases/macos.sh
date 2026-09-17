#!/usr/bin/env bash
# macOS-only aliases. Interactive shells only.

case "$OSTYPE" in
darwin*) ;;
*) return 0 ;;
esac

# ─── Undo GNU-only aliases inherited from Zim ────────────────────────────────
# Zim's utility module picks its GNU branch when `dircolors` is on PATH and
# `ls --version` succeeds. Both can be true on a Mac by accident -- eza answers
# `--version`, and any stray coreutils gnubin entry supplies dircolors -- which
# leaves `chmod --preserve-root`, a flag BSD does not have. The detection lives
# in a generated file, so correct the result here instead.
unalias chmod chown 2>/dev/null

# ─── Networking ──────────────────────────────────────────────────────────────
# Named `myip` rather than `ip`: on Linux `ip` is iproute2, and shadowing it
# with a command that performs a DNS lookup is a trap for scripts and agents.
alias myip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip="ipconfig getifaddr en0"
alias ips="ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"
alias ifactive="ifconfig | pcregrep -M -o '^[^\t:]+:([^\n]|\n\t)*status: active'"

# ─── Finder ──────────────────────────────────────────────────────────────────
alias show="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
alias hide="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"
