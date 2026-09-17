#!/usr/bin/env bash
# ═════════════════════════════════════════════════════════════════════════════
# env.sh — sourced by EVERY shell (login, non-login, non-interactive).
#
# Contract: exports and $PATH only. No aliases, no functions meant for humans,
# no output, no forks in the hot path, no side effects. Anything that changes
# the behaviour of standard commands belongs in interactive.sh instead, so that
# `bash -lc` / `zsh -lc` (CI, AI agents, editors) get a predictable POSIX shell.
#
# Composition order matters and is written below, not encoded in filenames:
#   defaults here → env/path.sh → env/agent.sh → machine-local
# Each step may override the previous one; machine-local always wins.
# ═════════════════════════════════════════════════════════════════════════════

# Idempotence guard: a login shell would otherwise source this twice
# (.zprofile, then .zshrc).
[ -n "${__DOTFILES_ENV_SOURCED:-}" ] && return 0
__DOTFILES_ENV_SOURCED=1

# ─── Dotfiles & Homebrew location ────────────────────────────────────────────
# .zshenv already sets these for zsh; recompute fork-free for bash and for
# shells that inherited a partial environment.
if [ -z "${DOTFILES_PATH:-}" ]; then
  if [ -d "$HOME/.dotfiles" ]; then
    DOTFILES_PATH="$HOME/.dotfiles"
  else
    DOTFILES_PATH="/usr/local/share/.dotfiles"
  fi
  export DOTFILES_PATH
fi

if [ -z "${HOMEBREW_PREFIX:-}" ]; then
  case "$OSTYPE" in
  darwin*)
    if [ -d /opt/homebrew ]; then
      HOMEBREW_PREFIX=/opt/homebrew
    else
      HOMEBREW_PREFIX=/usr/local
    fi
    ;;
  *) HOMEBREW_PREFIX=/home/linuxbrew/.linuxbrew ;;
  esac
  export HOMEBREW_PREFIX
fi

# ─── Editor & pager ──────────────────────────────────────────────────────────
export EDITOR='vim'
export VISUAL="$EDITOR"
export BROWSER="$DOTFILES_PATH/bin/chrome"

# Never page: paging blocks non-interactive callers and mangles captured output.
export PAGER="cat"
export GH_PAGER="cat"
export GIT_PAGER="cat"
export MANPAGER="cat"

# ─── JVM ─────────────────────────────────────────────────────────────────────
export MAVEN_OPTS="-Xmx1024m -Xdebug -Xrunjdwp:transport=dt_socket,address=8787,server=y,suspend=n"
export JAVA_TOOL_OPTIONS='-Dfile.encoding=UTF-8'

# ─── Golang ──────────────────────────────────────────────────────────────────
export GOPATH="${HOME}/.go"
export GOBIN="${GOPATH}/bin"

# ─── asdf ────────────────────────────────────────────────────────────────────
export ASDF_DATA_DIR="$HOME/.asdf"

# ─── Homebrew behaviour ──────────────────────────────────────────────────────
export HOMEBREW_AUTO_UPDATE_SECS=604800
export HOMEBREW_NO_ANALYTICS=true

# ─── GPG ─────────────────────────────────────────────────────────────────────
# Only meaningful when a terminal exists. $TTY is set by zsh without forking.
if [ -t 0 ]; then
  GPG_TTY="${TTY:-$(tty)}"
  export GPG_TTY
fi

# ─── Tool themes ─────────────────────────────────────────────────────────────
export BAT_THEME='gruvbox-dark'

# ─── $PATH ───────────────────────────────────────────────────────────────────
. "$DOTFILES_PATH/config/shell/shared/env/path.sh"

# ─── Non-interactive / agent hardening ───────────────────────────────────────
# Sourced after the defaults above so it can override them (EDITOR, PAGER...),
# and before the machine-local files so those still have the last word.
. "$DOTFILES_PATH/config/shell/shared/env/agent.sh"

# ─── Machine-local overrides (optional, gitignored) ──────────────────────────
# Sourced last so they win. Guarded: the private submodule may not be
# initialised, and local.sh may simply not exist on a fresh machine.
[ -f "$DOTFILES_PATH/modules/private/shell/exports.sh" ] &&
  . "$DOTFILES_PATH/modules/private/shell/exports.sh"
[ -f "$DOTFILES_PATH/config/shell/local.sh" ] &&
  . "$DOTFILES_PATH/config/shell/local.sh"

return 0
