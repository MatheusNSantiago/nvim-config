---@type FiletypeSettings
return {
	picker = {
		keymap = '<leader><leader>o',
		title = 'Python Commands',
		actions = {

			{ name = 'Selecionar venv', handler = ':VenvSelect<CR>' },
			-- {
			--   name = 'Iniciar Projeto',
			--   handler = function()
			--     exec('python -m venv --upgrade-deps .venv')
			--     exec('source .venv/bin/activate.fish')
			--     exec('curl -o .gitignore https://raw.githubusercontent.com/github/gitignore/master/Python.gitignore')
			--     exec('touch main.py requirements.txt')
			--   end,
			-- },
			-- { name = 'install requirements', handler = 'pip install -r requirements.txt' },
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

						if package_manager == 'uv' then --
							-- codebase/codebase.py --> codebase.codebase
							local module_path = current_relative_path:gsub('%.py$', ''):gsub('/', '.')

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
