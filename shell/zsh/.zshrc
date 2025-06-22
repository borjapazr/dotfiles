#!/usr/bin/env zsh

# Options
HISTFILE=$HOME/.zsh_history
HISTSIZE=10000000
SAVEHIST=$HISTSIZE
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FCNTL_LOCK
setopt HIST_SAVE_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
setopt INC_APPEND_HISTORY_TIME
setopt EXTENDED_HISTORY
setopt HIST_NO_STORE
setopt SHARE_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_VERIFY
setopt HIST_FIND_NO_DUPS
setopt +o nomatch
unset zle_bracketed_paste

# ZSH style
if [[ -z $TMUX ]]; then
  zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
else
  zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
fi

# Configuration
DEFAULT_USER=$(whoami)
COMPLETION_WAITING_DOTS="false"
ZSH_AUTOSUGGEST_USE_ASYNC=true
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)
ZSH_HIGHLIGHT_MAXLENGTH=300
ZSH_DISABLE_COMPFIX="true"

# Load completions
fpath=("$DOTFILES_PATH/shell/zsh/completions" "$(brew --prefix)/share/zsh/site-functions" $fpath)

# Start Zim
## Install missing modules and update ${ZIM_HOME}/init.zsh if missing or outdated.
if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZIM_CONFIG_FILE:-${ZDOTDIR:-${HOME}}/.zimrc} ]]; then
  source "$(brew --prefix)/opt/zimfw/share/zimfw.zsh" init
fi
## Initialize modules.
source ${ZIM_HOME}/init.zsh

# Load z
source $(brew --prefix)/etc/profile.d/z.sh

# Load aliases, exports and functions
source $DOTFILES_PATH/shell/init.sh
# Load key bindings
source $DOTFILES_PATH/shell/zsh/key-bindings.zsh
