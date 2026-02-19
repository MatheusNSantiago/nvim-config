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
							-- make path relative to project root
							local abs_path = vim.fn.expand('%:p')
							local rel_path = abs_path:sub(#project_root + 2)
							-- codebase/codebase.py --> codebase.codebase
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
		{
			'n',
			'<leader><leader>r',
			function()
				vim.cmd('w')
				local current_relative_path = vim.fn.expand('%')

				local run = function(cmd)
					U.exec_cmd(cmd)
					vim.defer_fn(function() vim.cmd('stopinsert') end, 100)
				end

				local is_python_project = vim.fn.glob(vim.fn.getcwd() .. '/pyproject.toml') ~= ''
				U.log({
					('current_relative_path: %s'):format(current_relative_path),
					('is_python_project: %s'):format(tostring(is_python_project)),
				})
				if is_python_project then
					local project_root = require('venv-selector.utils').find_workspace_root()
					local lock_file = vim
						.iter(vim.fn.readdir(project_root))
						:find(function(file) return file:match('.*%.lock') end)

					U.log({
						('current_relative_path: %s'):format(current_relative_path),
						('is_python_project: %s'):format(tostring(is_python_project)),
						('project_root: %s'):format(project_root),
						('lock_file: %s'):format(tostring(lock_file)),
					})

					if lock_file then
						local package_manager = lock_file:match('^(.-)%.lock$')

						U.log({
							('current_relative_path: %s'):format(current_relative_path),
							('is_python_project: %s'):format(tostring(is_python_project)),
							('project_root: %s'):format(project_root),
							('lock_file: %s'):format(tostring(lock_file)),
							('package_manager: %s'):format(tostring(package_manager)),
						})

						if package_manager == 'uv' then --
							-- codebase/codebase.py --> codebase.codebase
							local module_path = current_relative_path:gsub('%.py$', ''):gsub('/', '.')

							U.log({
								('current_relative_path: %s'):format(current_relative_path),
								('is_python_project: %s'):format(tostring(is_python_project)),
								('project_root: %s'):format(project_root),
								('lock_file: %s'):format(tostring(lock_file)),
								('package_manager: %s'):format(tostring(package_manager)),
								('module_path: %s'):format(tostring(module_path)),
							})

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
