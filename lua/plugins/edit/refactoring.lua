local M = {}

function M.setup()
	return {
		'ThePrimeagen/refactoring.nvim',
		requires = {
			{ 'nvim-lua/plenary.nvim' },
			{ 'nvim-treesitter/nvim-treesitter' },
		},
		config = M.config,
	}
end

function M.config()
	local refactoring = require('refactoring')
	local keymap = utils.api.keymap

	keymap('x', '<leader>rf', ':Refactor extract <CR>', { desc = 'refactoring: extract to function' })
	keymap('x', '<leader>rv', ':Refactor extract_var <CR>', { desc = 'refactoring: extract to variable' })

	keymap('n', '<leader>rp', refactoring.debug.print_var, { desc = 'refactoring: print variable' })
	keymap('n', '<leader>rc', refactoring.debug.cleanup, { desc = 'refactoring: clean prints' })

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
