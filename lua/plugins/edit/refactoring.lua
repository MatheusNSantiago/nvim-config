local M = {}
local keymap = utils.api.keymap

function M.setup()
	return {
		'ThePrimeagen/refactoring.nvim',
		dependencies = { 'nvim-lua/plenary.nvim', 'nvim-treesitter/nvim-treesitter', 'lewis6991/async.nvim' },
		config = M.config,
		lazy = true,
		keys = {
			{ 'rf', mode = 'x', desc = 'refactoring: extract to function' },
			{ 'rv', mode = 'x', desc = 'refactoring: extract to variable' },
			{ '<leader>rp', mode = 'n', desc = 'refactoring: print variable' },
			{ '<leader>rc', mode = 'n', desc = 'refactoring: clean prints' },
		},
	}
end

function M.config()
	local refactoring_debug = require('refactoring.debug')

	keymap('x', 'rf', ':Refactor extract <CR>', { desc = 'refactoring: extract to function' })
	keymap('x', 'rv', ':Refactor extract_var <CR>', { desc = 'refactoring: extract to variable' })
	keymap('n', '<leader>rp', refactoring_debug.print_var, { expr = true, desc = 'refactoring: print variable' })
	keymap('n', '<leader>rc', refactoring_debug.cleanup, { expr = true, desc = 'refactoring: clean prints' })

	require('refactoring').setup({
		prompt_func_return_type = {
			go = false,
			java = false,

			cpp = false,
			c = false,
			h = false,
			hpp = false,
			cxx = false,
		},
		prompt_func_param_type = {
			go = false,
			java = false,

			cpp = false,
			c = false,
			h = false,
			hpp = false,
			cxx = false,
		},
		print_var_statements = {
			-- cpp = {
			-- 	'printf("a custom statement %%s %s", %s)',
			-- },
		},
		printf_statements = {
			-- add a custom printf statement for cpp
			cpp = {
				-- 'std::cout << "%s" << std::endl;',
			},
		},
	})
end

return M
