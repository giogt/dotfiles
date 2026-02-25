return {
  'nvim-telescope/telescope.nvim', tag = 'v0.2.1',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  -- prevent netrw (nvim default file mnager) from loading
  init = function()
    vim.g.loaded_netrwPlugin = 1
  end,
  lazy = true,
}
