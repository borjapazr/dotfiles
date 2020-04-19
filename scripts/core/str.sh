#!/usr/bin/env bash

str::split() {
  local -r text=$1
  local -r splitter=$2

  echo "$text" | tr "$splitter" "\n"
}

str::urlencode() {
   local data
   data="$(curl -s -o /dev/null -w %{url_effective} --get --data-urlencode "$1" "")"
   if [[ $? != 3 ]]; then
      echo "Unexpected error" 1>&2
      return 2
   fi
   echo "${data##/?}"
   return 0
}
