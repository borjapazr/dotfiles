# Exports
export DOTFILES_PATH=$([[ -d "$HOME/.dotfiles" ]] && echo "$HOME/.dotfiles" || echo "/usr/local/share/.dotfiles")
export ZIM_HOME="$DOTFILES_PATH/shell/zsh/.zim"

# Skip global compinit
skip_global_compinit=1
