# Add directory to $PATH if it's not already there
_pathadd() {
  PATH="$1${PATH:+":$PATH"}"
}

# Default editor
export EDITOR='vim'

# Default browser
export BROWSER="$DOTFILES_PATH/bin/chrome"

# Default pager
export PAGER='less'

# JVM
export MAVEN_OPTS="-Xmx1024m -Xdebug -Xrunjdwp:transport=dt_socket,address=8787,server=y,suspend=n"
export JAVA_TOOLS_OPTIONS='-Dfile.encoding="UTF-8"'

# Golang
export GOPATH="${HOME}/.go"
export GOBIN="${GOPATH}/bin"

# GPG
GPG_TTY=$(tty)
export GPG_TTY

# Homebrew
export HOMEBREW_AUTO_UPDATE_SECS=604800
export HOMEBREW_NO_ANALYTICS=true

# asdf
export ASDF_DATA_DIR="$HOME/.asdf"

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

export BAT_THEME='gruvbox-dark'

CUSTOM_PATH_LIST=(
  "/sbin"
  "/usr/bin"
  "/bin"
  "/usr/local/bin"
  "$HOME/.local/bin"
  "/home/linuxbrew/.linuxbrew/bin"
  "/home/linuxbrew/.linuxbrew/sbin"
  "/opt/homebrew/bin"
  "/opt/homebrew/sbin"
  "/opt/homebrew/opt/coreutils/libexec/gnubin"
  "$HOME/.composer/vendor/bin"
  "$HOME/.config/composer/vendor/bin"
  "$GOBIN"
  "$HOME/.rd/bin"
  "$HOME/bin"
  "${ASDF_DATA_DIR:-$HOME/.asdf}/shims"
  "$DOTFILES_PATH/bin"
  "$DOTFILES_PATH/bin/external"
)

for val in "${CUSTOM_PATH_LIST[@]}"; do
  _pathadd $val
done
