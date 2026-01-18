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

local snapWinMod = { "ctrl", "alt", "cmd" }
local snapMarginX = 5
local snapMarginY = 5

hs.hotkey.bind(snapWinMod, "J", function()
	local win = hs.window.focusedWindow()
	local winFrame = win:frame()
	local screenFrame = win:screen():frame()
	winFrame.y = screenFrame.h - winFrame.h - snapMarginY
	win:setFrame(winFrame)
end)
hs.hotkey.bind(snapWinMod, "K", function()
	local win = hs.window.focusedWindow()
	local winFrame = win:frame()
	local screenFrame = win:screen():frame()
	winFrame.y = screenFrame.y + snapMarginY
	win:setFrame(winFrame)
end)
hs.hotkey.bind(snapWinMod, "H", function()
	local win = hs.window.focusedWindow()
	local winFrame = win:frame()
	local screenFrame = win:screen():frame()
	winFrame.x = screenFrame.x + snapMarginX
	win:setFrame(winFrame)
end)
hs.hotkey.bind(snapWinMod, "L", function()
	local win = hs.window.focusedWindow()
	local winFrame = win:frame()
	local screenFrame = win:screen():frame()
	winFrame.x = screenFrame.w - winFrame.w - snapMarginX
	win:setFrame(winFrame)
end)

hs.hotkey.bind(snapWinMod, ",", function()
	hs.window.focusedWindow():centerOnScreen()
end)
