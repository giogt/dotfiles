---@type LazySpec
return {
  "mikavilpas/yazi.nvim",
  version = "*", -- use the latest stable version
  event = "VeryLazy",
  dependencies = {
    { "nvim-lua/plenary.nvim", lazy = true },
  },
  ---@type YaziConfig | {}
  opts = {
    -- open yazi instead of netrw
    open_for_directories = false,
    keymaps = {
      show_help = "<f1>",
    },
  },
  -- prevent netrw (nvim default file mnager) from loading
  -- More details: https://github.com/mikavilpas/yazi.nvim/issues/802
  init = function()
    vim.g.loaded_netrwPlugin = 1
  end,
}
