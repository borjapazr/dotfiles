export DOTFILES_PATH=$HOME/.dotfiles
export ZSH="$DOTFILES_PATH/modules/oh-my-zsh"

# Options
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FCNTL_LOCK

# Theme
ZSH_THEME="robbyrussell"

# Configuration
COMPLETION_WAITING_DOTS="true"
ZSH_AUTOSUGGEST_USE_ASYNC=true
ZSH_HIGHLIGHT_MAXLENGTH=300
ZSH_DISABLE_COMPFIX="true"
DEFAULT_USER=borja

# Plugins
plugins=(
  colored-man-pages
  colorize
  command-not-found
  copydir
  copyfile
  cp
  extract
  git
  gitignore
  mvn
  node
  npm
  safe-paste
  you-should-use
  zsh-autosuggestions
  zsh-syntax-highlighting
)

autoload -U compinit && compinit

# Disable paste highlighting
zle_highlight+=(paste:none)

# Load oh-my-zsh
source $ZSH/oh-my-zsh.sh
# Load aliases, exports and functions
source $DOTFILES_PATH/shell/init.sh
# Load key bindings
source $DOTFILES_PATH/shell/zsh/key-bindings.zsh