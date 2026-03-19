#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Yazi
# @raycast.mode silent

# Optional parameters:
# @raycast.icon ../icons/yazi/logo.png
# @raycast.packageName Utilities

# Documentation:
# @raycast.description A terminal file manager.
# @raycast.author giogt

# Open with Ghostty
# open -na /Applications/Ghostty.app/Contents/MacOS/ghostty --args --window-width=160 --window-height=55 --quit-after-last-window-closed=true --command=yazi

# Open with Alacritty
open -na /Applications/Alacritty.app/Contents/MacOS/alacritty --args --title "Yazi" --command yazi $HOME
