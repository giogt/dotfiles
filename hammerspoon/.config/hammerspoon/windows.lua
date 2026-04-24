local hs = hs

-- ------------------------------------
-- Apps
-- ------------------------------------

local apps = require("apps")

-- ------------------------------------
-- Config
-- ------------------------------------

-- Disable window animations
hs.window.animationDuration = 0

-- ------------------------------------
-- Utility functions
-- ------------------------------------

local addBindingToFocusedWindow = function(mod, key, func)
	hs.hotkey.bind(mod, key, function()
		local win = hs.window.focusedWindow()
		if win ~= nil then
			func(win)
		end
	end)
end

-- ------------------------------------
-- Switch apps
-- ------------------------------------

-- Switch to the app with the specified app identifier
--
-- Valid identifiers: name, bundleID, and full path (see Hammerspoon API)
local switchToApp = function(appIdentifier)
	hs.application.open(appIdentifier)
end

-- Register key bindings to switch to apps
for _, app in pairs(apps) do
	if app.switchKey then
		hs.hotkey.bind({ "alt" }, app.switchKey, function()
			switchToApp(app.bundleID or app.name)
		end)
	end
end

-- ------------------------------------
-- Move windows
-- ------------------------------------

local moveWinMod = { "ctrl", "alt", "cmd" }
local moveIncrX = 50
local moveIncrY = 35

addBindingToFocusedWindow(moveWinMod, "Left", function(win)
	local frame = win:frame()
	frame.x = frame.x - moveIncrX
	win:setFrame(frame)
end)

addBindingToFocusedWindow(moveWinMod, "Right", function(win)
	local frame = win:frame()
	frame.x = frame.x + moveIncrX
	win:setFrame(frame)
end)

addBindingToFocusedWindow(moveWinMod, "Up", function(win)
	local frame = win:frame()
	frame.y = frame.y - moveIncrY
	win:setFrame(frame)
end)

addBindingToFocusedWindow(moveWinMod, "Down", function(win)
	local frame = win:frame()
	frame.y = frame.y + moveIncrY
	win:setFrame(frame)
end)

-- ------------------------------------
-- Snap windows
-- ------------------------------------

local snapWinMod = { "ctrl", "alt" }
local snapMarginX = 5
local snapMarginY = 5

addBindingToFocusedWindow(snapWinMod, "Left", function(win)
	local winFrame = win:frame()
	local screenFrame = win:screen():frame()
	winFrame.x = screenFrame.x + snapMarginX
	win:setFrame(winFrame)
end)
addBindingToFocusedWindow(snapWinMod, "Right", function(win)
	local winFrame = win:frame()
	local screenFrame = win:screen():frame()
	winFrame.x = screenFrame.w - winFrame.w - snapMarginX
	win:setFrame(winFrame)
end)
addBindingToFocusedWindow(snapWinMod, "Up", function(win)
	local winFrame = win:frame()
	local screenFrame = win:screen():frame()
	winFrame.y = screenFrame.y + snapMarginY
	win:setFrame(winFrame)
end)
addBindingToFocusedWindow(snapWinMod, "Down", function(win)
	local winFrame = win:frame()
	local screenFrame = win:screen():frame()
	winFrame.y = screenFrame.h - winFrame.h - snapMarginY
	win:setFrame(winFrame)
end)

-- ------------------------------------
-- Window size and dimension
-- ------------------------------------

local setWindowFrame = function(win, dimensions, offset)
	offset = offset or { x = 0, y = 0 }

	local screen = win:screen():frame()

	local topMargin = 5
	local verticalShift = dimensions.h * 0.05 + 20

	local x = screen.x + (screen.w - dimensions.w) / 2
	local y = screen.y + (screen.h - dimensions.h) / 2 - verticalShift

	x = math.max(x, screen.x)
	y = math.max(y, screen.y + topMargin)
	if dimensions.h >= screen.h - topMargin then
		y = screen.y
	end

	win:setFrame({ x = x + offset.x, y = y + offset.y, w = dimensions.w, h = dimensions.h })
	win:focus()
end

addBindingToFocusedWindow({ "ctrl", "alt" }, "D", function(win)
	local button, input =
		hs.dialog.textPrompt("Window dimensions", "Enter dimensions (WxH):", "1600x1150", "OK", "Cancel")

	if button == "OK" then
		local w, h = input:match("(%d+)x(%d+)")
		if w and h then
			w, h = tonumber(w), tonumber(h)

			setWindowFrame(win, { w = w, h = h })
		else
			hs.alert.show("Invalid format. Use <width>x<height> (e.g. 1600x1150)")
		end
	end
end)

-- -----------------------------------------------------------------------------
-- Set default size and position for the current window
-- -----------------------------------------------------------------------------

addBindingToFocusedWindow({ "alt" }, "S", function(win)
	local bundleID = win:application():bundleID()
	local appConfig = apps[bundleID]
	if appConfig ~= nil then
		setWindowFrame(win, appConfig.dimensions, appConfig.offset)
	end
end)
