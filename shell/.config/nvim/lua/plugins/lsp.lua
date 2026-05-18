-- [[ LSP Plugins ]]

local servers = require("config.lsp-servers").servers
return { -- LSP Plugins
	-- Main LSP Configuration
	"neovim/nvim-lspconfig",
	dependencies = {
		-- Note: `opts = {}` is the same as calling `require('mason').setup({})`
		-- { "mason-org/mason.nvim", opts = {} },
		-- { "mason-org/mason-lspconfig.nvim", opts = {} },
		-- "WhoIsSethDaniel/mason-tool-installer.nvim",

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
					map("<leader>ih", function()
						vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
					end, "Inlay hints")
				end
			end,
		})

		-- Neovim doesn't support all LSP capabilities out of the box.
		-- Plugins such as blink.cmp support additional capabilities. When using this kind of
		-- plugins, the additional capabilities need to be broadcasted to the LSP server.

		local capabilities = require("blink.cmp").get_lsp_capabilities()

		for name, server in pairs(servers) do
			server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
			vim.lsp.config(name, server)
			vim.lsp.enable(name)
		end
	end,
}
