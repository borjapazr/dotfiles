ulimit -u 10000

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        . "/home/borja/.bashrc"
    fi

    # source .zshenv (for $ZSH) and .zprofile (for $PATH) if they exist
    if [ -f "$HOME/.zshenv" ] && [ -f "$HOME/.zprofile" ]; then
        . "$HOME/.zshenv"
        . "$HOME/.zprofile"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# Load Homebrew
eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
