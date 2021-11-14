# shellcheck disable=SC2260
docker::install() {
  if platform::is_linux; then
    if platform::command_exists apt-mark; then
      sudo apt-get remove -y docker docker-engine docker.io containerd runc 2>&1 | log::file "🆑 Removing old docker packages"
      sudo apt-get install -y ca-certificates curl gnupg lsb-release 2>&1 | log::file "📥 Installing docker dependencies"
      curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --batch --yes --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg 2>&1 | log::file "➕ Adding docker GPG keys"
      echo \
        "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
          $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list >/dev/null | log::file "➕ Adding docker repository"
      sudo apt-get update -y 2>&1 | log::file "🔃 Updating system"
      sudo apt-get install -y docker-ce docker-ce-cli containerd.io 2>&1 | log::file "📥 Installing docker"
    fi
  fi
}

docker::post_install() {
  if platform::is_linux; then
    sudo groupadd docker 2>&1 | log::file "🎫 Creating docker group"
    sudo usermod -aG docker $USER 2>&1 | log::file "🎫 Adding user to docker group"
  fi
}

docker::is_installed() {
  platform::command_exists docker
}
