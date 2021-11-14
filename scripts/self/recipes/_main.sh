if ! ${DOT_RECIPES_SOURCED:-false}; then
  for file in $DOTFILES_PATH/scripts/self/recipes/{brew,docker,tlp}.sh; do
    source "$file"
  done
  unset file

  readonly DOT_RECIPES_SOURCED=true
fi

recipes::install() {
  local recipe_file
  recipe_file=$DOTFILES_PATH/scripts/self/recipes/$1.sh

  if [[ -f $recipe_file ]]; then
    local recipe
    recipe=$(basename -- "$recipe_file" .sh)
    log::info "📥 Installing $recipe"

    if ! "$recipe::is_installed"; then
      "$recipe::install"
    else
      log::info "✅ $recipe is already installed"
    fi
    "$recipe::post_install"
  else
    echo "Recipe $1 not found."
  fi
}
