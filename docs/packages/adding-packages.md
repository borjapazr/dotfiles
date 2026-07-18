# Adding a package

Edit the manifest for the relevant package manager, then run `dot package import`.

| Manager | File |
|---|---|
| Homebrew (macOS) | `dots/os/macos/brew/Brewfile` |
| Homebrew (Linux) | `dots/os/linux/brew/Brewfile` |
| apt | `dots/os/linux/apt/packages.txt` (+ `packages-desktop.txt` for desktop-only) |
| snap | `dots/os/linux/snap/packages.txt` (+ `packages-desktop.txt`) |

`dot package import` (`scripts/package/import`) only installs from whichever
manifests exist and whichever package manager is present on the machine — it's
safe to run on any platform.
