sdkman::install() {
  curl -s https://get.sdkman.io | head -n -35 | bash
}

sdkman::configure() {
  :
}

sdkman::is_installed() {
  platform::command_exists sdk
}
