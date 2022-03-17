#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Speakers
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🔊
# @raycast.packageName Audio Utils

# Documentation:
# @raycast.author Borja Paz Rodríguez
# @raycast.authorURL https://github.com/borjapazr
# @raycast.description Sets speakers as output audio device

SwitchAudioSource -t system -s "Auriculares externos"
SwitchAudioSource -t input -s "MacBook Pro (micrófono)"
SwitchAudioSource -t output -s "Auriculares externos"
