#!/usr/bin/env bash
# Linux-only aliases. Interactive shells only.

case "$OSTYPE" in
linux*) ;;
*) return 0 ;;
esac

alias myip="dig +short myip.opendns.com @resolver1.opendns.com"

localip() {
  hostname -I | awk '{print $1}'
}
