-- [[ Colorscheme plugins ]]

-- To see the list of installed colorschemes and switch between them, use `:Telescope colorscheme`.

local Theme = {
	CATPPUCCIN = 1,
	GRUVBOX = 2,
	KANAGAWA = 3,
	NIGHTFOX = 4,
	ROSEPINE = 5,
	TOKYONIGHT = 6,
}

-- Pick a default theme here
--   The other themes won't be loaded, improving startup time.
local _default_colorscheme = Theme.TOKYONIGHT

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

	-- Gruvbox Material
	{
		"sainnhe/gruvbox-material",
		lazy = false,
		priority = 1000,
		cond = function()
			return _default_colorscheme == Theme.GRUVBOX
		end,
		config = function()
			-- Optionally configure and load the colorscheme
			-- directly inside the plugin declaration.
			vim.g.gruvbox_material_enable_italic = true
			vim.cmd.colorscheme("gruvbox-material")
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

	-- Rosé Pine
	{
		"rose-pine/neovim",
		name = "rose-pine",
		cond = function()
			return _default_colorscheme == Theme.ROSEPINE
		end,
		config = function()
			require("rose-pine").setup({
				variant = "main", -- auto, main, moon, or dawn
			})
			vim.cmd.colorscheme("rose-pine")
		end,
	},

	-- Tokyonight
	{
		"folke/tokyonight.nvim",
		priority = 1000,
		cond = function()
			return _default_colorscheme == Theme.TOKYONIGHT
		end,
		config = function()
			-- Uncomment below to disable italic font for comments
			-- ---@diagnostic disable-next-line: missing-fields
			-- require("tokyonight").setup({
			-- 	styles = {
			-- 		comments = { italic = false },
			-- 	},
			-- })

			-- Available schemes:
			--   tokyonight, tokyonight-night, tokyonight-storm, tokyonight-day, tokyonight-moon
			vim.cmd.colorscheme("tokyonight-night")
		end,
	},
}
