function cdd() {
  cd "$(ls -d -- */ | fzf)" || echo "Invalid directory"
}
