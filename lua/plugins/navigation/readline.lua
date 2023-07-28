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

	keymap('!', '<C-f>', '<Right>')
	keymap('!', '<C-b>', '<Left>')
	keymap('!', '<M-f>', readline.forward_word)
	keymap('!', '<M-b>', readline.backward_word)
	keymap('!', '<C-a>', readline.beginning_of_line)
	keymap('!', '<C-e>', readline.end_of_line)
	keymap('!', '<M-d>', readline.kill_word)
	keymap('!', '<C-BS>', readline.backward_kill_word)
	keymap('!', '<M-BS>', readline.backward_kill_word)
	keymap('!', '<C-w>', readline.unix_word_rubout)
	keymap('!', '<C-k>', readline.kill_line)
	keymap('!', '<C-u>', readline.backward_kill_line)
end

return M
