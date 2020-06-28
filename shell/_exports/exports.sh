custom_paths=(
  "$DOTFILES_PATH/bin"
  "$DOTFILES_PATH/bin/external"
)

CUSTOM_PATH=$(
  IFS=":"
  echo "${custom_paths[*]}"
)

export PATH="${CUSTOM_PATH}:${PATH}"
export EDITOR="vim"
export FZF_DEFAULT_OPTS='--reverse'
export HOMEBREW_PREFIX="/home/linuxbrew/.linuxbrew";
export HOMEBREW_CELLAR="/home/linuxbrew/.linuxbrew/Cellar";
export HOMEBREW_REPOSITORY="/home/linuxbrew/.linuxbrew/Homebrew";
export PATH="/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin${PATH+:$PATH}";
export MANPATH="/home/linuxbrew/.linuxbrew/share/man${MANPATH+:$MANPATH}:";
export INFOPATH="/home/linuxbrew/.linuxbrew/share/info:${INFOPATH}";
