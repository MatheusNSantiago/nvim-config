local M = {}

function M.setup()
	return {
		'linty-org/readline.nvim',
		config = M.config,
	}
end

function M.config()
	local readline = require('readline')
	local keymap = utils.api.keymap

	keymap('i', '<C-f>', '<Right>')
	keymap('i', '<C-b>', '<Left>')
	keymap('i', '<M-f>', readline.forward_word)
	keymap('i', '<M-b>', readline.backward_word)
	keymap('i', '<C-a>', readline.beginning_of_line)
	keymap('i', '<C-e>', readline.end_of_line)
	keymap('i', '<M-d>', readline.kill_word)
	keymap('i', '<M-BS>', readline.backward_kill_word)
	keymap('i', '<C-w>', readline.unix_word_rubout)
	keymap('i', '<C-k>', readline.kill_line)
	keymap('i', '<C-u>', readline.backward_kill_line)
end

return M
