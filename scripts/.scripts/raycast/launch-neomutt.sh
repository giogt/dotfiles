#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Neomutt
# @raycast.mode silent

# Optional parameters:
# @raycast.icon ../icons/neomutt/neomutt-64.png
# @raycast.packageName Utilities

# Documentation:
# @raycast.description A command line mail reader.
# @raycast.author giogt

open -na /Applications/Ghostty.app/Contents/MacOS/ghostty --args --title="Neomutt" --window-width=160 --window-height=55 --quit-after-last-window-closed=true --command=neomutt
