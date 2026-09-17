git::is_in_repo() {
  git rev-parse --git-dir >/dev/null 2>&1
}

# `git branch` listed every branch with a leading marker; callers want the name.
git::current_branch() {
  git rev-parse --abbrev-ref HEAD 2>/dev/null
}

git::clone_if_not_exists() {
  [[ -d "$2" ]] || git clone "$1" "$2"
}
