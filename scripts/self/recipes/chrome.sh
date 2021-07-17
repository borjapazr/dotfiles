chrome::install() {
  sudo wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -P /tmp
  sudo gdebi -n /tmp/google-chrome-stable_current_amd64.deb
  sudo rm -rf /tmp/google-chrome-stable_current_amd64.deb
}

chrome::configure() {
  :
}

chrome::is_installed() {
  platform::command_exists google-chrome
}
