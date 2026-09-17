#!/usr/bin/env bash
# fzf appearance. Interactive-only: exporting this into non-interactive children
# would make any script that pipes through fzf inherit a UI it never asked for.

# Assigned, not appended, so re-sourcing the layer cannot grow the value.
export FZF_DEFAULT_OPTS="
  --color=fg:#e5e9f0,hl:#81a1c1
  --color=fg+:#e5e9f0,bg+:#3b4252,hl+:#81a1c1,border:#3c6e71
  --color=info:#eacb8a,prompt:#bf6069,pointer:#b48dac
  --color=marker:#a3be8b,spinner:#b48dac,header:#a3be8b
  --layout=reverse
  --padding=0,0,0,0
  --pointer='▶' --marker='✓'
  --info=inline
"
export FORGIT_FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS"
