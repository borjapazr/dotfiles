## 🚀 Installation

```bash
git clone https://github.com/borjapazr/dotfiles.git $HOME/.dotfiles
$HOME/.dotfiles/installer
```
## 🔮 Migrating from a legacy computer with Ubuntu

This is an installation guide to migrate from a legacy computer with **Ubuntu** to a new one.

## Steps

1. Backup **~/.ssh** and **~/.gnupg** from the previous computer to the new one
    - `chmod -R 700 ~/.ssh`
    - `chmod -R 700 ~/.gnupg`
2. Execute the dotfiles installer
    - `~/.dotfiles/install`
3. Configure, customize and set **Tilix** terminal as default terminal
    - Load configuration: `dconf load /com/gexperts/Tilix/ < tilix.dconf`
    - Backup configuration: `dconf dump /com/gexperts/Tilix/ > tilix.dconf`
4. Install **Mars Mono** font
5. Configure tweaks
    - **Install Gnome Shell Extensions**
        - User Themes
        - Dash to Panel
        - Arc Menu
    - **Shell theme**: [https://www.gnome-look.org/p/1267246](https://www.gnome-look.org/p/1267246/)

        Remember to edit the font size

    - **Icon Theme**: [https://www.snwh.org/paper/download](https://www.snwh.org/paper/download)
6. **Configure JetBrains products** and synchronize them with Jetbrains account
7. **Configure VS Code** and synchronize plugins

## 🤩 Inspiration

* <https://github.com/rgomezcasas/dotfiles> Thank you very much for your great job!

## ⚖️ License

The MIT License (MIT). Please see [License](LICENSE) for more information.
