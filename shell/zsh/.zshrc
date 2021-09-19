# Options
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FCNTL_LOCK
setopt +o nomatch
unset zle_bracketed_paste

# Theme
ZSH_THEME="mrmars"

# Configuration
COMPLETION_WAITING_DOTS="false"
ZSH_AUTOSUGGEST_USE_ASYNC=true
ZSH_HIGHLIGHT_MAXLENGTH=300
ZSH_DISABLE_COMPFIX="true"
DEFAULT_USER=borja

# Plugins
plugins=(
  brew
  colored-man-pages
  colorize
  command-not-found
  copydir
  copyfile
  cp
  extract
  forgit
  gitignore
  mvn
  node
  npm
  safe-paste
  you-should-use
  zsh-autosuggestions
  fast-syntax-highlighting
  pyenv
  sdk
)

# Load completions
fpath=("$DOTFILES_PATH/shell/zsh/completions" "$DOTFILES_PATH/modules/zsh-completions/src" $fpath)

# Load oh-my-zsh
source $ZSH/oh-my-zsh.sh
# Load aliases, exports and functions
source $DOTFILES_PATH/shell/init.sh
# Load key bindings
source $DOTFILES_PATH/shell/zsh/key-bindings.zsh
# Load z
source $(brew --prefix)/etc/profile.d/z.sh
# Load sdkman
source "$HOME/.sdkman/bin/sdkman-init.sh"
# Load pyenv-virtualenv
# eval "$(pyenv virtualenv-init -)"

