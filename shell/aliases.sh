# Navigation
alias ..="cd .."
alias ...="cd ../.."
alias ls="eza --icons --group-directories-first"
alias ll="eza --icons --group-directories-first -l"
alias la="eza --icons --group-directories-first -la"
alias lsa="eza --icons --group-directories-first -lah"
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
alias i.='(idea $PWD &>/dev/null &)'
alias c.='(code $PWD &>/dev/null &)'
alias o.='open .'

# Utils
alias ping="prettyping --nolegend"
alias htop="btm"
alias k="kill -9"
alias df="pydf"

# Networking
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip="ipconfig getifaddr en0"
alias ips="ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"
alias ifactive="ifconfig | pcregrep -M -o '^[^\t:]+:([^\n]|\n\t)*status: active'"

# Show/hide hidden files in Finder
alias show="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
alias hide="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"
