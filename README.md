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

- [macOS Installation Guide](doc/installation-guide-macos.md)
- [Linux Installation Guide](doc/installation-guide-linux.md)

## 📋 Features

### ⚒️ Built with

- [Oh My Zsh](https://ohmyz.sh/) Oh My Zsh is a delightful, open source, community-driven framework for managing your Zsh configuration. It comes bundled with thousands of helpful functions, helpers, plugins, themes, and a few things that make you shout...
- [fzf](https://github.com/junegunn/fzf) A general-purpose command-line fuzzy finder.
- [dotbot](https://github.com/anishathalye/dotbot) Dotbot is a tool that bootstraps your dotfiles (it's a [Dot]files [bo]o[t]strapper, get it?). It does less than you think, because version control systems do more than you think.

### 🌚 The `dot` command

`dot` is the core command my .dotfiles. If you execute it, you'll see all your scripts.

```bash
[mars] ~ dot -h
Usage:
   dot
   dot <context>
   dot <context> <script> [<args>...]
   dot -h | --help
   dot -p | --print
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
