vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = false

vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4

-- ======
-- Keymap
-- ======

vim.g.mapleader = ' '

vim.keymap.set('n', '<leader>n', '<cmd>enew<cr>')
vim.keymap.set('n', '<leader>q', '<cmd>q<cr>')
vim.keymap.set('n', '<leader>s', '<cmd>w<cr>')

vim.keymap.set({'n', 'o', 'v'}, 'H', '^', { remap=false })
vim.keymap.set({'n', 'o', 'v'}, 'L', '$', { remap=false })

vim.keymap.set('n', 'tk', '<cmd>blast<cr>', { remap=true })
vim.keymap.set('n', 'tj', '<cmd>bfirst<cr>', { remap=true })
vim.keymap.set('n', 'th', '<cmd>bprev<cr>', { remap=true })
vim.keymap.set('n', 'tl', '<cmd>bnext<cr>', { remap=true })
vim.keymap.set('n', 'td', '<cmd>bdelete<cr>', { remap=true })
vim.keymap.set('n', '<leader>w', '<cmd>bdelete<cr>', { remap=true })

vim.keymap.set({ 'n', 'v'}, '<leader>fd', '<cmd>Yazi toggle<cr>')

-- ====================
-- Plugin customization
-- ====================

-- Lualine
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    always_show_tabline = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
      refresh_time = 16, -- ~60fps
      events = {
        'WinEnter',
        'BufEnter',
        'BufWritePost',
        'SessionLoadPost',
        'FileChangedShellPost',
        'VimResized',
        'Filetype',
        'CursorMoved',
        'CursorMovedI',
        'ModeChanged',
      },
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'buffers'},
    lualine_w = {'encoding', 'fileformat', 'filetype'},
    lualine_x = {'lsp_status'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}

-- Telescope
local telescope_builtin = require('telescope.builtin')
local find_files = function() telescope_builtin.find_files({ hidden = true, no_ignore = false, follow = true }) end

vim.keymap.set('n', '<leader>ff', find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', telescope_builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', telescope_builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', telescope_builtin.help_tags, { desc = 'Telescope help tags' })

-- ==========
-- Completion
-- ==========

local capabilities = require('cmp_nvim_lsp').default_capabilities()
local cmp = require('cmp')
cmp.setup({
  -- enable automatic completion as you type
  completion = {
    completeopt = 'menu,menuone,noinsert',
    event = 'InsertEnter',
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
    { name = 'buffer' },
    { name = 'path' },
  }),
  mapping = cmp.mapping.preset.insert({
    ['<C-Space>'] = cmp.mapping.complete(), -- Trigger completion
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept completion
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
  }),
})
