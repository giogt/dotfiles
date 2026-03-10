return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	lazy = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("nvim-tree").setup({
			git = {
				enable = true,
				ignore = false,
			},
			view = {
				width = 35,
			},
		})
	end,
	keys = {
		{ "<leader>e", ":NvimTreeToggle<CR>", desc = "Toggle NvimTree" },
		{ "<leader>tf", ":NvimTreeFindFile<CR>", desc = "Reveal File in NvimTree" },
		{ "<leader>tt", ":NvimTreeToggle<CR>", desc = "Toggle NvimTree" },
	},
}
