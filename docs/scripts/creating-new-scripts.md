# Creating a new `dot` script

1. Pick a context: an existing directory under `scripts/` (`ls scripts/`), or a
   new one. Never add scripts directly under `scripts/core/` — that's a
   sourced library, not user-invocable scripts.
2. Create `scripts/<context>/<script-name>`:

   ```bash
   #!/usr/bin/env bash

   set -euo pipefail

   source "$DOTFILES_PATH/scripts/core/_main.sh"

   ##? <one-line description>
   ##?
   ##? Usage:
   ##?   <script-name> [<args>...]
   docs::parse "$@"
   ```

3. `chmod +x` it.
4. Reuse `scripts/core/*.sh` helpers: `platform::*`, `log::*`, `str::*`, `git::*`.
5. Run `dot self static_analysis`, `dot self lint`, `dot self validate_scripts`
   — all three run in CI.

See `scripts/ai/prompts` for a minimal example, or invoke the `new-dot-script`
Claude Code skill (`dots/agents/skills/new-dot-script/`).
