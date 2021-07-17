docker::install() {
  :
}

docker::configure() {
  sudo groupadd docker
  sudo gpasswd -a $USER docker
  newgrp docker
}

docker::is_installed() {
  platform::command_exists docker
}
