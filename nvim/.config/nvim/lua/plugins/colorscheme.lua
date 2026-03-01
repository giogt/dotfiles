-- [[ Colorscheme plugins ]]

-- To see the list of installed colorschemes and switch between them, use `:Telescope colorscheme`.

local Theme = {
	CATPPUCCIN = 1,
	KANAGAWA = 2,
	NIGHTFOX = 3,
	TOKYONIGHT = 4,
}

-- Pick a default theme here
--   The other themes won't be loaded, improving startup time.
local _default_colorscheme = Theme.NIGHTFOX

-- NOTE: Most themes plugins have multiple schemes available.
--  You can pick a different variant in the plugin definitions below.

return {

	-- Catppuccin
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		cond = function()
			return _default_colorscheme == Theme.CATPPUCCIN
		end,
		config = function()
			-- Available schemes:
			--   catppuccin, catppuccin-latte, catppuccin-frappe,
			--   catppuccin-macchiato, catppuccin-mocha
			vim.cmd.colorscheme("catppuccin-mocha")
		end,
	},

	-- Kanagawa
	{
		"rebelot/kanagawa.nvim",
		priority = 1000,
		cond = function()
			return _default_colorscheme == Theme.KANAGAWA
		end,
		config = function()
			-- Available schemes:
			--   dark: kanagawa-wave, kanagawa-dragon,
			--   light: kanagawa-lotus
			vim.cmd.colorscheme("kanagawa-wave")
		end,
	},

	-- Nightfox
	{
		"EdenEast/nightfox.nvim",
		priority = 1000,
		cond = function()
			return _default_colorscheme == Theme.NIGHTFOX
		end,
		config = function()
			--  My favourite nightfox schemes
			--   dark: duskfox
			--   light: dayfox
			vim.cmd.colorscheme("duskfox")
		end,
	},

	-- Tokionight
	{
		"folke/tokyonight.nvim",
		priority = 1000,
		cond = function()
			return _default_colorscheme == Theme.TOKYONIGHT
		end,
		config = function()
			-- ---@diagnostic disable-next-line: missing-fields
			-- require("tokyonight").setup({
			-- 	styles = {
			-- 		comments = { italic = false }, -- Disable italics in comments
			-- 	},
			-- })
			-- Available schemes:
			--   tokyonight, tokyonight-night, tokyonight-storm, tokyonight-day, tokyonight-moon
			vim.cmd.colorscheme("tokyonight-moon")
		end,
	},
}
