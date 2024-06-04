local M = {}

function M.setup()
	return {
		'folke/tokyonight.nvim',
		lazy = false,  -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = M.config,
	}
end

function M.config()
	local is_wsl = utils.is_os_running_on_wsl()

	require('tokyonight').setup({
		style = 'night',        -- night | storm | moon
		transparent = not is_wsl, -- Enable this to disable setting the background color
		terminal_colors = false, -- Configure the colors used when opening a `:terminal` in Neovim
		styles = {
			-- Style to be applied to different syntax groups
			-- Value is any valid attr-list value `:help attr-list`
			comments = 'italic',
			keywords = 'italic',
			functions = 'bold',
			variables = 'NONE',
			-- Background styles. Can be "dark", "transparent" or "normal"
			sidebars = is_wsl and 'normal' or 'transparent', -- style for sidebars, see below
			floats = is_wsl and 'normal' or 'transparent', -- style for floating windows
		},
		-- on_highlights = function(hl, _)
		-- 	for group, colors in pairs(require('colorscheme').get_all_highlights()) do
		-- 		hl[group] = colors
		-- 	end
		-- end,
	})

	vim.cmd([[colorscheme tokyonight]])
end

return M
