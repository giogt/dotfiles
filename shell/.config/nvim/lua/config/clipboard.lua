-- [[ Clipboard config ]]

-- Sync clipboard between OS and Neovim
--  Schedule the setting after `UiEnter`, otherwise it can increase startup-time
vim.schedule(function()
	vim.o.clipboard = "unnamedplus"
end)

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Custom actions to be executed when yanking (copying) text",
	group = vim.api.nvim_create_augroup("giogt-yank-post-actions", { clear = true }),
	callback = function()
		-- Highlight when yanking (copying) text
		--  Try it with `yap` in normal mode
		--  See `:help vim.hl.on_yank()`
		vim.hl.on_yank()
	end,
})
