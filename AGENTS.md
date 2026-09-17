# AGENTS.md

Guidance for AI agents and humans working on this repository.

## What this repo is

Personal dotfiles for macOS and Linux. Two things live here: **configuration
that gets symlinked into `$HOME`**, and a **CLI called `dot`** that automates
everything else.

## Layout

Each top-level folder answers exactly one question. Put new files where they
answer that question, not where they are convenient.

| Folder      | Question it answers                      |
| ----------- | ---------------------------------------- |
| `bin/`      | What is on `$PATH`?                      |
| `commands/` | What can `dot` run?                      |
| `config/`   | What gets symlinked into `$HOME`?        |
| `links/`    | Which file goes where, on which machine? |
| `packages/` | What gets installed?                     |
| `modules/`  | Which git submodules are vendored?       |
| `tests/`    | bats suite                               |

`commands/<context>/<name>` maps one-to-one onto `dot <context> <name>`. Adding
a file to a context folder is all it takes to add a command.

Some apps cannot read a plain config file and only import their own export
format: `terminals/iterm/com.googlecode.iterm2.plist`,
`terminals/tilix/tilix.dconf`, `launchers/raycast/data.rayconfig`. They live
next to the rest of that app's configuration rather than in a folder of their
own, because `links/*.yml` already records what is symlinked and what is not.
Refresh them by exporting from the app, never by hand.

## Adding a `dot` command

```bash
#!/usr/bin/env bash

set -euo pipefail

source "$DOTFILES_PATH/commands/core/_main.sh"

##? One-line summary shown by `dot --list`
##?
##? Usage:
##?   name [<arg>]
##?
docs::parse "$@"

platform::require jq curl || exit 1
```

Rules enforced by `dot self validate_scripts` and by CI:

- The file must be executable (`chmod +x`).
- The docblock must exist and must contain a `Usage:` section. `docs::parse`
  delegates to `docpars`, which aborts without one.
- Declare external dependencies with `platform::require`, never assume them.

## The core library

`commands/core/` is sourced by every command through `_main.sh`. Functions are
namespaced `namespace::function`:

| Namespace    | Use                                |
| ------------ | ---------------------------------- |
| `log::`      | user-facing output                 |
| `docs::`     | docblock parsing                   |
| `args::`     | argument helpers                   |
| `dot::`      | CLI introspection                  |
| `git::`      | git helpers                        |
| `platform::` | OS detection and dependency checks |

`core` is not a context: `dot core ...` is rejected on purpose.

## Shell entry points

`config/shell/` splits on the only axis that matters: `bash/` and `zsh/` hold
what only one shell can express, `shared/` holds what both of them source.

`shared/` has exactly two entry points, and each one owns a directory with its
parts. A file named `X.sh` is composed of `X/`:

| Entry point      | Sourced by              | May contain                          |
| ---------------- | ----------------------- | ------------------------------------ |
| `env.sh`         | every shell             | exports and `$PATH` only             |
| `env/path.sh`    | `env.sh`                | `$PATH` construction                 |
| `env/agent.sh`   | `env.sh`                | non-interactive hardening            |
| `interactive.sh` | interactive shells only | nothing but the loop over `interactive/` |

Composition order inside `env.sh` is a contract and is documented at the point
of composition, not encoded in filenames: defaults, then `env/path.sh`, then
`env/agent.sh` (which may override the defaults), then machine-local files
(which always win).

**Never put an alias, a function meant for humans, or anything that produces
output under `env/`.** That is what keeps `bash -lc ls` returning the real `ls`
for CI and agent harnesses. Behaviour goes in `interactive/aliases/`,
`interactive/functions/` or `interactive/tools/` — the path itself tells you it
only exists when a human is watching.

`interactive.sh` loads every `interactive/*/*.sh` in alphabetical order. Adding
a category is adding a directory; no code changes. Number the directories if
the order between categories ever starts to matter.

Agent mode is auto-detected (known harness variables, CI variables, `TERM=dumb`,
no TTY). Override with `DOTFILES_AGENT=0` or `DOTFILES_AGENT=1`.

## Commands to run

```bash
make check    # everything CI runs: lint + fmt + test
make lint     # shellcheck -S warning
make fmt      # report shfmt drift
make format   # rewrite to canonical format
make test     # bats suite
```

After touching anything under `config/shell/`, run `dot shell compile` to
refresh the `.zwc` bytecode, and open a new shell to verify it starts clean.
After touching `links/*.yml`, run `dot links apply`.

## Platform constraints that have already caused bugs

- macOS ships **bash 3.2**. No `${ARR[-1]}`, no `${var,,}`, no `declare -A`,
  no `mapfile`. Scripts must run under it.
- macOS ships **BSD find**. Use `-perm -u+x`, not the GNU `-perm /+111`.
- `set -o errtrace` does not exist in zsh, and the zsh completion sources
  `_main.sh`. Guard bash-only options with `[[ -n ${BASH_VERSION:-} ]]`.
- `$DOTFILES_PATH` is unbound in a bare shell. `bin/dot` derives it and exports
  it, so dispatched commands can rely on it. Nothing else should re-derive it.
- Verify shell behaviour with `env -i`. An inherited environment produces both
  false positives and false negatives.

## Never touch

- `config/shell/local.sh` and `config/shell/local.interactive.sh` — gitignored,
  machine-local, secret-bearing. The pre-commit hook rejects them even under
  `git add -f`. Do not print their contents.
- `modules/` — git submodules. Update them with `dot self update`, not by
  editing files inside.
- `commands/git/effort` — vendored third-party script, kept verbatim.
