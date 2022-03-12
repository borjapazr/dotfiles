#!/usr/bin/env zsh

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Options
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FCNTL_LOCK
setopt +o nomatch
unset zle_bracketed_paste

# Theme
ZSH_THEME="powerlevel10k/powerlevel10k"
ZLE_RPROMPT_INDENT=0

# Configuration
COMPLETION_WAITING_DOTS="false"
ZSH_AUTOSUGGEST_USE_ASYNC=true
ZSH_HIGHLIGHT_MAXLENGTH=300
ZSH_DISABLE_COMPFIX="true"
DEFAULT_USER=$(whoami)

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
  zsh-syntax-highlighting
  zsh-completions
  fzf-tab
)

# Load completions
# TODO: Change this
fpath=("$DOTFILES_PATH/shell/zsh/completions" "/dsakjd/daljkd" "/opt/homebrew/share/zsh/site-functions" $fpath)

# Load oh-my-zsh
source $ZSH/oh-my-zsh.sh
# Load aliases, exports and functions
source $DOTFILES_PATH/shell/init.sh
# Load key bindings
source $DOTFILES_PATH/shell/zsh/key-bindings.zsh
# Load z
source $(brew --prefix)/etc/profile.d/z.sh
# Load asdf and asdf plugins
source $(brew --prefix)/opt/asdf/libexec/asdf.sh
# if [ -f "$HOME/.asdf/plugins/java/set-java-home.zsh" ]; then
#   source "$HOME/.asdf/plugins/java/set-java-home.zsh"
# fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
