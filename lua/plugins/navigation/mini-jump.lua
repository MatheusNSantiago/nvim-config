local M = {}

function M.setup()
	return {
		'echasnovski/mini.jump',
		config = M.config,
	}
end

function M.config()
	require('mini.jump').setup({
		-- Module mappings. Use `''` (empty string) to disable one.
		mappings = {
			forward = 'f',
			backward = 'F',
			forward_till = 't',
			backward_till = 'T',
			repeat_jump = ';',
		},
		-- Delay values (in ms) for different functionalities. Set any of them to
		-- a very big number (like 10^7) to virtually disable.
		delay = {
			-- Delay between jump and highlighting all possible jumps
			highlight = 250,
			-- Delay between jump and automatic stop if idle (no jump is done)
			idle_stop = 10000000,
		},
	})
end

local c = require('utils.colors')
M.highlights = {
	MiniJump = { bg = c.transparent, fg = c.red, bold = true, underline = true },
}

return M
