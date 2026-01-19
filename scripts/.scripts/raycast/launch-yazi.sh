#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Yazi
# @raycast.mode silent

# Optional parameters:
# @raycast.icon ../icons/yazi/icon_64x64.png
# @raycast.packageName Utilities

# Documentation:
# @raycast.description A terminal file manager.
# @raycast.author giogt

open -na /Applications/Ghostty.app/Contents/MacOS/ghostty --args --window-width=160 --window-height=55 --quit-after-last-window-closed=true --command=yazi
