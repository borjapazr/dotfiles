#!/usr/bin/env bash

set -euo pipefail

source "$DOTFILES_PATH/scripts/core/_main.sh"

MAKEFILE_TEMPLATE="$DOTFILES_PATH/resources/templates/Makefile.template"

##? Create a Makefile file from a base template
##?
##? Usage:
##?    makefile
docs::parse "$@"

cp "$MAKEFILE_TEMPLATE" "$PWD"/Makefile
