-- This file contains the default configuration
--
-- To customize it, please create a config-override.lua file.

local _config = {
	apps = {
		["com.apple.MobileSMS"] = {
			name = "Messages",
			dimensions = { w = 1392, h = 1080 },
		},
		["com.brave.Browser"] = {
			name = "Brave Browser",
			dimensions = { w = 1800, h = 1200 },
			offset = { x = 0, y = 0 },
		},
		["com.google.Chrome"] = {
			name = "Google Chrome",
			dimensions = { w = 1800, h = 1200 },
			offset = { x = 0, y = 0 },
		},
		["com.mitchellh.ghostty"] = {
			name = "Ghostty",
			dimensions = { w = 1392, h = 1080 },
		},
		["com.neovide.neovide"] = {
			name = "Neovide",
			dimensions = { w = 1600, h = 1150 },
		},
		["com.vscodium"] = {
			name = "VSCodium",
			dimensions = { w = 1600, h = 1150 },
		},
		["dev.zed.Zed"] = {
			name = "Zed",
			dimensions = { w = 1600, h = 1150 },
		},
		["us.zoom.xos"] = {
			name = "zoom.us",
			dimensions = { w = 2000, h = 1250 },
		},

		-- Proton PWAs
		["com.brave.Browser.app.jnpecgipniidlgicjocehkhajgdnjekh"] = {
			name = "Proton Mail",
			dimensions = { w = 1600, h = 1150 },
		},
		["com.brave.Browser.app.ojibjkjikcpjonjjngfkegflhmffeemk"] = {
			name = "Proton Calendar",
			dimensions = { w = 1600, h = 1150 },
		},

		-- Google PWAs
		["com.google.Chrome.app.fmgjjmmmlfnkbppncabfkddbjimcfncm"] = {
			name = "Gmail",
			dimensions = { w = 1800, h = 1200 },
		},
		["com.google.Chrome.app.kjbdgfilnfhdoflbpgamdcdgpehopbep"] = {
			name = "Google Calendar",
			dimensions = { w = 1800, h = 1200 },
		},
		["com.google.Chrome.app.pommaclcbfghclhalboakcipcmmndhcj"] = {
			name = "Google Chat",
			dimensions = { w = 1392, h = 1080 },
		},
	},
	key_bindings = {
		switch_app = {
			mod = { "alt" },
			keys = {
				J = "com.mitchellh.ghostty",
				K = "com.brave.Browser",
				L = "com.apple.MobileSMS",
				U = "com.brave.Browser.app.jnpecgipniidlgicjocehkhajgdnjekh", -- Proton Mail
				I = "com.brave.Browser.app.ojibjkjikcpjonjjngfkegflhmffeemk", -- Proton Calendar
			},
		},
	},
}

return _config
