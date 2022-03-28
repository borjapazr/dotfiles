# Fig pre block. Keep at the top of this file.
eval "$($HOME/.local/bin/fig init zsh pre)"

# Load Homebrew
if [ -f "/home/linuxbrew/.linuxbrew/bin/brew" ]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
elif [ -f "/opt/homebrew/bin/brew" ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -f "/usr/local/bin/brew" ]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

# Fig post block. Keep at the bottom of this file.
eval "$($HOME/.local/bin/fig init zsh post)"
