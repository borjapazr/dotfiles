#!/usr/bin/env bash
# Assorted helpers. Interactive shells only.

# Cross-platform `open` (macOS open / xdg-open / wslview), via the dot CLI.
open() {
  dot system open "$@"
}

# Print N separator lines, to visually break up terminal output.
echos() {
  local limit="${1:-22}" i=0
  while [ "$i" -le "$limit" ]; do
    printf '%s\n' '--------------------------------------------------------------------------------'
    i=$((i + 1))
  done
}
