#!/usr/bin/env bash
# Navigation and general-purpose aliases. Interactive shells only.

# ─── Navigation ──────────────────────────────────────────────────────────────
alias ..="cd .."
alias ...="cd ../.."
alias cdh="cd ~"
alias cdp="cd ~/Projects"
alias cdr="cd ~/Resources"
alias dotfiles="cd \"\$DOTFILES_PATH\""

# ─── Listing ─────────────────────────────────────────────────────────────────
# Shadows `ls`; scoped to interactive shells so scripts still get real `ls`.
if command -v eza >/dev/null 2>&1; then
  alias ls="eza --icons --group-directories-first"
  alias ll="eza --icons --group-directories-first -l"
  alias la="eza --icons --group-directories-first -la"
  alias lsa="eza --icons --group-directories-first -lah"
fi

# ─── Jump around ─────────────────────────────────────────────────────────────
command -v zoxide >/dev/null 2>&1 && alias j="z"

# ─── Editors & IDEs ──────────────────────────────────────────────────────────
alias i.='(idea "$PWD" &>/dev/null &)'
alias c.='(code "$PWD" &>/dev/null &)'
alias o.='open .'
alias oc="opencode"
alias cc="claude"

# ─── Utils ───────────────────────────────────────────────────────────────────
alias k="kill -9"
command -v prettyping >/dev/null 2>&1 && alias ping="prettyping --nolegend"
command -v btm >/dev/null 2>&1 && alias htop="btm"
command -v pydf >/dev/null 2>&1 && alias df="pydf"
