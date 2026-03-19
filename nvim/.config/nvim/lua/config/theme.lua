-- [[ Theme module ]]

-- Set the theme you want to use at the bottom of this file

local M = {}

local _themes = {
	catppuccin = {
		name = "catppuccin",
		lazy_spec = {
			"catppuccin/nvim",
			name = "catppuccin",
			lazy = false,
			priority = 1000,
			config = function()
				-- Available schemes:
				--   catppuccin, catppuccin-latte, catppuccin-frappe,
				--   catppuccin-macchiato, catppuccin-mocha
				vim.cmd.colorscheme("catppuccin-mocha")
			end,
		},
	},
	gruvbox_material = {
		name = "gruvbox-material",
		lazy_spec = {
			"sainnhe/gruvbox-material",
			lazy = false,
			priority = 1000,
			config = function()
				-- Optionally configure and load the colorscheme
				-- directly inside the plugin declaration.
				vim.g.gruvbox_material_enable_italic = true
				vim.cmd.colorscheme("gruvbox-material")
			end,
		},
	},
	nightfox = {
		name = "nightfox",
		lazy_spec = {
			"EdenEast/nightfox.nvim",
			lazy = false,
			priority = 1000,
			config = function()
				--  My favourite nightfox schemes
				--   dark: duskfox
				--   light: dayfox
				vim.cmd.colorscheme("duskfox")
			end,
		},
	},
	kanagawa = {
		name = "kanagawa",
		lazy_spec = {
			"rebelot/kanagawa.nvim",
			lazy = false,
			priority = 1000,
			config = function()
				-- Available schemes:
				--   dark: kanagawa-wave, kanagawa-dragon,
				--   light: kanagawa-lotus
				vim.cmd.colorscheme("kanagawa-wave")
			end,
		},
	},
	rose_pine = {
		name = "rose-pine",
		lazy_spec = {
			"rose-pine/neovim",
			name = "rose-pine",
			lazy = false,
			priority = 1000,
			config = function()
				require("rose-pine").setup({
					variant = "main", -- auto, main, moon, or dawn
				})
				vim.cmd.colorscheme("rose-pine")
			end,
		},
	},
	tokyonight = {
		name = "tokyonight",
		lazy_spec = {
			"folke/tokyonight.nvim",
			lazy = false,
			priority = 1000,
			opts = {
				style = "moon", -- moon, storm night, day
				styles = {
					comments = { italic = false },
					keywords = { italic = false, bold = true },
					-- Background styles. Can be "dark", "transparent" or "normal"
					sidebars = "dark",
					floats = "dark",
				},
				dim_inactive = true,
				lualine_bold = true,
			},
			config = function(_, opts)
				require("tokyonight").setup(opts)

				-- Available schemes:
				--   tokyonight, tokyonight-night, tokyonight-storm, tokyonight-day, tokyonight-moon
				--
				-- NOTE: keep `tokyonight` here, and change the style in the `opts` above
				vim.cmd.colorscheme("tokyonight")
			end,
		},
	},
}

-- Ensure nvim background is set to "dark"
--  Some colorschemes check this
vim.o.background = "dark"

M.current_theme = _themes.tokyonight

return M
