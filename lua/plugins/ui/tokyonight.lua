local M = {}

function M.setup()
	return {
		"folke/tokyonight.nvim",
		config = M.config,
	}
end

function M.config()
	local tokyonight = require("tokyonight")

	tokyonight.setup({
		style = "night",   -- night | storm | moon
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
			floats = "transparent", -- style for floating windows
		},
		-- on_highlights = function(highlights, colors) end,
		on_highlights = function(hl, _)
			local highlights = require("colorscheme").get_all_highlights()

			for group, highlight in pairs(highlights) do
				hl[group] = highlight
			end
		end,
	})
	vim.cmd([[colorscheme tokyonight]])
end

return M
