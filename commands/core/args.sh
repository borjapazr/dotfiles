args::total_is() {
  local -r total_expected="$1"
  shift

  [[ $# -eq $total_expected ]]
}

args::has_no_args() {
  args::total_is 0 "$@"
}
