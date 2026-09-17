# Copilot instructions

This repository's conventions live in [AGENTS.md](../AGENTS.md). Read it before
making any change.

Short version:

- `commands/<context>/<name>` maps onto `dot <context> <name>`. New commands
  need the executable bit and a `##?` docblock with a `Usage:` section.
- Every command starts with `source "$DOTFILES_PATH/commands/core/_main.sh"`.
- `config/shell/shared/` has two entry points: `env.sh` (every shell, exports
  only) and `interactive.sh`. A file `X.sh` is composed of the directory `X/`.
  Aliases and human-facing functions belong under `interactive/`, never `env/`.
- Run `make check` before proposing a change. Scripts must run under macOS
  bash 3.2 and BSD find.
- Never read, print or commit `config/shell/local*.sh`.
