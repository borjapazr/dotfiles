# AGENTS.md

Repo-specific gotchas for coding agents working in this dotfiles repo. For general
guidance see `docs/`. For cross-repo working-style preferences see
`dots/agents/GLOBAL_AGENTS.md`.

## Symlink model

Nothing here is "installed" by copying files. [dotbot](https://github.com/anishathalye/dotbot)
symlinks paths from this repo into `$HOME`, driven by the YAML manifests in
`symlinks/` (`common.yml` + one per OS/profile). **Editing a file that's already
linked takes effect immediately** — it's the symlink target. You only need to
re-run `dot symlinks apply` (or `dot self install`) when the **manifest itself**
changes (a symlink entry added/removed), not for content edits.

## The `dot` CLI

Scripts live at `scripts/<context>/<script-name>`. Every script:
- Starts with `source "$DOTFILES_PATH/scripts/core/_main.sh"`.
- Has a `##?`-prefixed docblock (parsed by `docs::parse` via `docpars`) with at
  least a one-line description and a `Usage:` section. See `scripts/ai/prompts`
  for a minimal canonical example.
- Must be executable (`chmod +x`).

CI enforces this on every script under `scripts/<context>/` (excluding
`scripts/core/`, which is a sourced library, not a script):
`scripts/self/static_analysis` (shellcheck `-s bash -S warning -e SC1090 -e SC2010 -e SC2154`),
`scripts/self/lint` (shfmt `-i 2 -d`), and `scripts/self/validate_scripts`
(docblock + executable bit). Run `dot self validate_scripts` before adding a
new script.

## Dual bash/zsh support

`dots/shell/bash/` and `dots/shell/zsh/` are maintained in parallel. Shared
logic (aliases, exports, functions) lives in `dots/shell/{aliases,exports,functions}.sh`
and is sourced from both via `dots/shell/init.sh` — put shell-agnostic changes
there, not in one shell's rc file only.

## Secrets boundary — never touch

`dots/shell/private-stuff.sh` is **untracked, gitignored, machine-local**, and
contains live plaintext credentials plus MCP environment variables. **Never
read, print, quote, or copy its contents into any output, commit, or file.**
Treat it as opaque; only reference it by name/path.

## Private submodule boundary

`modules/private` is a **separate git repository** (its own remote, own
history). Committing from this repo's root does not commit changes made inside
it — it needs its own `git add/commit/push` from within `modules/private`,
followed by a submodule-pointer-bump commit here.

## Vendored — do not edit

`modules/dotbot` is an upstream dependency (anishathalye/dotbot). Don't edit it
in place; changes belong upstream.

## Inditex-specific, machine-local — never generalize

`dots/git/.gitconfig.inditex` (loaded via `includeIf`), the `ITX_*` env vars in
`private-stuff.sh`, and the aidevtracker/ivm/git-ai integrations there are
specific to the author's employer and machine. Don't assume they're portable
or copy them into generic examples/docs.

## Commit discipline

This repo uses Conventional Commits (`dots/git/.czrc`, `cz-conventional-changelog`).
For undoing/recovering, use the existing git aliases `nah` (hard reset + clean,
aborts an in-progress rebase) and `undo` (soft-undo last commit) rather than
inventing new recovery steps.

## Task-specific docs

- [Creating a new script](docs/scripts/creating-new-scripts.md)
- [Adding a symlink](docs/symlinks/adding-symlinks.md)
- [Adding a package](docs/packages/adding-packages.md)
- [`date` portability (GNU vs BSD)](docs/shell/date-portability.md)
- [macOS installation guide](docs/installation-guide-macos.md)
- [Linux installation guide](docs/installation-guide-linux.md)
