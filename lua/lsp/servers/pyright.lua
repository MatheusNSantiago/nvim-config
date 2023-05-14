local M = {}

M.handlers = {
	["textDocument/publishDiagnostics"] = vim.lsp.with(
		vim.lsp.diagnostic.on_publish_diagnostics,
		{ virtual_text = false }
	),
}


M.settings = {
	pyright = { autoImportCompletion = true },
	python = {
		analysis = {
			autoSearchPaths = true,
			diagnosticMode = 'openFilesOnly',
			useLibraryCodeForTypes = true,
			completeFunctionParens = true,
			typeCheckingMode = 'off',
		},
	},
}

M.on_attach = function(client, bufnr)
	require('lsp').common_on_attach(client, bufnr)

	utils.api.keymap('n', '<leader>r', [[:w<CR>:TermExec cmd='python "%"'<CR>]], { buffer = bufnr, desc = 'python: [R]un' })
end

return M
