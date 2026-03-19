#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Bottom (btm)
# @raycast.mode silent

# Optional parameters:
# @raycast.icon ../icons/btm/icon_64x64.png
# @raycast.packageName Utilities

# Documentation:
# @raycast.description A process/system monitor for the terminal.
# @raycast.author giogt

# Open with Ghostty
# open -na /Applications/Ghostty.app/Contents/MacOS/ghostty --args --title="Bottom (btm)" --window-width=160 --window-height=55 --quit-after-last-window-closed=true --command=btm

# Open with Alacritty
open -na /Applications/Alacritty.app/Contents/MacOS/alacritty --args --title "Bottom (btm)" --command btm
