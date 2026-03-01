-- [[ Rust plugins ]]

-- NOTE: this plugin is meant to work with rust-analyzer installed globally via cargo.
--  See: https://rust-analyzer.github.io/book/installation.html
--  If you installed rust-analyzer via Mason, please uninstall it to avoid conflicts.

return {
	"mrcjkb/rustaceanvim",
	version = "^7", -- Recommended
	lazy = false, -- This plugin is already lazy
}
