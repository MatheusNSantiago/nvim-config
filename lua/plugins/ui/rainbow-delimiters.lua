local M = {}

function M.setup()
	return {
		'HiPhish/rainbow-delimiters.nvim',
		config = M.config,
	}
end

function M.config()
	local rainbow_delimiters = require('rainbow-delimiters')

	vim.g.rainbow_delimiters = {
		strategy = {
			[''] = rainbow_delimiters.strategy['global'], -- default
		},
		query = {
			[''] = 'rainbow-delimiters', -- default
			lua = 'rainbow-blocks', -- Matches keyword delimiters like like `function` and `end`, in addition to parentheses
		},
		highlight = {
			'RainbowDelimiterYellow',
			'RainbowDelimiterRed',
			'RainbowDelimiterOrange',
			'RainbowDelimiterBlue',
			'RainbowDelimiterGreen',
			'RainbowDelimiterViolet',
			'RainbowDelimiterCyan',
		},
		-- blacklist = { 'c', 'cpp' },
	}
end

return M
