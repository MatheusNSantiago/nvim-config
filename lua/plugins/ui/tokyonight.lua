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
		-- sidebars = { "qf", "help" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
		day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
		hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
		dim_inactive = false, -- dims inactive windows
		lualine_bold = false, -- When `true`, section headers in the lualine theme will be bold
		--- You can override specific color groups to use other groups or a hex color
		--- function will be called with a ColorScheme table
		on_colors = function(colors)
			-- colors.border = "#1A1B26"
		end,
		--- You can override specific highlights to use other groups or a hex color
		--- fucntion will be called with a Highlights and ColorScheme table
		-- on_highlights = function(highlights, colors) end,
		on_highlights = function(hl, _)
		end,
	})
	vim.cmd([[colorscheme tokyonight]])
end

return M