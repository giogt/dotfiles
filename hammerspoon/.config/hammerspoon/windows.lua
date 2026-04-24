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
		if win ~= nil then
			func(win)
		end
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

-- Switch to the app with appName
local switchToApp = function(appName)
	-- In Desktop & Dock settings, I keep the following toggle disabled: "When
	-- switching to an application, switch to a Space with open windows for the
	-- current application".
	--
	-- This behaviour works as intended on MacOS when switching to apps that are
	-- not hidden. When an app is hidden, switching to it automatically unhides
	-- the app and, if the current Space does not have any window for the app, it
	-- automatically switches to a Space which does, even if the setting mentioned
	-- above is disabled.
	--
	-- This is just how MacOS works and, as far as I know, there isn't a way to
	-- change this behaviour.
	--
	-- The code below is a workaround. If the app we are switching to is hidden,
	-- then we are unhiding it first without activating it, and sleep for a
	-- little to make sure the app is fully unhidden before executing the next
	-- steps.
	local app = hs.application.get(appName)
	if app ~= nil then
		if app:isHidden() then
			app:unhide()
			hs.timer.usleep(10000)
		end
	end

	hs.application.open(appName)
	hideOtherApps()
end

-- ------------------------------------
-- Switch apps
-- ------------------------------------

for _, app in pairs(_apps) do
	if app.switchKey then
		hs.hotkey.bind({ "alt" }, app.switchKey, function()
			switchToApp(app.name)
		end)
	end
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

addWindowBinding({ "ctrl", "alt" }, "D", function(win)
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

addWindowBinding({ "alt" }, "S", function(win)
	local appName = win:application():name()
	local appConfig = _appsByName[appName]
	if appConfig ~= nil then
		setWindowFrame(win, appConfig.dimensions, appConfig.offset)
	end
end)
