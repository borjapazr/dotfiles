# Exports
export DOTFILES_PATH=$([[ -d "$HOME/.dotfiles" ]] && echo "$HOME/.dotfiles" || echo "/usr/local/share/.dotfiles")
export ZIM_HOME="$DOTFILES_PATH/shell/zsh/.zim"
