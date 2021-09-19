brew::install() {
  bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  /home/linuxbrew/.linuxbrew/bin/brew update
}

brew::configure() {
  :
}

brew::is_installed() {
  platform::command_exists brew
}
