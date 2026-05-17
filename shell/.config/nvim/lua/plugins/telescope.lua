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
			defaults = {
				-- Show hidden files in Live Grep dialogs
				--
				--  You need to include all the default options that are expected by the dialog,
				--  otherwise it won't work properly.
				--
				--  See: https://github.com/nvim-telescope/telescope.nvim/blob/5255aa27c422de944791318024167ad5d40aad20/lua/telescope/config.lua#L707
				vimgrep_arguments = {
					"rg",
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
					"--smart-case",
					"--hidden", -- Include hidden files
					"--follow", -- Follow symlinks
				},

				-- Available options: shorten, smart, tail, truncate
				path_display = { "smart" },
			},
			pickers = {
				-- Show hidden files in the Find Files dialog
				find_files = {
					hidden = true,
					no_ignore = true,
					follow = true,
				},
			},
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

		vim.keymap.set("n", "<leader>f", builtin.find_files, { desc = "Open file" })
		vim.keymap.set("n", "<leader>of", builtin.find_files, { desc = "Open file" })
		vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "Open buffer" })
		vim.keymap.set("n", "<leader>bo", builtin.buffers, { desc = "Open buffer" })
		vim.keymap.set("n", "<leader>ob", builtin.buffers, { desc = "Open buffer" })
		vim.keymap.set("n", "<leader>on", function()
			builtin.find_files({ cwd = vim.fn.stdpath("config") })
		end, { desc = "Open nvim config file" })

		-- Search

		vim.keymap.set("n", "<leader>/<leader>", function()
			builtin.live_grep({
				grep_open_files = true,
				prompt_title = "Search buffers (grep)",
			})
		end, { desc = "Search buffers (grep)" })

		vim.keymap.set("n", "<leader>/f", function()
			builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
				winblend = 10,
				previewer = false,
				prompt_title = "Search file (fuzzy)",
			}))
		end, { desc = "Search file (fuzzy)" })

		vim.keymap.set("n", "<leader>/F", function()
			builtin.live_grep({ prompt_title = "Search all files (grep)" })
		end, { desc = "Search all files (grep)" })

		vim.keymap.set("n", "<leader>/o", builtin.oldfiles, { desc = "Search old files" })
		vim.keymap.set({ "n", "v" }, "<leader>/w", builtin.grep_string, { desc = "Search current word" })
		vim.keymap.set("n", "<leader>//", builtin.resume, { desc = "Reopen last search dialog" })

		-- Diagnostics

		vim.keymap.set("n", "<leader>ds", builtin.diagnostics, { desc = "Search diagnostics" })

		-- Neovim

		vim.keymap.set("n", "<leader>nc", builtin.commands, { desc = "Nvim commands" })
		vim.keymap.set("n", "<leader>nh", builtin.help_tags, { desc = "Nvim help" })
		vim.keymap.set("n", "<leader>nk", builtin.keymaps, { desc = "Nvim keymaps" })
		vim.keymap.set("n", "<leader>no", function()
			builtin.find_files({ cwd = vim.fn.stdpath("config") })
		end, { desc = "Nvim config files" })
		vim.keymap.set("n", "<leader>nt", builtin.builtin, { desc = "Nvim Telescope commands" })

		-- This runs on LSP attach per buffer (see main LSP attach function in 'neovim/nvim-lspconfig' config for more info,
		-- it is better explained there). This allows easily switching between pickers if you prefer using something else!
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("telescope-lsp-attach", { clear = true }),
			callback = function(event)
				local buf = event.buf

				vim.keymap.set("n", "grr", builtin.lsp_references, { buffer = buf, desc = "Goto references" })
				vim.keymap.set("n", "gri", builtin.lsp_implementations, { buffer = buf, desc = "Goto implementation" })
				vim.keymap.set("n", "grd", builtin.lsp_definitions, { buffer = buf, desc = "Goto definition" })
				vim.keymap.set("n", "gd", builtin.lsp_definitions, { buffer = buf, desc = "Goto definition" })

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
