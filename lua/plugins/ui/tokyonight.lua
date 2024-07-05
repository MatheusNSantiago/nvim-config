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
	local is_wsl = utils.is_wsl()

	require('tokyonight').setup({
		style = 'night',        -- night | storm | moon
		transparent = not is_wsl, -- Enable this to disable setting the background color
		terminal_colors = false, -- Configure the colors used when opening a `:terminal` in Neovim
		styles = {
			-- Style to be applied to different syntax groups
			-- Value is any valid attr-list value for `:help nvim_set_hl`
			comments = { italic = true },
			keywords = { italic = true },
			functions = { bold = true },
			variables = {},                             -- variables = 'NONE',
			-- Background styles. Can be "dark", "transparent" or "normal"
			sidebars = is_wsl and 'dark' or 'transparent', -- style for sidebars, see below
			floats = is_wsl and 'dark' or 'transparent', -- style for floating windows
		},
		dim_inactive = false,                         -- dims inactive windows
		lualine_bold = false,                         -- When `true`, section headers in the lualine theme will be bold
		--- You can override specific color groups to use other groups or a hex color
		--- function will be called with a ColorScheme table
		-- on_colors = function(colors) end,

		--- You can override specific highlights to use other groups or a hex color
		--- function will be called with a Highlights and ColorScheme table
		on_highlights = function(hl, _)
			for group, colors in pairs(require('colorscheme').get_all_highlights()) do
				hl[group] = colors
			end
		end,

		cache = true, -- When set to true, the theme will be cached for better performance

		---@type table<string, boolean|{enabled:boolean}>
		plugins = {
			-- enable all plugins when not using lazy.nvim
			-- set to false to manually enable/disable plugins
			all = package.loaded.lazy == nil,
			-- uses your plugin manager to automatically enable needed plugins
			-- currently only lazy.nvim is supported
			auto = true,
			-- add any plugins here that you want to enable
			-- for all possible plugins, see:
			--   * https://github.com/folke/tokyonight.nvim/tree/main/lua/tokyonight/groups
			-- telescope = true,
		},
	})

	vim.cmd([[colorscheme tokyonight]])
end

return M
