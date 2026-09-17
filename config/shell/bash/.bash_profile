# Load the environment layer (exports + $PATH). Interactive extras are loaded
# by .bashrc, so `bash -lc <cmd>` gets a predictable, alias-free shell.
source "${DOTFILES_PATH:-$HOME/.dotfiles}/config/shell/shared/env.sh"

# In an interactive login shell, bash reads .bash_profile but NOT .bashrc.
case $- in
*i*) [ -f "$HOME/.bashrc" ] && source "$HOME/.bashrc" ;;
esac
