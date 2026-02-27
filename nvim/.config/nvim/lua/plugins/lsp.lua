-- [[ LSP Plugins ]]

return { -- LSP Plugins
	-- Main LSP Configuration
	"neovim/nvim-lspconfig",
	dependencies = {
		-- Note: `opts = {}` is the same as calling `require('mason').setup({})`
		{ "mason-org/mason.nvim", opts = {} },
		{ "mason-org/mason-lspconfig.nvim", opts = {} },
		"WhoIsSethDaniel/mason-tool-installer.nvim",

		-- Status updates for LSP.
		{ "j-hui/fidget.nvim", opts = {} },

		-- Allows extra capabilities provided by blink.cmp
		"saghen/blink.cmp",
	},
	config = function()
		--  This function runs each time a LSP attaches to a buffer
		--   (e.g., when opening `main.rs`, which is associated with `rust_analyzer`)
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
			callback = function(event)
				local map = function(keys, func, desc, mode)
					mode = mode or "n"
					vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
				end

				map("grn", vim.lsp.buf.rename, "Rename")
				map("gra", vim.lsp.buf.code_action, "Code action", { "n", "x" })

				-- Goto declaration (e.g., header file in C)
				--  Not to be confused with Goto definition
				map("grD", vim.lsp.buf.declaration, "Goto declaration")

				-- Highlight references of the word under the cursor after a little while.
				-- Moving the cursor will clear the highlight.
				--    See `:help CursorHold` for details
				local client = vim.lsp.get_client_by_id(event.data.client_id)
				if client and client:supports_method("textDocument/documentHighlight", event.buf) then
					local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
					vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
						buffer = event.buf,
						group = highlight_augroup,
						callback = vim.lsp.buf.document_highlight,
					})

					vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
						buffer = event.buf,
						group = highlight_augroup,
						callback = vim.lsp.buf.clear_references,
					})

					vim.api.nvim_create_autocmd("LspDetach", {
						group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
						callback = function(event2)
							vim.lsp.buf.clear_references()
							vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
						end,
					})
				end

				if client and client:supports_method("textDocument/inlayHint", event.buf) then
					map("<leader>th", function()
						vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
					end, "Toggle inlay hints")
				end
			end,
		})

		-- Neovim doesn't support all LSP capabilities out of the box.
		-- Plugins such as blink.cmp support additional capabilities. When using this kind of
		-- plugins, the additional capabilities need to be broadcasted to the LSP server.

		local capabilities = require("blink.cmp").get_lsp_capabilities()

		--  Add/remove any required LSP here. They will automatically be installed.
		--  See `:help lsp-config` for information about keys and how to configure
		--
		--  NOTE: for some languages, consider using a specific plugin instead of adding a
		--  LSP here. For example:
		--  - https://github.com/mrcjkb/rustaceanvim instead of the `rust_analyzer` LSP
		--  - https://github.com/pmizio/typescript-tools.nvim instead of the `ts_ls` LSP
		--
		local servers = {
			-- clangd = {},
			-- gopls = {},
			-- pyright = {},
			-- rust_analyzer = {},
		}

		-- List of tools to install with Mason at startup, if they are not installed yet.
		-- You can add other tools to the list, and/or install additional tools with :Mason
		local ensure_installed = vim.tbl_keys(servers or {})
		vim.list_extend(ensure_installed, {
			"lua_ls", -- Lua Language server
			"stylua", -- Used to format Lua code
		})

		require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

		for name, server in pairs(servers) do
			server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
			vim.lsp.config(name, server)
			vim.lsp.enable(name)
		end

		-- Special Lua Config, as recommended by neovim help docs
		vim.lsp.config("lua_ls", {
			on_init = function(client)
				if client.workspace_folders then
					local path = client.workspace_folders[1].name
					if
						path ~= vim.fn.stdpath("config")
						and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
					then
						return
					end
				end

				client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
					runtime = {
						version = "LuaJIT",
						path = { "lua/?.lua", "lua/?/init.lua" },
					},
					workspace = {
						checkThirdParty = false,
						-- NOTE: this is a lot slower and will cause issues when working on your own configuration.
						--  See https://github.com/neovim/nvim-lspconfig/issues/3189
						library = vim.api.nvim_get_runtime_file("", true),
					},
				})
			end,
			settings = {
				Lua = {},
			},
		})
		vim.lsp.enable("lua_ls")
	end,
}
