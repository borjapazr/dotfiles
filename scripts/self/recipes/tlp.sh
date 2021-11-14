tlp::install() {
  :
}

tlp::post_install() {
  sudo systemctl enable tlp
  sudo tlp start
}

tlp::is_installed() {
  platform::command_exists tlp
}
