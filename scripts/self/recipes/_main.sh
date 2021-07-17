RECIPES="{brew,chrome,docker,tlp}.sh"

source "$DOTFILES_PATH/scripts/core/_main.sh"

recipes::install() {
  for file in $DOTFILES_PATH/scripts/self/recipes/{brew,chrome,docker,tlp}.sh; do

    local recipe=$(basename -- "$file" .sh)

    log::note "🫕 Installing $recipe..."

    if ! ${DOT_RECIPES_SOURCED:-false}; then
      source "$file";
    fi

    if ! "$recipe::is_installed"; then
      "$recipe::install";
      "$recipe::configure";
    fi

  done;
  unset file;

  readonly DOT_RECIPES_SOURCED=true
}
