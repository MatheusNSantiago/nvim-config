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

				local python_executable

				local is_poetry_project = vim.fn.glob(vim.fn.getcwd() .. '/pyproject.toml') ~= ''
				if is_poetry_project then
					python_executable = require('venv-selector').python()

					if python_executable == nil then
						utils.error('Usa :VenvSelect e selecione o poetry environment')
						return
					end
				else
					python_executable = 'python'
				end

				U.exec_cmd(python_executable .. ' ' .. vim.fn.expand('%'))
				vim.defer_fn(function() vim.cmd('stopinsert') end, 100)
			end,
			desc = 'python: [R]un',
		},
	},
}
