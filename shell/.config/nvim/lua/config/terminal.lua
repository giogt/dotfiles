-- [[ Terminal config ]]

-- Easier keymap to exit the builtin terminal, instead of using <C-\><C-n>.
--  It might not work in some terminal emulators / tmux / etc.
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
