local hs = hs

-- Disable window animations
hs.window.animationDuration = 0

-- ------------------------------------
-- Move window
-- ------------------------------------

local moveWinMod = { "ctrl", "alt", "cmd" }
local moveIncrX = 50
local moveIncrY = 35

hs.hotkey.bind(moveWinMod, "Left", function()
	local win = hs.window.focusedWindow()
	local frame = win:frame()
	frame.x = frame.x - moveIncrX
	win:setFrame(frame)
end)
hs.hotkey.bind(moveWinMod, "Right", function()
	local win = hs.window.focusedWindow()
	local frame = win:frame()
	frame.x = frame.x + moveIncrX
	win:setFrame(frame)
end)
hs.hotkey.bind(moveWinMod, "Up", function()
	local win = hs.window.focusedWindow()
	local frame = win:frame()
	frame.y = frame.y - moveIncrY
	win:setFrame(frame)
end)
hs.hotkey.bind(moveWinMod, "Down", function()
	local win = hs.window.focusedWindow()
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

hs.hotkey.bind(snapWinMod, "Left", function()
	local win = hs.window.focusedWindow()
	local winFrame = win:frame()
	local screenFrame = win:screen():frame()
	winFrame.x = screenFrame.x + snapMarginX
	win:setFrame(winFrame)
end)
hs.hotkey.bind(snapWinMod, "Right", function()
	local win = hs.window.focusedWindow()
	local winFrame = win:frame()
	local screenFrame = win:screen():frame()
	winFrame.x = screenFrame.w - winFrame.w - snapMarginX
	win:setFrame(winFrame)
end)
hs.hotkey.bind(snapWinMod, "Up", function()
	local win = hs.window.focusedWindow()
	local winFrame = win:frame()
	local screenFrame = win:screen():frame()
	winFrame.y = screenFrame.y + snapMarginY
	win:setFrame(winFrame)
end)
hs.hotkey.bind(snapWinMod, "Down", function()
	local win = hs.window.focusedWindow()
	local winFrame = win:frame()
	local screenFrame = win:screen():frame()
	winFrame.y = screenFrame.h - winFrame.h - snapMarginY
	win:setFrame(winFrame)
end)

-- ------------------------------------
-- Resize window
-- ------------------------------------

local resizeWinMod = { "ctrl", "alt" }
hs.hotkey.bind(resizeWinMod, "D", function()
	local win = hs.window.focusedWindow()
	if not win then
		return
	end

	-- Prompt user for dimensions in "WIDTHxHEIGHT" format (e.g., 1920x1080)
	local button, input = hs.dialog.textPrompt("Resize Window", "Enter dimensions (WxH):", "1750x1250", "OK", "Cancel")

	if button == "OK" then
		local w, h = input:match("(%d+)x(%d+)")
		if w and h then
			-- Apply the new size while keeping the top-left corner fixed
			win:setSize({ w = tonumber(w), h = tonumber(h) })
			win:focus()
		else
			hs.alert.show("Invalid format. Use <width>x<height> (e.g. 800x600)")
		end
	end
end)
