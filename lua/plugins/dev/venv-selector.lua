local M = {}

local function find_workspace_root(bufnr)
	bufnr = bufnr or vim.api.nvim_get_current_buf()

	local bufname = vim.api.nvim_buf_get_name(bufnr)
	local start_path = bufname ~= '' and vim.fs.dirname(bufname) or vim.fn.getcwd()
	if not start_path or start_path == '' then return nil end

	local current_path = start_path
	local last_pyproject_dir = nil

	while current_path ~= '/' and current_path ~= '' do
		local pyproject_path = current_path .. '/pyproject.toml'
		if vim.fn.filereadable(pyproject_path) == 1 then
			last_pyproject_dir = current_path

			for _, file in ipairs(vim.fn.readdir(current_path)) do
				if file:match('.*%.lock$') then return current_path end
			end
		end

		local parent_path = vim.fn.fnamemodify(current_path, ':h')
		if parent_path == current_path then break end
		current_path = parent_path
	end

	return last_pyproject_dir or start_path
end

M.find_workspace_root = find_workspace_root

local function patch_workspace_fallback()
	local workspace = require('venv-selector.workspace')
	if workspace.imoveis_workspace_fallback then return end

	local list_folders = workspace.list_folders
	workspace.list_folders = function(bufnr)
		local folders = list_folders(bufnr)
		local root = find_workspace_root(bufnr)
		if not root then return folders or {} end

		folders = folders or {}
		if not vim.tbl_contains(folders, root) then table.insert(folders, root) end

		return folders
	end

	workspace.imoveis_workspace_fallback = true
end


function M.setup()
	return {
		'linux-cultist/venv-selector.nvim',
		ft = { 'python', 'ipynb' },
		branch = 'main',
		config = M.config,
	}
end

function M.config()
	patch_workspace_fallback()

	local opts = {
		auto_refresh = true,
		poetry_path = vim.env.HOME .. '/.cache/pypoetry/virtualenvs',
		search = {
			workspace = {
				command = "$FD --full-path -HIL '/python$' '$WORKSPACE_PATH/.venv/bin'",
			},
		},
		options = {
			on_telescope_result_callback = function(filename)
				-- Esta função deixa os nomes dos venvs mais legíveis
				local workspace_root = find_workspace_root()
				if workspace_root then return workspace_root end

				return filename:gsub(os.getenv('HOME'), '~'):gsub('/bin/python', '')
			end,
		},
	}

	require('venv-selector').setup(opts)
end

return M
