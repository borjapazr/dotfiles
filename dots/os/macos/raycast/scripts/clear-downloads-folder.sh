#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Clear Downloads folder
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🗑
# @raycast.packageName System Utils

# Documentation:
# @raycast.author Borja Paz Rodríguez
# @raycast.authorURL https://github.com/borjapazr
# @raycast.description Clear Downloads folder

rm -rf ~/Downloads/*
