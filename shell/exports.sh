# Add directory to $PATH if it's not already there
_pathadd() {
  PATH="$1${PATH:+":$PATH"}"
}

# Default editor
export EDITOR='vim'

# Default browser
export BROWSER='google-chrome'

# Default pager
export PAGER='less'

# JVM
export MAVEN_OPTS="-Xmx1024m -Xdebug -Xrunjdwp:transport=dt_socket,address=8787,server=y,suspend=n"
export JAVA_TOOLS_OPTIONS='-Dfile.encoding="UTF-8"'

# Golang
export GOPATH="${HOME}/.go"
export GOBIN="${GOPATH}/bin"

export GPG_TTY=$TTY

# Homebrew
export HOMEBREW_AUTO_UPDATE_SECS=604800
export HOMEBREW_NO_ANALYTICS=true

# asdf
export ASDF_DATA_DIR="$HOME/.asdf"

# Rancher
export DOCKER_HOST="unix://${HOME}/.rd/docker.sock"

export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS"
  --color=fg:#e5e9f0,hl:#81a1c1
  --color=fg+:#e5e9f0,bg+:#3b4252,hl+:#81a1c1,border:#3c6e71
  --color=info:#eacb8a,prompt:#bf6069,pointer:#b48dac
  --color=marker:#a3be8b,spinner:#b48dac,header:#a3be8b
  --layout=reverse
  --padding=0,0,0,0
  --pointer='▶' --marker='✓'
  --info=inline
"
export FORGIT_FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS$FORGIT_FZF_DEFAULT_OPTS

CUSTOM_PATH_LIST=(
  "$HOME/.local/bin"
  "/home/linuxbrew/.linuxbrew/bin"
  "/home/linuxbrew/.linuxbrew/sbin"
  "/opt/homebrew/bin"
  "/opt/homebrew/sbin"
  "/opt/homebrew/opt/coreutils/libexec/gnubin"
  "/usr/local/bin"
  "$DOTFILES_PATH/bin"
  "$DOTFILES_PATH/bin/external"
  "$GOBIN"
  "$HOME/.composer/vendor/bin"
  "$HOME/.config/composer/vendor/bin"
  "$HOME/.rd/bin"
)

for val in "${CUSTOM_PATH_LIST[@]}"; do
  _pathadd $val
done
