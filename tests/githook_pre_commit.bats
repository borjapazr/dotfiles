#!/usr/bin/env bats
#
# The pre-commit hook deliberately duplicates the file detection and the
# severity threshold of `dot self lint` instead of sourcing the core library: a
# hook that depends on the code it guards cannot be used to commit the fix for a
# broken core. The duplication is only safe while both sides agree, so assert
# the agreement here rather than removing it.

setup() {
  load helpers/load

  HOOK="$DOTFILES_PATH/.githooks/pre-commit"
}

# A throwaway repository with the hook installed, so the assertions below drive
# the real thing through a real `git commit` instead of calling into its guts.
setup_repo() {
  REPO="$(mktemp -d)"
  git -C "$REPO" init -q
  git -C "$REPO" config user.email test@example.com
  git -C "$REPO" config user.name test
  git -C "$REPO" config commit.gpgsign false
  mkdir -p "$REPO/.githooks"
  cp "$HOOK" "$REPO/.githooks/pre-commit"
  git -C "$REPO" config core.hooksPath .githooks
}

teardown() {
  [ -n "${REPO:-}" ] && rm -rf "$REPO"
  return 0
}

@test "the hook and dot self lint share the shellcheck threshold" {
  grep -q -- '-S warning' "$HOOK"
  grep -q -- '-S warning' "$DOTFILES_PATH/commands/self/lint"
}

@test "the hook and dot self lint share the shfmt indentation" {
  grep -q -- '-i 2' "$HOOK"
  grep -q -- '-i 2' "$DOTFILES_PATH/commands/self/format"
}

@test "the hook and dot::list_bash_files agree on what counts as a bash file" {
  load_core

  local extensions
  extensions="$(sed -n '/case \$file in/,/esac/p' "$DOTFILES_PATH/commands/core/dot.sh")"

  # Both sides classify by extension first and by shebang second. Whatever
  # extensions the library accepts, the hook has to accept too.
  [[ $extensions == *".sh | *.bash"* ]]
  grep -q '\*\.sh | \*\.bash)' "$HOOK"
  grep -q "'#!'\*bash\*)" "$HOOK"
}

@test "the hook rejects a commit that would leak a machine-local file" {
  setup_repo

  echo 'export TOKEN=secret' >"$REPO/local.sh"
  git -C "$REPO" add -f local.sh

  run git -C "$REPO" commit -q -m "should not happen"
  [ "$status" -ne 0 ]
  [[ $output == *"machine-local"* ]]
}

@test "the hook rejects a staged bash file that shellcheck flags" {
  command -v shellcheck >/dev/null || skip "shellcheck is not installed"
  setup_repo

  printf '#!/usr/bin/env bash\n\nfoo=1\necho $undefined_and_unquoted\n' >"$REPO/broken.sh"
  git -C "$REPO" add broken.sh

  run git -C "$REPO" commit -q -m "should not happen"
  [ "$status" -ne 0 ]
}

@test "the hook ignores files that are not bash" {
  setup_repo

  printf 'hello\n' >"$REPO/notes.txt"
  git -C "$REPO" add notes.txt

  run git -C "$REPO" commit -q -m "plain text is none of the hook's business"
  [ "$status" -eq 0 ]
}

@test "the hook only looks at what is staged, not at the whole tree" {
  command -v shellcheck >/dev/null || skip "shellcheck is not installed"
  setup_repo

  printf '#!/usr/bin/env bash\n\necho $undefined_and_unquoted\n' >"$REPO/dirty.sh"
  printf '#!/usr/bin/env bash\n\necho "clean"\n' >"$REPO/clean.sh"
  git -C "$REPO" add clean.sh

  run git -C "$REPO" commit -q -m "an untouched dirty file must not block this"
  [ "$status" -eq 0 ]
}
