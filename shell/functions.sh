function cdd() {
  cd "$(/bin/ls -d -- */ | fzf --height 50%)" || echo "Invalid directory"
}

function open() {
  dot system open "$@"
}

function echos() {
  counter=0
  limit="${1:-22}"
  while [ $limit -ge $counter ]; do
    echo "--------------------------------------------------------------------------------"
    let counter=$counter+1
  done
}

function fif() {
  if [ ! "$#" -gt 0 ]; then
    echo "Need a string to search for!"
    return 1
  fi
  rg --files-with-matches --no-messages "$1" | fzf --preview "highlight -O ansi -l {} 2> /dev/null | rg --colors 'match:bg:yellow' --ignore-case --pretty --context 10 '$1' || rg --ignore-case --pretty --context 10 '$1' {}"
}

function mkd() {
  mkdir -p "$@" && cd "$_" || exit
}

function tre() {
  tree -aC -I '.git|node_modules|bower_components' --dirsfirst "$@" | less -FRNX
}

function precmd() {
  precmd() {
    echo
  }
}
