git::clone_if_not_exists() {
  if [ ! -d "$2" ]; then
    git clone $1 $2
  fi
}
