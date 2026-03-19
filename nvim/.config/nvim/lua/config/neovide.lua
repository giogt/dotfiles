-- Enable the "logo" (CMD) key on macOS
vim.g.neovide_input_use_logo = true

-- Map CMD+V to paste in normal, insert, visual, and command modes
vim.keymap.set("n", "<D-v>", function()
	vim.api.nvim_paste(vim.fn.getreg("+"), true, -1)
end, { desc = "Paste from system clipboard" })

vim.keymap.set("i", "<D-v>", "<C-R>+", { desc = "Paste in insert mode" })
vim.keymap.set("v", "<D-v>", "<C-R>+", { desc = "Paste in visual mode" })
vim.keymap.set("c", "<D-v>", "<C-R>+", { desc = "Paste in command mode" })

-- Disable animations
vim.g.neovide_cursor_animation_length = 0
vim.g.neovide_cursor_animate_in_insert_mode = false
vim.g.neovide_cursor_animate_command_line = false
vim.g.neovide_cursor_short_animation_length = 0
vim.g.neovide_cursor_trail_size = 0
vim.g.neovide_position_animation_length = 0
vim.g.neovide_scroll_animation_far_lines = 0
vim.g.neovide_scroll_animation_length = 0
