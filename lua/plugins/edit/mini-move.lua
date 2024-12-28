local M = {}

function M.setup()
	return {
		'echasnovski/mini.move',
		config = M.config,
		keys = {
			{ '<M-k>', mode = 'n', desc = 'mini.move: Move Line Down' },
			{ '<M-l>', mode = 'n', desc = 'mini.move: Move Line Up' },
			{ '<M-k>', mode = 'v', desc = 'mini.move: Move Selection Down' },
			{ '<M-l>', mode = 'v', desc = 'mini.move: Move Selection Up' },
		},
	}
end

function M.config()
	require('mini.move').setup({
		-- Module mappings. Use `''` (empty string) to disable one.
		mappings = {
			-- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
			left = '',
			right = '',
			down = '<M-k>',
			up = '<M-l>',
			-- Move current line in Normal mode
			line_left = '',
			line_right = '',
			line_down = '<M-k>',
			line_up = '<M-l>',
		},
		-- Options which control moving behavior
		options = {
			-- Automatically reindent selection during linewise vertical move
			reindent_linewise = true,
		},
	})
end

return M
