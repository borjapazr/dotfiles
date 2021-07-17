tlp::install() {
  :
}

tlp::configure() {
  sudo systemctl enable tlp
  sudo tlp start
}

tlp::is_installed() {
  platform::command_exists tlp
}
