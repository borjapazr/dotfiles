# ─── Dotfiles location ───────────────────────────────────────────────────────
# Fork-free: no $(...) in the hot path (subshells are costly under endpoint security).
if [[ -d "$HOME/.dotfiles" ]]; then
  export DOTFILES_PATH="$HOME/.dotfiles"
else
  export DOTFILES_PATH="/usr/local/share/.dotfiles"
fi
export ZIM_HOME="$DOTFILES_PATH/config/shell/zsh/.zim"

# ─── Homebrew prefix ─────────────────────────────────────────────────────────
# Derived fork-free so the hot path never calls $(brew --prefix).
if [[ $OSTYPE == darwin* ]]; then
  if [[ $CPUTYPE == arm64 ]]; then
    export HOMEBREW_PREFIX=/opt/homebrew
  else
    export HOMEBREW_PREFIX=/usr/local
  fi
else
  export HOMEBREW_PREFIX=/home/linuxbrew/.linuxbrew
fi

# ─── zsh ─────────────────────────────────────────────────────────────────────
# Skip the slow system-wide compinit; Zim's completion module handles it.
skip_global_compinit=1
