-- [[ Colorscheme plugins ]]

-- To see the list of installed colorschemes, use `:Telescope colorscheme`.

return {

	-- Tokionight
	-- "folke/tokyonight.nvim",
	-- priority = 1000, -- Load before all other start plugins
	-- config = function()
	-- 	---@diagnostic disable-next-line: missing-fields
	-- 	require("tokyonight").setup({
	-- 		styles = {
	-- 			comments = { italic = false }, -- Disable italics in comments
	-- 		},
	-- 	})
	-- 	vim.cmd.colorscheme("tokyonight-night")
	-- end,

	-- Nightfox
	"EdenEast/nightfox.nvim",
	priority = 1000, -- Load before all other start plugins
	config = function()
		--  dark: duskfox
		--  light: dayfox
		vim.cmd.colorscheme("duskfox")
	end,
}
