-- [[ Colorscheme plugin ]]

-- Load the colorscheme plugin for the current selected theme
local theme = require("config.theme").current_theme
return theme.lazy_spec
