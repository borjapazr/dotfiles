# Exports
export DOTFILES_PATH="/usr/local/share/.dotfiles"
export ZSH="$DOTFILES_PATH/modules/oh-my-zsh"
if [[ -n $SSH_CONNECTION ]]; then
  export IS_SSH_CONNECTION=1
fi

# Skip global compinit
skip_global_compinit=1