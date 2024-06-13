# shellcheck disable=SC2260
podman::install() {
  if platform::is_linux; then
    if platform::command_exists apt-mark; then
      sudo apt-get remove -y podman 2>&1 | log::file "🆑 Removing old podman packages"
      sudo apt-get install -y software-properties-common 2>&1 | log::file "📥 Installing podman dependencies"
      sudo apt-get update -y 2>&1 | log::file "🔃 Updating system"
      sudo apt-get install -y podman 2>&1 | log::file "📥 Installing podman"
    fi
  fi
}

podman::post_install() {
  :
}

podman::is_installed() {
  platform::command_exists podman
}
