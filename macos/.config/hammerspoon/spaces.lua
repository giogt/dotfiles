local hs = hs
local spaces = require("hs.spaces")

-- ------------------------------------
-- Move window to space
-- ------------------------------------

-- This would be awesome, but unfortunately it doesn't work.

-- local moveToSpaceMod = { "ctrl", "alt", "shift" }

-- local function move_win_to_space(key, sp)
-- 	hs.hotkey.bind(moveToSpaceMod, key, function()
-- 		local win = hs.window.focusedWindow()
-- 		local screenUUID = win:screen():getUUID()
-- 		local spaceID = spaces.allSpaces()[screenUUID][sp]
-- 		if spaceID then
-- 			spaces.moveWindowToSpace(win:id(), spaceID)
-- 			spaces.gotoSpace(spaceID)
-- 		end
-- 	end)
-- end

-- move_win_to_space("J", 1)
-- move_win_to_space("K", 2)
-- move_win_to_space("L", 3)
-- move_win_to_space(";", 4)
-- move_win_to_space("U", 5)
-- move_win_to_space("I", 6)
-- move_win_to_space("O", 7)
-- move_win_to_space("P", 8)

-- ------------------------------------
-- Go to space
-- ------------------------------------

-- Go to a specific space doesn't work as good as the built-in MacOS functionality.
-- Therefore, better to keep this disabled and use MacOS Mission Control keyboard shortcuts instead.

-- local goToSpaceMod = { "ctrl", "alt" }

-- local function go_to_space(key, sp)
-- 	hs.hotkey.bind(goToSpaceMod, key, function()
-- 		local win = hs.window.focusedWindow()
-- 		local screenUUID = win:screen():getUUID()
-- 		local spaceID = spaces.allSpaces()[screenUUID][sp]
-- 		if spaceID then
-- 			spaces.gotoSpace(spaceID)
-- 		end
-- 	end)
-- end

-- go_to_space("J", 1)
-- go_to_space("K", 2)
-- go_to_space("L", 3)
-- go_to_space(";", 4)
-- go_to_space("U", 5)
-- go_to_space("I", 6)
-- go_to_space("O", 7)
-- go_to_space("P", 8)
