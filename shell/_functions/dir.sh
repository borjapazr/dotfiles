function cdd() {
  cd "$(ls -d -- */ | fzf --reverse)" || echo "Invalid directory"
}

function recent_dirs() {
  # This script depends on pushd. It works better with autopush enabled in ZSH
  escaped_home=$(echo $HOME | sed 's/\//\\\//g')
  selected=$(dirs -p | sort -u | fzf --reverse)

  cd "$(echo "$selected" | sed "s/\~/$escaped_home/")" || echo "Invalid directory"
}
