export DOTFILES_PATH=$([[ -d "$HOME/.dotfiles" ]] && echo "$HOME/.dotfiles" || echo "/usr/local/share/.dotfiles")

# Fig pre block. Keep at the top of this file.
[[ ! -f $HOME/.local/bin/fig ]] || eval "$($HOME/.local/bin/fig init bash pre)"

if [[ "$(ps -p $$ -ocomm=)" =~ (bash$) ]]; then
  __right_prompt() {
    RIGHT_PROMPT=""
    [[ -n $RPS1 ]] && RIGHT_PROMPT=$RPS1 || RIGHT_PROMPT=$RPROMPT
    if [[ -n $RIGHT_PROMPT ]]; then
      n=$(($COLUMNS - ${#RIGHT_PROMPT}))
      printf "%${n}s$RIGHT_PROMPT\\r"
    fi
  }
  export PROMPT_COMMAND="__right_prompt"
fi

source $DOTFILES_PATH/shell/init.sh

source $DOTFILES_PATH/shell/bash/themes/mrmars.sh

if [ -n "$(ls -A "$DOTFILES_PATH/shell/bash/completions/")" ]; then
  for bash_file in "$DOTFILES_PATH"/shell/bash/completions/_*; do
    source "$bash_file"
  done
fi

# Load z
source $(brew --prefix)/etc/profile.d/z.sh
# Load asdf and asdf plugins
source $(brew --prefix)/opt/asdf/libexec/asdf.sh

# Fig post block. Keep at the bottom of this file.
[[ ! -f $HOME/.local/bin/fig ]] || eval "$($HOME/.local/bin/fig init bash post)"
