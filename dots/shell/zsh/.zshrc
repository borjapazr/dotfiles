#!/usr/bin/env zsh

# ─── History ─────────────────────────────────────────────────────────────────
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
setopt NO_BANG_HIST

# ─── Shell options ───────────────────────────────────────────────────────────
setopt +o nomatch

# ─── Completion menu (fzf-tab) ───────────────────────────────────────────────
# Previews are opt-in per command: with fzf-tab-source removed there is no
# preview window by default. Add a `fzf-preview` style per command that needs it.
if [[ -z $TMUX ]]; then
  zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
  # dot: a context → list its scripts; a script → show its ##? docblock. Uses
  # only $word (the fzf-tab candidate); never errors.
  zstyle ':fzf-tab:complete:dot:*' fzf-preview '[[ -d $DOTFILES_PATH/scripts/$word ]] && ls -1 $DOTFILES_PATH/scripts/$word || { f=$(find $DOTFILES_PATH/scripts -maxdepth 2 -type f -name $word 2>/dev/null | head -1); [[ -n $f ]] && grep -E "^##\?" "$f" | sed -E "s/^##\? ?//"; }'
else
  zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
fi

# ─── Prompt & terminal title (Zim) ───────────────────────────────────────────
zstyle ':zim:prompt-pwd' git-root yes
zstyle ':zim:termtitle' format '%0~'
zstyle ':zim:termtitle' hooks 'preexec' 'precmd' 'chpwd' 'zshexit' 'periodic' 'zshaddhistory'
zstyle ':url-quote-magic:*' url-metas ''
zstyle ':url-quote-magic:*' url-seps ''
zstyle ':completion:*' insert-tab pending

# ─── Module configuration ────────────────────────────────────────────────────
DEFAULT_USER=${USERNAME}
COMPLETION_WAITING_DOTS=false
ZSH_AUTOSUGGEST_USE_ASYNC=true
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)
ZSH_HIGHLIGHT_MAXLENGTH=300
ZSH_DISABLE_COMPFIX=true

# ─── Completion fpath ────────────────────────────────────────────────────────
fpath=("$DOTFILES_PATH/dots/shell/zsh/completions" "${HOMEBREW_PREFIX}/share/zsh/site-functions" $fpath)

# ─── Zim bootstrap ───────────────────────────────────────────────────────────
# Regenerate ${ZIM_HOME}/init.zsh when it is missing or older than .zimrc.
if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZIM_CONFIG_FILE:-${ZDOTDIR:-${HOME}}/.zimrc} ]]; then
  source "${HOMEBREW_PREFIX}/opt/zimfw/share/zimfw.zsh" init
fi
source ${ZIM_HOME}/init.zsh

# ─── Dotfiles (aliases, exports, functions) ──────────────────────────────────
source $DOTFILES_PATH/dots/shell/init.sh

# ─── Keybindings ─────────────────────────────────────────────────────────────
source $DOTFILES_PATH/dots/shell/zsh/key-bindings.zsh
