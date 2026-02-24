---@type FiletypeSettings
return {
	picker = {
		keymap = '<leader><leader>o',
		title = 'Python Commands',
		actions = {
			{ name = 'Selecionar venv', handler = ':VenvSelect<CR>' },
		},
	},
	mappings = {
		{
			'n',
			'<leader>r',
			function()
				vim.cmd('w')
				local current_relative_path = vim.fn.expand('%')

				local run = function(cmd)
					U.exec_cmd(cmd)
					vim.defer_fn(function() vim.cmd('stopinsert') end, 100)
				end

				local is_python_project = vim.fn.glob(vim.fn.getcwd() .. '/pyproject.toml') ~= ''
				if is_python_project then
					local project_root = require('venv-selector.utils').find_workspace_root()
					local lock_file = vim
						.iter(vim.fn.readdir(project_root))
						:find(function(file) return file:match('.*%.lock') end)

					if lock_file then
						local package_manager = lock_file:match('^(.-)%.lock$')

						if package_manager == 'uv' then
							local abs_path = vim.fn.expand('%:p')
							-- Encontra o pyproject.toml mais próximo (workspace member, não a raiz)
							local pkg_toml = vim.fs.find('pyproject.toml', {
								path = vim.fn.fnamemodify(abs_path, ':h'),
								upward = true,
							})[1]
							local base_dir = pkg_toml and vim.fn.fnamemodify(pkg_toml, ':h') or project_root
							local rel_path = abs_path:sub(#base_dir + 2)
							local module_path = rel_path:gsub('%.py$', ''):gsub('/', '.')
							return run('uv run python -m ' .. module_path)
						end
					end

					local python_executable = require('venv-selector').python()

					return run(python_executable .. ' ' .. current_relative_path)
				end

				return run('python ' .. current_relative_path)
			end,
			desc = 'python: [R]un',
		},
	},
}
