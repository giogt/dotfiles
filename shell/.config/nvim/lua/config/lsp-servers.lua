--  Add/remove any required LSP here. They will automatically be installed.
--  See `:help lsp-config` for information about keys and how to configure
--
--  NOTE: for some languages, consider using a specific plugin instead of
--  adding a LSP here. For example:
--  - https://github.com/mrcjkb/rustaceanvim instead of the `rust_analyzer` LSP
--  - https://github.com/pmizio/typescript-tools.nvim instead of the `ts_ls` LSP

local M = {}

local _servers = {
	gopls = {},
	lua_ls = {
		-- Special Lua Config, as recommended by neovim help docs
		on_init = function(client)
			-- Disable formatting (formatting is done by stylua)
			client.server_capabilities.documentFormattingProvider = false

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
			Lua = {
				format = { enable = false }, -- Disable formatting (formatting is done by stylua)
			},
		},
	},
}

M.servers = _servers

return M
