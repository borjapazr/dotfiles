---
name: new-dot-script
description: Scaffold a new `dot <context> <script>` command following this repo's conventions (docblock, executable bit, core sourcing). Use when the user asks to add a new script/command to the dotfiles, or to the `dot` CLI.
---

# New dot script

Scaffold a new script for the `dot` CLI at `scripts/<context>/<script-name>`.

## Steps

1. Pick the context: an existing directory under `scripts/` (run `ls scripts/`
   to see valid contexts — `ai`, `git`, `docker`, `package`, `self`, etc.), or a
   new one if none fits. Never put a new script directly under `scripts/core/`
   — that directory is a sourced library, not user-invocable scripts.
2. Create `scripts/<context>/<script-name>` with exactly this shape:

   ```bash
   #!/usr/bin/env bash

   set -euo pipefail

   source "$DOTFILES_PATH/scripts/core/_main.sh"

   ##? <one-line description>
   ##?
   ##? Usage:
   ##?   <script-name> [<args>...]
   docs::parse "$@"

   # implementation
   ```

3. `chmod +x` the new file.
4. Use existing `scripts/core/*.sh` helpers instead of reimplementing:
   `platform::is_macos` / `platform::is_linux` / `platform::command_exists`
   (platform.sh), `log::info` / `log::success` / `log::error` / `log::file`
   (log.sh), `str::contains` (str.sh), `git::*` (git.sh).
5. Before finishing, run:
   ```
   dot self static_analysis   # shellcheck -s bash -S warning -e SC1090 -e SC2010 -e SC2154
   dot self lint              # shfmt -i 2 -d
   dot self validate_scripts  # docblock + executable bit present
   ```
   All three run in CI on every push/PR — a script that fails any of them will
   fail CI.
6. Verify the script is discoverable: `dot <context>` should list it, and
   `dot <context> <script-name> --help` should print the docblock.

## Reference

`scripts/ai/prompts` is a minimal canonical example of this shape.
