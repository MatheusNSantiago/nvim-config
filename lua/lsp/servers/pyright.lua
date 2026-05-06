local M = {}
local util = require('lspconfig.util')

M.on_attach = function(client, bufnr)
	require('lsp').common_on_attach(client, bufnr)
end

-- Força root no pyrightconfig.json ou .git, ignorando pyproject.toml dos sub-pacotes do monorepo.
M.root_dir = util.root_pattern('pyrightconfig.json', '.git')

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
