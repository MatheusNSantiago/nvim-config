local M = {}

function M.setup()
	return {
		'ThePrimeagen/refactoring.nvim',
		dependencies = { 'lewis6991/async.nvim' },
		config = M.config,
		keys = {
			{ 'rf', ':Refactor extract_func <CR>', mode = 'x', desc = 'refactoring: extract to function' },
			{ 'rv', ':Refactor extract_var <CR>', mode = 'x', desc = 'refactoring: extract to variable' },
		},
	}
end

local function prefer_refactoring_async()
	-- `lewis6991/async.nvim` e `kevinhwang91/promise-async` exportam `lua/async.lua`.
	-- `refactoring.nvim` precisa da API do lewis6991 (`async.wrap`), mas o primeiro
	-- módulo encontrado no runtimepath pode ser promise-async, que não tem `wrap`.
	local async = package.loaded.async
	if async and async.wrap then return end

	local ok, lazy_config = pcall(require, 'lazy.core.config')
	local plugin = ok and lazy_config.plugins['async.nvim']
	if not plugin or not plugin.dir then return end

	package.loaded.async = nil
	package.loaded.async = dofile(plugin.dir .. '/lua/async.lua')
end

function M.config()
	prefer_refactoring_async()

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
