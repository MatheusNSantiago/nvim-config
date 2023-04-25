local M = {}

function M.setup()
	return {
		"folke/tokyonight.nvim",
		config = M.config,
	}
end

function M.config()
	local tokyonight = require("tokyonight")

	-- Set Colorscheme

	tokyonight.setup({
		style = "night", -- night | storm | moon
		transparent = true, -- Enable this to disable setting the background color
		terminal_colors = false, -- Configure the colors used when opening a `:terminal` in Neovim
		styles = {
			-- Style to be applied to different syntax groups
			-- Value is any valid attr-list value `:help attr-list`
			comments = "italic",
			keywords = "italic",
			functions = "bold",
			variables = "NONE",
			-- Background styles. Can be "dark", "transparent" or "normal"
			sidebars = "transparent", -- style for sidebars, see below
			-- floats = "dark", -- style for floating windows
			floats = "transparent", -- style for floating windows
		},
		hide_inactive_statusline = true, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
		dim_inactive = false, -- dims inactive windows
		lualine_bold = true, -- When `true`, section headers in the lualine theme will be bold
	})
	vim.cmd([[colorscheme tokyonight]])
end

return M
