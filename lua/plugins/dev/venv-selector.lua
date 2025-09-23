local M = {}

function M.setup()
	return {
		'linux-cultist/venv-selector.nvim',
		ft = 'python',
		branch = 'main',
		config = M.config,
	}
end

function M.config()
	local opts = {
		auto_refresh = true,
		poetry_path = vim.env.HOME .. '/.cache/pypoetry/virtualenvs',
		search = {
			cwd = {
				command = "$FD --full-path -HIL 'python$' '$WORKSPACE_ROOT/.venv/bin'",
			},
		},
		options = {
			on_telescope_result_callback = function(filename)
				-- Esta função deixa os nomes dos venvs mais legíveis
				local workspace_root = require('venv-selector.utils').find_workspace_root()
				if workspace_root then return workspace_root end

				return filename:gsub(os.getenv('HOME'), '~'):gsub('/bin/python', '')
			end,
		},
	}

	require('venv-selector.utils').find_workspace_root = function()
		-- Começa a busca a partir do diretório do arquivo atual
		local start_path = vim.fn.expand('%:p:h')
		local current_path = start_path

		local last_pyproject_dir = nil

		-- Sobe na árvore de diretórios
		while current_path ~= '/' and current_path ~= '' do
			local pyproject_path = current_path .. '/pyproject.toml'
			if vim.fn.filereadable(pyproject_path) == 1 then
				last_pyproject_dir = current_path

				local lock_file = vim.iter(vim.fn.readdir(current_path)):find(function(file) return file:match('.*%.lock') end)

				local is_project_root = lock_file ~= nil
				if is_project_root then --
					return current_path
				end
			end

			-- Sobe um nível no diretório
			local parent_path = vim.fn.fnamemodify(current_path, ':h')
			if parent_path == current_path then break end -- Evita loop infinito na raiz
			current_path = parent_path
		end

		if last_pyproject_dir == nil then return start_path end
		return last_pyproject_dir
	end

	-- Substitui a nossa variável customizada '$WORKSPACE_ROOT' pelo caminho encontrado
	local root = require('venv-selector.utils').find_workspace_root()
	if root and opts.search and opts.search.cwd then
		opts.search.cwd.command = opts.search.cwd.command:gsub('$WORKSPACE_ROOT', root)
	else
		-- Se não encontramos uma raiz de workspace, desabilitamos essa busca para não dar erro
		opts.search.cwd = false
	end

	require('venv-selector').setup(opts)
end

return M
