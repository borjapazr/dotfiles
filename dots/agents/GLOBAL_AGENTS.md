# Global agent instructions

Cross-repo working-style preferences, symlinked into each AI coding
harness's global config (see `symlinks/common.yml`). For instructions specific
to this dotfiles repo, see the root `AGENTS.md` instead — that one is about
*this* repo; this file is about working style everywhere else.

## Language

Reply in the language the user writes in (Spanish if they write in Spanish).
Code, comments (when warranted — see below), commit messages, and
documentation are always in English, regardless of conversation language.

## Comments

No explanatory comments. Code should be self-documenting through naming and
structure. Only comment the truly non-obvious: a hidden constraint, a subtle
invariant, a workaround for a specific bug, or behavior that would surprise a
reader. If removing a comment wouldn't confuse a future reader, don't write it.

## Terminology

Use inclusive terminology (e.g. `allowlist`/`denylist` over `whitelist`/`blacklist`,
`primary`/`replica` over `master`/`slave`).

## Tests

Don't use mocks outside of test code. Prefer real implementations/integration
over mocking in application code.

## CLI tool preference

When both are available, prefer the modern tool over the legacy one:

| Prefer | Over |
|---|---|
| `rg` | `grep` |
| `fd` | `find` |
| `eza --tree` | `tree` |
| `bat` | `cat` (for viewing, not piping) |
