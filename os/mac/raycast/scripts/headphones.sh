#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Headphones
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🎧
# @raycast.packageName Audio Utils

# Documentation:
# @raycast.author Borja Paz Rodríguez
# @raycast.authorURL https://github.com/borjapazr
# @raycast.description Sets headphones as output audio device

SwitchAudioSource -t system -s "Sennheiser USB headset"
SwitchAudioSource -t input -s "Sennheiser USB headset"
SwitchAudioSource -t output -s "Sennheiser USB headset"
