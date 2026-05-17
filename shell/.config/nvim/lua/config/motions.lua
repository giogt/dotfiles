-- [[ Motions config ]]

-- Remap H and L to beginning and end of line for normal, visual and operator-pending modes
vim.keymap.set("n", "H", "^", { noremap = true })
vim.keymap.set("n", "L", "$", { noremap = true })
vim.keymap.set("v", "H", "^", { noremap = true })
vim.keymap.set("v", "L", "$", { noremap = true })
vim.keymap.set("o", "H", "^", { noremap = true })
vim.keymap.set("o", "L", "$", { noremap = true })

-- Preserve original H and L functionality with gh and gl
vim.keymap.set("n", "gh", "H", { noremap = true })
vim.keymap.set("n", "gl", "L", { noremap = true })
