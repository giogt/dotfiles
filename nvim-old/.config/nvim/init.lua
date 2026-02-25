if vim.g.vscode then
  -- VSCode extension is enabled
  require('config.vscode')
else
  require('config.lazy') -- lazy package manager
  require('config.giogt') -- my config
  require('config.colorscheme')
end
