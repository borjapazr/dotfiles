# shellcheck disable=SC2260
docker::install() {
  if platform::is_linux; then
    if platform::command_exists apt-mark; then
      sudo apt-get remove -y docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc 2>&1 | log::file "🆑 Removing old docker packages"
      sudo apt-get install -y ca-certificates curl gnupg lsb-release 2>&1 | log::file "📥 Installing docker dependencies"
      sudo install -m 0755 -d /etc/apt/keyrings 2>&1 | log::file "✅ Created /etc/apt/keyrings directory with permissions 0755"
      sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc 2>&1 | log::file "📥 Downloaded Docker GPG key to /etc/apt/keyrings/docker.asc"
      sudo chmod a+r /etc/apt/keyrings/docker.asc 2>&1 | log::file "🔒 Set read permissions for all users on Docker GPG key file"
      echo \
        "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
        $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list >/dev/null | log::file "➕ Adding docker repository"
      sudo apt-get update -y 2>&1 | log::file "🔃 Updating system"
      sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin 2>&1 | log::file "📥 Installing docker"
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
