local M = {}

function M.setup()
	local is_installed = pcall(require, 'colorizer')

	if is_installed then
		---@diagnostic disable-next-line: missing-fields
		utils.api.augroup('AttatchColorizer', {
			event = { 'BufEnter', 'BufWritePost', 'BufReadPost' },
			pattern = '*',
			command = function()
				if vim.bo.filetype == 'NvimTree' then return end

				return vim.cmd([[ColorizerAttachToBuffer]])
			end,
		})
	end

	return {
		'norcalli/nvim-colorizer.lua',
		config = M.config,
	}
end

function M.config()
	require('colorizer').setup({
		buftype = { '*', '!prompt', '!nofile' },
		filetypes = { '*', '!NvimTree', '!gitcommit' },
		user_default_options = {
			-- tailwind = 'both',
			RGB = true,       -- #RGB hex codes
			RRGGBB = true,    -- #RRGGBB hex codes
			names = true,     -- "Name" codes like Blue
			RRGGBBAA = true, -- #RRGGBBAA hex codes
			AARRGGBB = true,                             -- 0xAARRGGBB hex codes
			rgb_fn = true,   -- CSS rgb() and rgba() functions
			hsl_fn = true,   -- CSS hsl() and hsla() functions
			css = true,      -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
			css_fn = true,   -- Enable all CSS *functions*: rgb_fn, hsl_fn
			sass = { enable = false, parsers = { 'css' } }, -- Enable sass colors
			-- Available modes: foreground, background
			mode = 'background', -- Set the display mode.
		},
	})
end

return M
