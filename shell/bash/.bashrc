export DOTFILES_PATH="/usr/local/share/.dotfiles"

source $DOTFILES_PATH/shell/init.sh

source $DOTFILES_PATH/shell/bash/themes/mrmars.sh

source $DOTFILES_PATH/shell/bash/completions/_dot

# Load z
source $(brew --prefix)/etc/profile.d/z.sh
