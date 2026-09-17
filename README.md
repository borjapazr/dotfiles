<div align="center">

# `.dotfiles`

![GitHub CI Workflow Status](https://img.shields.io/github/actions/workflow/status/borjapazr/dotfiles/ci.yml?style=flat-square&logo=github&label=CI)

<h4>
  💻🚀 Custom dotfiles for UNIX based systems
</h4>

<a href="#ℹ️-about">ℹ️ About</a> •
<a href="#-installation">📥 Installation</a> •
<a href="#️-structure">🗂️ Structure</a> •
<a href="#-the-dot-command">🌚 The dot command</a> •
<a href="#-the-shell">🧅 The shell</a> •
<a href="#️-development">🛠️ Development</a> •
<a href="#-credits">🎯 Credits</a> •
<a href="#-license">🚩 License</a>

</div>

---

## ℹ️ About

Personal dotfiles for macOS and Linux. Two things live here: **configuration
that gets symlinked into `$HOME`**, and a **CLI called `dot`** that automates
everything else — 73 commands across 19 contexts.

They are tailored to my needs and do not claim to be the right solution for
ideal dotfiles. Take whatever is useful.

> 💡 As a starting point to get all your configuration files and scripts organised I recommend you to use [dotly](https://github.com/CodelyTV/dotly), which is a project that describes itself as a simple and fast dotfiles framework.

## 📥 Installation

Using `wget`:

```bash
bash <(wget -qO- https://raw.githubusercontent.com/borjapazr/dotfiles/HEAD/installer)
```

Or using `curl`:

```bash
bash <(curl -s https://raw.githubusercontent.com/borjapazr/dotfiles/HEAD/installer)
```

The installer asks where to put the repository (defaulting to `~/.dotfiles`, and
backing up anything already there), makes sure `git` and `curl` exist, clones,
pulls in the submodules and hands over to `dot self install`: update the system,
install the requirements, apply the symlinks, set zsh as the login shell and
import the packages. Restart the terminal afterwards.

> ⚠️ `modules/private` is a private submodule of mine, so the installer stops
> there on any account but my own. Drop that entry from `.gitmodules` if you are
> installing a fork.

### 🧸 Configuration

Step by step, including what to do on a machine that is still empty:

- [macOS Installation Guide](docs/installation-guide-macos.md)
- [Linux Installation Guide](docs/installation-guide-linux.md)

## 🗂️ Structure

Every top-level folder answers exactly one question, so nothing has to be opened
to know what it holds.

```
.dotfiles/
├── bin/          # what is on $PATH — the dot CLI itself
├── commands/     # what dot can run: commands/<context>/<name> ⇒ dot <context> <name>
│   └── core/     # the shared library every command sources
├── config/       # what gets symlinked into $HOME
│   ├── editors/  # vim, VS Code
│   ├── git/      # gitconfig, gitignore, czrc
│   ├── launchers/# rofi, raycast
│   ├── shell/    # bash/, zsh/ and shared/
│   └── terminals/# ghostty, wezterm, tilix, iterm
├── links/        # which file goes where, on which machine
├── packages/     # what gets installed: Brewfile, apt and snap manifests
├── modules/      # git submodules (dotbot, private)
├── docs/         # task-oriented guides
├── resources/    # fonts, wallpapers, templates
└── tests/        # bats suite
```

### 🔗 Symlinks

The [dotbot](https://github.com/anishathalye/dotbot) manifests under `links/`
are the single source of truth for what ends up in `$HOME`. `dot links apply`
composes them per machine: `common.yml` always, then `macos.yml` or
`macos-intel.yml`, or `linux.yml` plus `linux-desktop.yml` when there is a
desktop session.

A few apps cannot read a plain config file and only import their own export
format — iTerm2's plist, Tilix's dconf dump, Raycast's `.rayconfig`. Those live
next to the rest of that app's configuration and are refreshed by exporting from
the app, never by hand.

### ⚒️ Built with

|                    |                                                                                                                                                    |
| ------------------ | -------------------------------------------------------------------------------------------------------------------------------------------------- |
| Shell framework    | [Zim](https://zimfw.sh/) — fast-loading Zsh config, with a handful of [Oh My Zsh](https://ohmyz.sh/) plugins pulled in for their aliases/functions |
| Fuzzy finder       | [fzf](https://github.com/junegunn/fzf) + [fzf-tab](https://github.com/Aloxaf/fzf-tab)                                                              |
| Symlinking         | [dotbot](https://github.com/anishathalye/dotbot)                                                                                                   |
| Argument parsing   | [docpars](https://github.com/denisidoro/docpars) — the `##?` docblocks are the parser                                                              |
| Package management | Homebrew (macOS/Linux), apt/snap (Linux)                                                                                                           |
| Gates              | [bats](https://github.com/bats-core/bats-core), [shellcheck](https://www.shellcheck.net/), [shfmt](https://github.com/mvdan/sh), gitleaks           |

## 🌚 The `dot` command

`dot` is the entry point to everything in `commands/`. Run it bare to fuzzy-pick
a command; give it a context and a name to run one directly.

```bash
[mars] ~ dot -h
dot — run the dotfiles' scripts

Usage:
   dot
   dot <context>
   dot <context> <script> [<args>...]
   dot -h | --help
   dot -l | --list
   dot --json
   dot -p | --print

Options:
   -h --help   Show this help, or the help of <context> <script>
   -l --list   Print every available command, one per line
   --json      Print every available command as JSON (for tooling and agents)
   -p --print  Print the picked command instead of running it
```

The contexts are `ai`, `cert`, `dev`, `docker`, `filesystem`, `git`, `github`,
`links`, `mac`, `network`, `package`, `process`, `self`, `share`, `shell`,
`style`, `system`, `utils` and `wtf`.

### 🗓️ Daily workflow

| Command               | What it does                                              |
| --------------------- | --------------------------------------------------------- |
| `dot self update`     | Update system, dotfiles, submodules and re-apply symlinks |
| `dot links apply`     | Re-apply symlinks after adding/removing an entry          |
| `dot package import`  | Install packages from the Brewfile/apt/snap manifests     |
| `dot package export`  | Write the installed packages back into the manifests      |
| `dot shell benchmark` | Benchmark zsh interactive startup time                    |
| `dot shell compile`   | Compile the zsh files to bytecode for a faster startup    |
| `dot self debug`      | Tail the installation log                                 |

### ➕ Adding a command

Dropping an executable file into a context folder is all it takes. There is no
registry to update: a file at `commands/<context>/<name>` already answers to
`dot <context> <name>`.

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

Three rules, enforced by `dot self validate_scripts` and by CI: the file must be
executable, the docblock must exist and contain a `Usage:` section, and external
dependencies are declared with `platform::require` instead of being assumed.

`commands/core/` is sourced by every command through `_main.sh`, and namespaces
its functions as `namespace::function` — `log::` for user-facing output, `docs::`
for the docblocks, `args::` for argument helpers, `dot::` for CLI introspection,
`git::` for git helpers, `platform::` for OS detection and dependency checks.
`core` is not a context: `dot core …` is rejected on purpose.

## 🧅 The shell

`config/shell/` splits on the only axis that matters: `bash/` and `zsh/` hold
what only one shell can express, `shared/` holds what both of them source.
`shared/` has exactly two entry points, and a file named `X.sh` is composed of
the directory `X/`:

| File             | Sourced by              | Contract                                                          |
| ---------------- | ----------------------- | ----------------------------------------------------------------- |
| `env.sh`         | every shell             | exports and `$PATH` only — no aliases, no output, no side effects |
| `env/path.sh`    | `env.sh`                | `$PATH` construction, fork-free                                   |
| `env/agent.sh`   | `env.sh`                | disables pagers, prompts and editors when no human is watching    |
| `interactive.sh` | interactive shells only | loads every `interactive/*/*.sh` in alphabetical order            |

Behaviour that shadows a standard command lives under `interactive/aliases/`,
`interactive/functions/` or `interactive/tools/`, so the path itself tells you it
only exists when a human is watching. Adding a category is adding a directory.

### 🤖 Agent friendly

That split is what makes `bash -lc ls` return the real `ls` for CI runners and
AI agent harnesses, instead of an alias with colours and a pager attached. Agent
mode is detected automatically — known harness variables, CI variables,
`TERM=dumb`, no TTY — and pins `EDITOR`, `PAGER` and friends to non-interactive
values. Force it on with `DOTFILES_AGENT=1`, opt out with `DOTFILES_AGENT=0`.

### 🔐 Machine-local configuration

Anything secret, or specific to a single machine, goes in
`config/shell/local.sh` (every shell) or `config/shell/local.interactive.sh`
(interactive only). Both are gitignored, both are sourced last so they always
win, and the pre-commit hook rejects the commit if either one shows up staged,
`git add -f` included.

## 🛠️ Development

```bash
make check    # everything CI runs: lint + fmt + test
make lint     # static analysis with shellcheck
make fmt      # report formatting drift with shfmt
make format   # rewrite files to the canonical format
make test     # bats suite
make hooks    # route git at the repo's tracked hooks
```

The same gates run on every push, and the test suite runs on both Ubuntu and
macOS, because the regressions worth catching here are platform-specific. macOS
ships **bash 3.2** and **BSD find**: no associative arrays, no `mapfile`, no
`${var,,}`, no negative array indices, no GNU-only `find` spellings.

After touching anything under `config/shell/`, run `dot shell compile` to
refresh the zsh bytecode and open a new shell to check it starts clean. After
touching `links/*.yml`, run `dot links apply`.

The conventions are written down in [AGENTS.md](AGENTS.md), which is worth
reading before any change.

## 👥 Contributing

Just fork and open a pull request. All contributions are welcome 🤗

## 🎯 Credits

These .dotfiles are largely based on [@rgomezcasas](https://github.com/rgomezcasas) [personal .dotfiles](https://github.com/rgomezcasas/dotfiles) and the [dotly](https://github.com/CodelyTV/dotly) framework. They have been adapted to suit my personal needs.

🙏 Thank you very much for these wonderful creations.

## 🚩 License

MIT @ [borjapazr](https://me.marsmachine.space). Please see [License](LICENSE) for more information.
