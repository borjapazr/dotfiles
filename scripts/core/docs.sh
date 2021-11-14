docs::parse() {
  if platform::command_exists docpars; then
    eval "$(docpars -h "$(grep "^##?" "$0" | cut -c 5-)" : "$@")"
  fi
}
