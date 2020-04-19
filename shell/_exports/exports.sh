paths=(
  "$DOTFILES_PATH/bin"
  /usr/local/sbin
  /usr/local/bin
  /usr/sbin
  /usr/bin
  /sbin
  /bin
  /usr/games
  /usr/local/games
  /snap/bin
  /usr/lib/jvm/java-14-oracle/bin
  /usr/lib/jvm/java-14-oracle/db/bin
  /home/borja/.fzf/bin
)

PATH=$(
  IFS=":"
  echo "${paths[*]}"
)

export PATH
export EDITOR='vim'
