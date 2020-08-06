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