return { -- Useful plugin to show you pending keybinds.
	"folke/which-key.nvim",
	-- Load the plugin before all the UI elements are loaded
	--  For a list of all available events, see :help autocmd-events
	event = "VimEnter",
	opts = {
		-- delay between pressing a key and opening which-key (milliseconds)
		delay = 0,
		icons = { mappings = vim.g.have_nerd_font },

		-- Document existing key chains
		spec = {
			{ "<leader>s", group = "[S]earch", mode = { "n", "v" } },
			{ "<leader>t", group = "[T]oggle" },
			{ "<leader>h", group = "Git [H]unk", mode = { "n", "v" } },
		},
	},
}
