# Parse the calling script's `##?` docblock.
#
# With docpars available the docblock is a real docopt spec: flags and operands
# are validated and exported as shell variables. Without it, `-h`/`--help` still
# has to work, so fall back to printing the docblock verbatim — a missing
# optional dependency must not turn `dot foo bar -h` into silence.
docs::parse() {
  if platform::command_exists docpars; then
    eval "$(docpars -h "$(docs::docblock)" : "$@")"
    return
  fi

  local arg
  for arg in "$@"; do
    case $arg in
    -h | --help)
      docs::docblock
      exit 0
      ;;
    esac
  done
}

docs::docblock() {
  grep '^##?' "$0" | cut -c 5-
}
