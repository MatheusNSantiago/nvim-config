local M = {}

-- Força root no pyrightconfig.json ou .git, ignorando pyproject.toml dos sub-pacotes do monorepo.
M.root_markers = { 'pyrightconfig.json', '.git' }

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
