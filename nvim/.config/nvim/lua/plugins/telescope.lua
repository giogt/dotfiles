-- [[ Telescope ]]
-- Fuzzy Finder (files, lsp, etc)

-- Usage:
--  :Telescope <command>
--
--  Or use the keymaps defined below.

return {
	"nvim-telescope/telescope.nvim",
	enabled = true,
	event = "VimEnter",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",

			-- `build` is used to run some command when the plugin is installed/updated.
			build = "make",

			-- `cond` determines whether this plugin should be installed and loaded
			cond = function()
				return vim.fn.executable("make") == 1
			end,
		},
		{ "nvim-telescope/telescope-ui-select.nvim" },
		{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
	},
	config = function()
		require("telescope").setup({
			-- defaults = {
			--   mappings = {
			--     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
			--   },
			-- },
			-- pickers = {}
			extensions = {
				["ui-select"] = { require("telescope.themes").get_dropdown() },
			},
		})

		-- Enable Telescope extensions if they are installed
		pcall(require("telescope").load_extension, "fzf")
		pcall(require("telescope").load_extension, "ui-select")

		local builtin = require("telescope.builtin")

		-- [[ Keymaps ]]

		-- Open

		-- open file both with `<leader><leader>`, and with `<leader>of`
		vim.keymap.set("n", "<leader><leader>", function()
			builtin.find_files({ hidden = true, no_ignore = false, follow = true })
		end, { desc = "Open file" })
		vim.keymap.set("n", "<leader>of", function()
			builtin.find_files({ hidden = true, no_ignore = false, follow = true })
		end, { desc = "Open file" })

		vim.keymap.set("n", "<leader>ob", builtin.buffers, { desc = "Open buffer" })

		-- Search

		vim.keymap.set("n", "<leader>/b", function()
			builtin.live_grep({
				grep_open_files = true,
				prompt_title = "Live grep in buffers",
			})
		end, { desc = "Search in buffers" })
		vim.keymap.set("n", "<leader>//", function()
			builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
				winblend = 10,
				previewer = false,
			}))
		end, { desc = "Search in current file [/]" })

		vim.keymap.set("n", "<leader>/f", builtin.live_grep, { desc = "Search in files" })
		vim.keymap.set("n", "<leader>/r", builtin.oldfiles, { desc = "Search recent files" })
		vim.keymap.set({ "n", "v" }, "<leader>/w", builtin.grep_string, { desc = "Search current word" })
		vim.keymap.set("n", "<leader>/d", builtin.resume, { desc = "Search dialog (resume last)" })

		-- Diagnostics

		vim.keymap.set("n", "<leader>ds", builtin.diagnostics, { desc = "Search diagnostics" })

		-- Neovim

		vim.keymap.set("n", "<leader>nc", builtin.commands, { desc = "Search nvim commands" })
		vim.keymap.set("n", "<leader>nh", builtin.help_tags, { desc = "Search nvim help" })
		vim.keymap.set("n", "<leader>nk", builtin.keymaps, { desc = "Search nvim keymaps" })
		vim.keymap.set("n", "<leader>no", function()
			builtin.find_files({ cwd = vim.fn.stdpath("config") })
		end, { desc = "Open nvim config file" })
		vim.keymap.set("n", "<leader>nt", builtin.builtin, { desc = "Search telescope commands" })

		-- This runs on LSP attach per buffer (see main LSP attach function in 'neovim/nvim-lspconfig' config for more info,
		-- it is better explained there). This allows easily switching between pickers if you prefer using something else!
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("telescope-lsp-attach", { clear = true }),
			callback = function(event)
				local buf = event.buf

				vim.keymap.set("n", "grr", builtin.lsp_references, { buffer = buf, desc = "Goto references" })
				vim.keymap.set("n", "gri", builtin.lsp_implementations, { buffer = buf, desc = "Goto implementation" })
				vim.keymap.set("n", "grd", builtin.lsp_definitions, { buffer = buf, desc = "Goto definition" })

				-- Fuzzy find symbols (e.g., variables, functions, types, etc.)
				vim.keymap.set("n", "<leader>os", builtin.lsp_document_symbols, { buffer = buf, desc = "Open symbols" })
				vim.keymap.set(
					"n",
					"<leader>oS",
					builtin.lsp_dynamic_workspace_symbols,
					{ buffer = buf, desc = "Open workspace symbols" }
				)

				-- Type
				vim.keymap.set(
					"n",
					"grt",
					builtin.lsp_type_definitions,
					{ buffer = buf, desc = "Goto type definition" }
				)
			end,
		})
	end,
}
