local M = {}

M.root_dir = require('lspconfig.util').root_pattern(
	'pyproject.toml',
	'requirements.txt',
	'.venv',
	'.git',
	'setup.py',
	'setup.cfg',
	'pyrightconfig.json'
)

M.handlers = {
	['textDocument/publishDiagnostics'] = function() end,
}

M.settings = {
	pyright = {
		autoImportCompletion = true,
		disableOrganizeImports = true, -- Prefiro o do ruff
	},
	python = {
		analysis = {
			autoSearchPaths = true,
			-- diagnosticMode = 'openFilesOnly',
			diagnosticMode = 'workspace',
			useLibraryCodeForTypes = true,
			typeCheckingMode = 'off',
		},
	},
}

return M
