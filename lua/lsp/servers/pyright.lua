local M = {}

M.on_attach = function(client, bufnr)
	require('lsp').common_on_attach(client, bufnr)
	client.handlers['textDocument/publishDiagnostics'] = function() end
end

M.settings = {
	pyright = {
		autoImportCompletion = true,
		disableOrganizeImports = true, -- Prefiro o do ruff
	},
	python = {
		analysis = {
			autoSearchPaths = true,
      diagnosticMode = 'off', -- Disable diagnostics entirely
			useLibraryCodeForTypes = true,
			typeCheckingMode = 'off',
		},
	},
}

return M
