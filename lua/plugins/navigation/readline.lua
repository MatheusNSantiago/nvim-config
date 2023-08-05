local M = {}

function M.setup()
	return {
		'linty-org/readline.nvim',
		keys = M.keys,
	}
end

function M.keys()
	local readline = require('readline')

  return {
	{'<C-f>', '<Right>', mode = '!'},
	{'<C-b>', '<Left>', mode = '!'},
	{'<M-f>', readline.forward_word, mode = '!'},
	{'<M-b>', readline.backward_word, mode = '!'},
	{'<C-a>', readline.beginning_of_line, mode = '!'},
	{'<C-e>', readline.end_of_line, mode = '!'},
	{'<M-d>', readline.kill_word, mode = '!'},
	{'<C-BS>', readline.backward_kill_word, mode = '!'},
	{'<M-BS>', readline.backward_kill_word, mode = '!'},
	{'<C-w>', readline.unix_word_rubout, mode = '!'},
	{'<C-k>', readline.kill_line, mode = '!'},
	{'<C-u>', readline.backward_kill_line, mode = '!'},
}
end

return M
