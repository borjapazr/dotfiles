function cdd() {
  cd "$(ls -d -- */ | fzf --height 50%)" || echo "Invalid directory"
}

function recent_dirs() {
  # This script depends on pushd. It works better with autopush enabled in ZSH
  escaped_home=$(echo $HOME | sed 's/\//\\\//g')
  selected=$(dirs -p | sort -u | fzf --height 50%)

  cd "$(echo "$selected" | sed "s/\~/$escaped_home/")" || echo "Invalid directory"
}

function open() {
  dot system open "$@"
}

function pbcopy() {
  dot system clip copy
}

function pbpaste() {
  dot system clip paste
}

function echos() {
  limit="${1:-22}"
  for i in {1..$limit}
    do
      echo "--------------------------------------------------------------------------------"
    done
}