ulimit -n 200000
ulimit -u 2048

# Enable aliases to be sudo’ed
alias sudo='sudo '

source "$DOTFILES_PATH/shell/aliases.sh"
source "$DOTFILES_PATH/shell/exports.sh"
source "$DOTFILES_PATH/shell/functions.sh"
source "$DOTFILES_PATH/shell/private-stuff.sh"
