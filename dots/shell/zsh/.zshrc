#!/usr/bin/env zsh

# ─── Profiling (opt-in) ──────────────────────────────────────────────────────
# `ZSH_PROFILE=1 zsh -i -c exit` prints a zprof startup report. Inert otherwise.
[[ -n ${ZSH_PROFILE:-} ]] && zmodload zsh/zprof

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

# ─── Shell options ───────────────────────────────────────────────────────────
setopt +o nomatch
unset zle_bracketed_paste

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

# ─── Deferred work (runs after the first prompt; zsh-defer comes from Zim) ────
# Recompile any stale .zwc bytecode so the next startup is faster.
_dotfiles_zwc_recompile() {
  local f
  for f in \
    "$DOTFILES_PATH"/dots/shell/{init,aliases,exports,functions}.sh \
    "$DOTFILES_PATH"/dots/shell/zsh/{.zshenv,.zshrc,.zprofile,.zlogin,key-bindings.zsh}; do
    [[ -r $f && (! -e $f.zwc || $f -nt $f.zwc) ]] && zcompile -- $f 2>/dev/null
  done
}

# Everything not needed for the first prompt, loaded after it appears.
zsh-defer _dotfiles_zwc_recompile

# ─── Profiling report (opt-in) ───────────────────────────────────────────────
if [[ -n ${ZSH_PROFILE:-} ]]; then zprof; fi
