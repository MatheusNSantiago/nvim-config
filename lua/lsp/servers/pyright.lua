local M = {}

-- Força root no pyrightconfig.json ou .git, ignorando pyproject.toml dos sub-pacotes do monorepo.
M.root_markers = { 'pyrightconfig.json', '.git' }

local function find_python_path()
	if vim.env.VIRTUAL_ENV and vim.env.VIRTUAL_ENV ~= '' then
		local python = vim.fs.joinpath(vim.env.VIRTUAL_ENV, 'bin', 'python')
		if vim.fn.executable(python) == 1 then return python end
	end

	local bufname = vim.api.nvim_buf_get_name(0)
	local start = bufname ~= '' and vim.fs.dirname(bufname) or vim.fn.getcwd()
	local venv = vim.fs.find('.venv', { path = start, upward = true, type = 'directory' })[1]
	if venv then
		local python = vim.fs.joinpath(venv, 'bin', 'python')
		if vim.fn.executable(python) == 1 then return python end
	end
end

function M.before_init(_, config)
	local python = find_python_path()
	if not python then return end

	config.settings = config.settings or {}
	config.settings.python = config.settings.python or {}
	config.settings.python.pythonPath = python
end


M.settings = {
	pyright = {
		autoImportCompletion = true,
		disableOrganizeImports = true, -- Prefiro o do ruff
	},
	python = {
		analysis = {
			autoSearchPaths = true,
			diagnosticMode = 'openFilesOnly',
			useLibraryCodeForTypes = true,
			typeCheckingMode = 'off',
			diagnosticSeverityOverrides = {
				reportMissingImports = 'none',
				reportMissingModuleSource = 'none',
			},
		},
	},
}

return M
