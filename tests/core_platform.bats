#!/usr/bin/env bats
#
# Core library: platform detection and dependency guards.

setup() {
  load helpers/load
  load_core
}

@test "platform::command_exists finds a command that is present" {
  run platform::command_exists sh
  [ "$status" -eq 0 ]
}

@test "platform::command_exists rejects a command that is absent" {
  run platform::command_exists definitely-not-a-real-command
  [ "$status" -ne 0 ]
}

@test "platform::require succeeds silently when everything is present" {
  run platform::require sh ls
  [ "$status" -eq 0 ]
  [ -z "$output" ]
}

@test "platform::require names the single missing dependency" {
  run platform::require definitely-not-a-real-command
  [ "$status" -ne 0 ]
  [[ $output == *definitely-not-a-real-command* ]]
}

@test "platform::require reports every missing dependency at once" {
  run platform::require sh missing-one missing-two
  [ "$status" -ne 0 ]
  [[ $output == *missing-one* ]]
  [[ $output == *missing-two* ]]
}

@test "platform::uname_s matches the real uname" {
  run platform::uname_s
  [ "$status" -eq 0 ]
  [ "$output" = "$(uname -s)" ]
}

@test "exactly one of is_macos and is_linux is true" {
  local macos=0 linux=0
  platform::is_macos && macos=1
  platform::is_linux && linux=1
  [ $((macos + linux)) -eq 1 ]
}
