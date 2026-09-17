#!/usr/bin/env bash
# ═════════════════════════════════════════════════════════════════════════════
# agent.sh — non-interactive hardening. Composed by env.sh; not an entry point.
#
# Neutralises everything that can block, prompt, page or open a window when no
# human is watching: CI runners, `bash -lc` from an editor, and AI coding agents
# (Claude Code, Copilot, Codex...). A blocked $EDITOR on `git commit` or a pager
# waiting on a keypress is an unrecoverable hang for those callers.
#
# Opt out with DOTFILES_AGENT=0, force on with DOTFILES_AGENT=1.
# ═════════════════════════════════════════════════════════════════════════════

_dotfiles_detect_agent() {
  # Explicit override always wins.
  case "${DOTFILES_AGENT:-}" in
  0 | false | no) return 1 ;;
  1 | true | yes) return 0 ;;
  esac

  # Known agent/automation harnesses. Names are exact on purpose — a typo here
  # fails open and silently, which is how this file shipped broken once.
  [ -n "${CLAUDECODE:-}${COPILOT_AGENT:-}${CURSOR_AGENT:-}${AIDER_MODEL:-}${OPENAI_CODEX:-}${GEMINI_CLI:-}${REPLIT_CLI:-}" ] && return 0

  # Generic CI signals.
  [ -n "${CI:-}${CONTINUOUS_INTEGRATION:-}${GITHUB_ACTIONS:-}${GITLAB_CI:-}${JENKINS_URL:-}${BUILDKITE:-}" ] && return 0

  # A terminal that cannot render anything interactive.
  [ "${TERM:-dumb}" = "dumb" ] && return 0

  # No usable terminal. stdin answers prompts; stdout decides whether anyone is
  # reading. Agent harnesses keep stdin on the tty but capture stdout to parse
  # it, so neither check alone is enough.
  [ -t 0 ] && [ -t 1 ] || return 0

  return 1
}

if _dotfiles_detect_agent; then
  export DOTFILES_AGENT=1

  # ─── Never open an editor: `git commit` without -m must fail, not hang ─────
  export EDITOR=true
  export VISUAL=true
  export GIT_EDITOR=true

  # ─── Never open a browser or a GUI ────────────────────────────────────────
  export BROWSER=true

  # ─── Never prompt for credentials ─────────────────────────────────────────
  export GIT_TERMINAL_PROMPT=0
  export GCM_INTERACTIVE=never
  export GH_PROMPT_DISABLED=1
  export DEBIAN_FRONTEND=noninteractive
  export NONINTERACTIVE=1

  # ─── Never page ───────────────────────────────────────────────────────────
  export PAGER=cat
  export GIT_PAGER=cat
  export GH_PAGER=cat
  export MANPAGER=cat
  export LESS="-F -X -R"
  export SYSTEMD_PAGER=cat

  # ─── No surprise background work or version nags ──────────────────────────
  export HOMEBREW_NO_AUTO_UPDATE=1
  export HOMEBREW_NO_INSTALL_CLEANUP=1
  export HOMEBREW_NO_ENV_HINTS=1
  export PIP_DISABLE_PIP_VERSION_CHECK=1
  export PYTHONUNBUFFERED=1
  export npm_config_fund=false
  export npm_config_audit=false
  export npm_config_update_notifier=false
  export DO_NOT_TRACK=1
  export NEXT_TELEMETRY_DISABLED=1
  export DOTNET_CLI_TELEMETRY_OPTOUT=1

  # ─── Deterministic, parseable output ──────────────────────────────────────
  # Colour codes corrupt anything that diffs or greps the captured output.
  export CLICOLOR=0
fi

unset -f _dotfiles_detect_agent
