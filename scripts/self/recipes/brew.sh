brew::install() {
  if platform::is_macos; then
    if platform::is_macos_arm; then
      export PATH="$PATH:/opt/homebrew/bin:/usr/local/bin"
    else
      export PATH="$PATH:/usr/local/bin"
    fi
  else
    export PATH="$PATH:/home/linuxbrew/.linuxbrew/bin"
  fi

  echo | /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" 2>&1 | log::file "📦 Installing brew"
}

brew::post_install() {
  :
}

brew::is_installed() {
  platform::command_exists brew
}
