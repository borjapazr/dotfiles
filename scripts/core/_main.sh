if ! ${DOT_MAIN_SOURCED:-false}; then
  for file in $DOTFILES_PATH/scripts/core/{args,docs,dot,git,log,platform,str}.sh; do
    source "$file"
  done
  unset file

  readonly DOT_MAIN_SOURCED=true
fi
