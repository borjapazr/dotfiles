# `date` portability (GNU vs BSD)

macOS ships BSD `date` (`date -v-30d`); Linux ships GNU `date` (`date -d "-30 days"`)
— they aren't compatible. Since this repo targets both, don't call `date -d`/`date -v`
directly in a script meant to run on both.

This repo already provides a portable `date` on macOS: `symlinks/macos.yml` /
`macos-intel.yml` link `bin/external/date` to the real GNU `gdate` (from
Homebrew's `coreutils`), and `bin/external` is on `PATH`
(`dots/shell/exports.sh`). On Linux, plain `date` already is GNU date. So:

- Prefer plain `date` (GNU syntax) in new scripts — it resolves correctly on
  both platforms via the shim.
- Don't hardcode `gdate` — that only exists on macOS with `coreutils`
  installed, and isn't the portable name.
