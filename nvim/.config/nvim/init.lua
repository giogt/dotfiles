-- Set <space> as the leader key
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

if vim.g.vscode then
	-- VS Code extension is enabled => load VS Code config
	require("config.vscode")
else
	-- Load nvim config
	require("config.options")
	require("config.keymaps")
	require("config.autocommands")
	require("config.lazy")
end
