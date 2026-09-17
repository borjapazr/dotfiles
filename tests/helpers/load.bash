# Common bootstrap for every test file.

DOTFILES_PATH="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/../.." && pwd)"
export DOTFILES_PATH

load_core() {
  source "$DOTFILES_PATH/commands/core/_main.sh"
}

# A login shell with a scrubbed environment, which is how a CI runner or an
# agent harness reaches these dotfiles. Without `env -i` the parent terminal
# leaks its own exports in and the assertions below pass for the wrong reason.
clean_login_shell() {
  local -r shell="$1" code="$2"
  shift 2

  env -i \
    HOME="$HOME" \
    TERM=xterm-256color \
    PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin \
    "$@" \
    "$shell" -l -c "$code" </dev/null
}

# The shell layer tests drive a real login shell, which only picks these
# dotfiles up once the symlinks are in place. On a bare CI runner they are not,
# and a test that silently passes against an unconfigured shell is worse than
# one that says it was skipped.
require_installed_shell() {
  command -v zsh >/dev/null || skip "zsh is not installed"
  [ "$(clean_login_shell zsh 'echo "${DOTFILES_PATH:-}"' 2>/dev/null)" = "$DOTFILES_PATH" ] ||
    skip "dotfiles are not installed for this user"
}
