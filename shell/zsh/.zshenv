# Exports
export DOTFILES_PATH=$([[ -d "$HOME/.dotfiles" ]] && echo "$HOME/.dotfiles" || echo "/usr/local/share/.dotfiles")
export ZSH="$DOTFILES_PATH/modules/oh-my-zsh"

# Skip global compinit
skip_global_compinit=1
