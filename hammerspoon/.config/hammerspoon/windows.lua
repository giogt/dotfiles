local hs = hs

-- ------------------------------------
-- Apps
-- ------------------------------------

local _apps = require("apps")
local _appsByName = {}
for _, app in pairs(_apps) do
	_appsByName[app.name] = app
end

-- ------------------------------------
-- Config
-- ------------------------------------

-- Disable window animations
hs.window.animationDuration = 0

-- Start and use isolate mode
-- hs.window.highlight.ui.overlay = true
-- hs.window.highlight.start()
-- hs.window.highlight.toggleIsolate()

-- ------------------------------------
-- Utility functions
-- ------------------------------------

local addWindowBinding = function(mod, key, func)
	hs.hotkey.bind(mod, key, function()
		local win = hs.window.focusedWindow()
		if not win then
			return
		end
		func(win)
	end)
end

local setWindowFrame = function(win, dimensions, offset)
	offset = offset or { x = 0, y = 0 }

	local screen = win:screen():frame()

	local x = screen.x + (screen.w - dimensions.w) / 2
	local y = screen.y + (screen.h - dimensions.h) / 2

	x = math.max(x, screen.x)
	y = math.max(y, screen.y)

	if y > 100 then
		y = 100
	end

	win:setFrame({ x = x + offset.x, y = y + offset.y, w = dimensions.w, h = dimensions.h })
	win:focus()
end

local hideOtherApps = function()
	local frontApp = hs.application.frontmostApplication()
	for _, app in ipairs(hs.application.runningApplications()) do
		if app ~= frontApp and app:isRunning() and not app:isHidden() then
			app:hide()
		end
	end
end

-- Switch to the app with appName, only if the app has a window in the current
-- desktop. If the app is not running, launch it.
local switchToAppInCurrentDesktop = function(appName)
	local app = hs.application.get(appName)
	if not app then
		hs.application.open(appName)
		return
	end

	local currentSpace = hs.spaces.focusedSpace()
	for _, win in ipairs(app:allWindows()) do
		local spaces = hs.spaces.windowSpaces(win)
		if spaces then
			for _, space in ipairs(spaces) do
				if space == currentSpace then
					win:focus()
					hideOtherApps()
					return
				end
			end
		end
	end
end

-- ------------------------------------
-- Switch windows
-- ------------------------------------

for _, app in pairs(_apps) do
	if not app.switchKey then
		return
	end

	hs.hotkey.bind({ "alt" }, app.switchKey, function()
		switchToAppInCurrentDesktop(app.name)
	end)
end

-- ------------------------------------
-- Move window
-- ------------------------------------

local moveWinMod = { "ctrl", "alt", "cmd" }
local moveIncrX = 50
local moveIncrY = 35

addWindowBinding(moveWinMod, "Left", function(win)
	local frame = win:frame()
	frame.x = frame.x - moveIncrX
	win:setFrame(frame)
end)

addWindowBinding(moveWinMod, "Right", function(win)
	local frame = win:frame()
	frame.x = frame.x + moveIncrX
	win:setFrame(frame)
end)

addWindowBinding(moveWinMod, "Up", function(win)
	local frame = win:frame()
	frame.y = frame.y - moveIncrY
	win:setFrame(frame)
end)

addWindowBinding(moveWinMod, "Down", function(win)
	local frame = win:frame()
	frame.y = frame.y + moveIncrY
	win:setFrame(frame)
end)

-- ------------------------------------
-- Snap window
-- ------------------------------------

local snapWinMod = { "ctrl", "alt" }
local snapMarginX = 5
local snapMarginY = 5

addWindowBinding(snapWinMod, "Left", function(win)
	local winFrame = win:frame()
	local screenFrame = win:screen():frame()
	winFrame.x = screenFrame.x + snapMarginX
	win:setFrame(winFrame)
end)
addWindowBinding(snapWinMod, "Right", function(win)
	local winFrame = win:frame()
	local screenFrame = win:screen():frame()
	winFrame.x = screenFrame.w - winFrame.w - snapMarginX
	win:setFrame(winFrame)
end)
addWindowBinding(snapWinMod, "Up", function(win)
	local winFrame = win:frame()
	local screenFrame = win:screen():frame()
	winFrame.y = screenFrame.y + snapMarginY
	win:setFrame(winFrame)
end)
addWindowBinding(snapWinMod, "Down", function(win)
	local winFrame = win:frame()
	local screenFrame = win:screen():frame()
	winFrame.y = screenFrame.h - winFrame.h - snapMarginY
	win:setFrame(winFrame)
end)

-- ------------------------------------
-- Set window dimensions
-- ------------------------------------

hs.hotkey.bind({ "ctrl", "alt" }, "D", function()
	local win = hs.window.focusedWindow()
	if not win then
		return
	end

	local button, input =
		hs.dialog.textPrompt("Window dimensions", "Enter dimensions (WxH):", "1600x1150", "OK", "Cancel")

	if button == "OK" then
		local w, h = input:match("(%d+)x(%d+)")
		if w and h then
			w, h = tonumber(w), tonumber(h)

			setWindowFrame(win, { w = w, h = h })
		else
			hs.alert.show("Invalid format. Use <width>x<height> (e.g. 800x600)")
		end
	end
end)

-- -----------------------------------------------------------------------------
-- Set default size and position for the current window
-- -----------------------------------------------------------------------------

addWindowBinding({ "alt" }, "S", function(win)
	local appName = win:application():name()
	local appConfig = _appsByName[appName]
	if not appConfig then
		return
	end

	setWindowFrame(win, appConfig.dimensions, appConfig.offset)
end)
