paths=(
  "$DOTFILES_PATH/bin"
  "$DOTFILES_PATH/bin/external"
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
)

PATH=$(
  IFS=":"
  echo "${paths[*]}"
)

export PATH
export EDITOR='vim'
export NAVI_PATH="${DOTFILES_PATH}/cheats"
