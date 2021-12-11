git::is_in_repo() {
  git rev-parse HEAD >/dev/null 2>&1
}

git::current_branch() {
  git branch
}

git::clone_if_not_exists() {
  if [ ! -d "$2" ]; then
    git clone $1 $2
  fi
}
