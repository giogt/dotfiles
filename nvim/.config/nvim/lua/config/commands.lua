-- [[ User commands ]]

vim.api.nvim_create_user_command("CopyPath", function()
	local path = vim.fn.expand("%:p")
	vim.fn.setreg("+", path)
	vim.notify('Copied "' .. path .. '" to the clipboard')
end, {})

vim.api.nvim_create_user_command("CopyRelPath", function()
	local path = vim.fn.expand("%:.")
	vim.fn.setreg("+", path)
	vim.notify('Copied "' .. path .. '" to the clipboard')
end, {})

vim.api.nvim_create_user_command("ReplaceCtrlJ", "%s/\\%x1b\\[106;5u/\\r/g", {})
vim.keymap.set("n", "<leader>rj", "<cmd>ReplaceCtrlJ<CR>", { desc = "Replace C-j with new lines" })
