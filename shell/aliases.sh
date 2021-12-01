# Navigation
alias ..="cd .."
alias ...="cd ../.."
alias ls="exa"
alias ll="exa -l"
alias la="exa -la"
alias cdh="cd ~"
alias cdp="cd ~/Projects"
alias cdr="cd ~/Resources"
alias dotfiles="cd ~/.dotfiles"

# Git
alias gaa="git add -A"
alias gc='dot git commit'
alias gca="git add --all && git commit --amend --no-edit"
alias gco="git checkout"
alias gd='dot git pretty-diff'
alias gs="git status -sb"
alias gf="git fetch --all -p"
alias gps="git push"
alias gpsf="git push --force"
alias gpl="git pull --rebase --autostash"
alias gb="git branch"
alias gl='dot git pretty-log'

# Jump arround
alias j="z"

# Docker
alias lzd="lazydocker"
alias dc="dot docker connect"

# IDEs and editors
alias vim="nvim"
alias c.='(code $PWD &>/dev/null &)'

# Utils
alias ping="prettyping --nolegend"
alias htop="btm"
alias k="kill -9"
alias df="pydf"
