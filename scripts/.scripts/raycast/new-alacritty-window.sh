#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title New Alacritty window
# @raycast.mode silent

# Optional parameters:
# @raycast.packageName Utilities

# Documentation:
# @raycast.description Opens a new Alacritty window
# @raycast.author giogt

alacritty msg create-window 2>/dev/null && open -a Alacritty || open -a Alacritty
