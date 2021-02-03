
# Default editor
export EDITOR='vim'

# Default browser
export BROWSER='google-chrome'

# Default pager
export PAGER='less'

# JVM
export MAVEN_OPTS="-Xmx1024m -XX:MaxPermSize=512M -Xdebug -Xrunjdwp:transport=dt_socket,address=8787,server=y,suspend=n"
export JAVA_TOOLS_OPTIONS='-Dfile.encoding="UTF-8"'

# Golang
export GOPATH="${HOME}/.go"
export GOBIN="${GOPATH}/bin"


export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS"
  --color=fg:#e5e9f0,hl:#81a1c1
  --color=fg+:#e5e9f0,bg+:#3b4252,hl+:#81a1c1,border:#3c6e71
  --color=info:#eacb8a,prompt:#bf6069,pointer:#b48dac
  --color=marker:#a3be8b,spinner:#b48dac,header:#a3be8b
  --layout=reverse
  --preview-window right:sharp:wrap
  --padding=0,0,0,0
  --preview '([[ -f {} ]] && (bat --style=numbers --color=always {} || cat {})) || ([[ -d {} ]] && (tree -C {} | less)) || echo {} 2> /dev/null | head -200'
  --pointer='▶' --marker='✓'
  --bind '?:toggle-preview'
  --info=inline
"
export FORGIT_FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS$FORGIT_FZF_DEFAULT_OPTS

CUSTOM_PATH_LIST=(
  "$DOTFILES_PATH/bin"
  "$DOTFILES_PATH/bin/external"
  "$GOBIN"
  "/home/linuxbrew/.linuxbrew/bin"
  "/home/linuxbrew/.linuxbrew/sbin"
  "/usr/lib/jvm/java-15-oracle/bin"
  "/usr/lib/jvm/java-15-oracle/db/bin"
)

CUSTOM_PATH=$(
  IFS=":"
  echo "${CUSTOM_PATH_LIST[*]}"
)

export PATH="${CUSTOM_PATH}:${PATH}"
