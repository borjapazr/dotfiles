source "$DOTFILES_PATH/dots/shell/aliases.sh"
source "$DOTFILES_PATH/modules/private/shell/exports.sh"
source "$DOTFILES_PATH/dots/shell/exports.sh"
source "$DOTFILES_PATH/dots/shell/private-stuff.sh"
source "$DOTFILES_PATH/dots/shell/functions.sh"

# Pre-warm gpg-agent (backgrounded)
(gpgconf --launch gpg-agent &) &>/dev/null
