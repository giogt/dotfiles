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
	require("config.keymaps")
	require("config.vscode")
else
	-- VS Code extension is not enabled
	require("config.options")
	require("config.keymaps")
	require("config.autocommands")
	require("config.lazy")
end
