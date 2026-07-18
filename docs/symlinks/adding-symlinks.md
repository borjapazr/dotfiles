# Adding a symlink

1. Edit the relevant manifest in `symlinks/`: `common.yml` for all platforms,
   or `macos.yml` / `macos-intel.yml` / `linux.yml` / `linux-desktop.yml` for
   platform-specific entries.
2. Add an entry under `link:` — target in `$HOME` on the left, repo-relative
   path on the right:
   ```yaml
   ~/.some-config: dots/some/path/config
   ```
3. Run `dot symlinks apply`. dotbot removes stale/invalid links (`clean`) and
   creates the new one (`force: true` overwrites an existing file at the
   target).

Editing a file that's **already** linked takes effect immediately — no need to
re-apply. Re-applying is only needed when the manifest itself changes.
