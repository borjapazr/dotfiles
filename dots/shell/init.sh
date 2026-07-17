source "$DOTFILES_PATH/dots/shell/aliases.sh"
source "$DOTFILES_PATH/modules/private/shell/exports.sh"
source "$DOTFILES_PATH/dots/shell/private-stuff.sh"
source "$DOTFILES_PATH/dots/shell/exports.sh"
source "$DOTFILES_PATH/dots/shell/functions.sh"

(gpgconf --launch gpg-agent &) &>/dev/null
