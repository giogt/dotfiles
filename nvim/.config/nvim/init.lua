-- Disable netrw (built-in file explorer)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Set <space> as the leader key
--  Needs to be done before loading plugins
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- enable 24-bit colour
vim.opt.termguicolors = true

if vim.g.vscode then
	-- VS Code extension is enabled
	--  Load a minimal set of config
	require("config.motions")
else
	-- VS Code extension is not enabled
	--  This is the main Neovim config

	if vim.g.neovide then
		-- Load Neovide-specific modules
		require("config.neovide")
	else
		-- Load Neovim-specific modules
	end

	-- The remaining modules are loaded for both Neovim and Neovide

	-- load theme configuration first, so that modules/plugins can read it
	require("config.theme")
	require("config.clipboard")
	require("config.commands")
	require("config.diagnostics")
	require("config.motions")
	require("config.options")
	require("config.search")
	require("config.terminal")
	require("config.windows")
	-- load Lazy plugin manager last
	require("config.lazy")
end
