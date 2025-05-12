local M = {}

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
