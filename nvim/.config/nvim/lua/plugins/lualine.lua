return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("lualine").setup({
			options = {
				icons_enabled = true,
				theme = "tokyonight-night",
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				disabled_filetypes = {
					statusline = {},
					winbar = {},
				},
				ignore_focus = {},
				always_divide_middle = true,
				always_show_tabline = true,
				globalstatus = false,
				-- refresh = {
				-- 	statusline = 1000,
				-- 	tabline = 1000,
				-- 	winbar = 1000,
				-- 	refresh_time = 16, -- ~60fps
				-- 	events = {
				-- 		"WinEnter",
				-- 		"BufEnter",
				-- 		"BufWritePost",
				-- 		"SessionLoadPost",
				-- 		"FileChangedShellPost",
				-- 		"VimResized",
				-- 		"Filetype",
				-- 		"CursorMoved",
				-- 		"CursorMovedI",
				-- 		"ModeChanged",
				-- 	},
				-- },
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff", "diagnostics" },
				lualine_c = {
					{
						"filename",
						file_status = true, -- Displays file status (readonly, modified)
						newfile_status = false, -- True displays status for newly created file

						-- 0: Just filename
						-- 1: Relative path
						-- 2: Absolute path
						-- 3: Absolute path, with tilde as the home directory
						-- 4: Filename and parent dir, with tilde as the home directory
						path = 1,

						-- Shortens path to leave 40 spaces in the window
						-- for other components. (Caution: setting this
						-- too high may cause the path to disappear on
						-- small screens)
						shorting_target = 40,

						symbols = {
							modified = "[+]", -- Text to show when the file is modified
							readonly = "[-]", -- Text to show when the file is non-modifiable or readonly
							unnamed = "[No Name]", -- Text to show for unnamed buffers
							newfile = "[New]", -- Text to show for nealy created file before first write
						},
					},
				},
				lualine_x = { "encoding", "fileformat", "filetype" },
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},
			tabline = {},
			winbar = {},
			inactive_winbar = {},
			extensions = {},
		})
	end,
}
