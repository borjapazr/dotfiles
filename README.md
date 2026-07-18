<div align="center">
 <img
  width="500"
 alt=".dotfiles"
 src="https://i.imgur.com/SzBeVhB.png">
<br>
<br>
  
![GitHub CI Workflow Status](https://img.shields.io/github/actions/workflow/status/borjapazr/dotfiles/ci.yml?style=flat-square&logo=github&label=CI)

<h4>
  💻🚀 Custom dotfiles for UNIX based systems
</h4>

<a href="#ℹ️-about">ℹ️ About</a> •
<a href="#-installation">📥 Installation</a> •
<a href="#-features">📋 Features</a> •
<a href="#-contributing">👥 Contributing</a> •
<a href="#-credits">🎯 Credits</a> •
<a href="#-license">🚩 License</a>

</div>

---

## ℹ️ About

Personal .dotfiles for quick configuration of my UNIX-based devices. They are tailored to my needs and do not claim to be the right solution for ideal .dotfiles.

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

### 🧸 Configuration

- [macOS Installation Guide](docs/installation-guide-macos.md)
- [Linux Installation Guide](docs/installation-guide-linux.md)

## 📋 Features

### ⚒️ Built with

| | |
|---|---|
| Shell framework | [Zim](https://zimfw.sh/) — fast-loading Zsh config, with a handful of [Oh My Zsh](https://ohmyz.sh/) plugins pulled in for their aliases/functions |
| Fuzzy finder | [fzf](https://github.com/junegunn/fzf) + [fzf-tab](https://github.com/Aloxaf/fzf-tab) |
| Symlinking | [dotbot](https://github.com/anishathalye/dotbot) |
| Package management | Homebrew (macOS/Linux), apt/snap (Linux) |

### 🌚 The `dot` command

`dot` is the core command of these dotfiles. Run it bare to fuzzy-pick a script; run it with a context/script to invoke directly.

```bash
[mars] ~ dot -h
Usage:
   dot
   dot <context>
   dot <context> <script> [<args>...]
   dot -h | --help
   dot -p | --print
```

### 🗓️ Daily workflow

| Command | What it does |
|---|---|
| `dot self update` | Update system, dotfiles, submodules and re-apply symlinks |
| `dot symlinks apply` | Re-apply symlinks after adding/removing an entry |
| `dot package import` | Install packages from the Brewfile/apt/snap manifests |
| `dot shell benchmark` | Benchmark zsh interactive startup time |
| `dot shell compile` | Compile the zsh files to bytecode for a faster startup |

### 🗂️ Structure

```
.dotfiles/
├── bin/          # dot CLI + external GNU tool shims
├── docs/         # task-oriented guides
├── dots/         # everything symlinked into $HOME, by domain
│   ├── editors/  # vim, VS Code
│   ├── git/      # gitconfig, gitignore, czrc
│   ├── os/       # common/macos/linux/windows-specific config
│   └── shell/    # bash/, zsh/, aliases, exports, functions
├── modules/      # git submodules (dotbot, private)
├── resources/    # fonts, wallpapers, templates
├── scripts/      # the dot CLI's script library, by context
└── symlinks/     # dotbot manifests (common/macos/linux/...)
```

## 👥 Contributing

Just fork and open a pull request. All contributions are welcome 🤗

## 🎯 Credits

These .dotfiles are largely based on [@rgomezcasas](https://github.com/rgomezcasas) [personal .dotfiles](https://github.com/rgomezcasas/dotfiles) and the [dotly](https://github.com/CodelyTV/dotly) framework. They have been adapted to suit my personal needs.

🙏 Thank you very much for these wonderful creations.

### ⭐ Stargazers

[![Stargazers repo roster for @borjapazr/dotfiles](https://reporoster.com/stars/borjapazr/dotfiles)](https://github.com/borjapazr/dotfiles/stargazers)

## 🚩 License

MIT @ [borjapazr](https://me.marsmachine.space). Please see [License](LICENSE) for more information.
