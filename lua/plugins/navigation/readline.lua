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

	keymap({ 'i', 'c' }, '<C-f>', '<Right>')
	keymap({ 'i', 'c' }, '<C-b>', '<Left>')
	keymap({ 'i', 'c' }, '<M-f>', readline.forward_word)
	keymap({ 'i', 'c' }, '<M-b>', readline.backward_word)
	keymap({ 'i', 'c' }, '<C-a>', readline.beginning_of_line)
	keymap({ 'i', 'c' }, '<C-e>', readline.end_of_line)
	keymap({ 'i', 'c' }, '<M-d>', readline.kill_word)
	keymap({ 'i', 'c' }, '<C-BS>', readline.backward_kill_word)
	keymap({ 'i', 'c' }, '<M-BS>', readline.backward_kill_word)
	keymap({ 'i', 'c' }, '<C-w>', readline.unix_word_rubout)
	keymap({ 'i', 'c' }, '<C-k>', readline.kill_line)
	keymap({ 'i', 'c' }, '<C-u>', readline.backward_kill_line)
end

return M
