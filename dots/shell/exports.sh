# Prepend directory to $PATH. No per-entry existence check on purpose: stat'ing
# every candidate is costly under endpoint security (Defender), and non-existent
# directories in $PATH are harmless. The already-present check is a plain string
# match — no fork, no stat — and it matters because a login shell sources this
# file twice (.zprofile/.bash_profile, then .zshrc/.bashrc): without it $PATH ends
# up with ~20 duplicated entries, doubling the lookups for every command miss.
_pathadd() {
  case ":$PATH:" in
  *":$1:"*) ;;
  *) PATH="$1${PATH:+":$PATH"}" ;;
  esac
}

# Remove a directory from $PATH. Same fork-free string surgery as _pathadd; also
# collapses any duplicate occurrences of $1.
_pathdel() {
  case ":$PATH:" in
  *":$1:"*)
    PATH=":$PATH:"
    PATH=${PATH//":$1:"/":"}
    PATH=${PATH#:}
    PATH=${PATH%:}
    ;;
  esac
}

# Default editor
export EDITOR='vim'

# Default browser
export BROWSER="$DOTFILES_PATH/bin/chrome"

# Default pager
export PAGER="cat"
export GH_PAGER="cat"
export GIT_PAGER="cat"
export MANPAGER="cat"

# JVM
export MAVEN_OPTS="-Xmx1024m -Xdebug -Xrunjdwp:transport=dt_socket,address=8787,server=y,suspend=n"
export JAVA_TOOLS_OPTIONS='-Dfile.encoding="UTF-8"'

# Golang
export GOPATH="${HOME}/.go"
export GOBIN="${GOPATH}/bin"

# GPG ($TTY is set by zsh without forking; fallback for bash)
GPG_TTY=${TTY:-$(tty)}
export GPG_TTY

# Homebrew
export HOMEBREW_AUTO_UPDATE_SECS=604800
export HOMEBREW_NO_ANALYTICS=true

# asdf
export ASDF_DATA_DIR="$HOME/.asdf"

# Appended rather than assigned so whatever private-stuff.sh set survives, and
# guarded so it is not appended again: this file is sourced twice per login shell
# and every nested shell inherits the exported value, which grew the variable to
# 1152 chars with `--layout=reverse` repeated four times.
_dotfiles_fzf_opts="
  --color=fg:#e5e9f0,hl:#81a1c1
  --color=fg+:#e5e9f0,bg+:#3b4252,hl+:#81a1c1,border:#3c6e71
  --color=info:#eacb8a,prompt:#bf6069,pointer:#b48dac
  --color=marker:#a3be8b,spinner:#b48dac,header:#a3be8b
  --layout=reverse
  --padding=0,0,0,0
  --pointer='▶' --marker='✓'
  --info=inline
"

case $FZF_DEFAULT_OPTS in
*layout=reverse*) ;;
*) export FZF_DEFAULT_OPTS="${FZF_DEFAULT_OPTS}${_dotfiles_fzf_opts}" ;;
esac

case $FORGIT_FZF_DEFAULT_OPTS in
*layout=reverse*) ;;
*) export FORGIT_FZF_DEFAULT_OPTS="${FZF_DEFAULT_OPTS}${FORGIT_FZF_DEFAULT_OPTS}" ;;
esac

unset _dotfiles_fzf_opts

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

# Delete before prepending so CUSTOM_PATH_LIST — not whatever seeded $PATH first —
# decides the order, and so re-sourcing this file is idempotent (a login shell does
# it twice). Without the delete, macOS's path_helper keeps /etc/paths.d/homebrew
# ahead of the asdf shims and behind /usr/bin, so `python3` resolved to brew while
# `python` came from asdf, and Apple's vim/jq/openssl shadowed brew's.
for val in "${CUSTOM_PATH_LIST[@]}"; do
  _pathdel $val
  _pathadd $val
done
