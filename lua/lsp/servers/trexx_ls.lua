local M = {}

local trexx_tool_path = vim.fn.expand('~/dev/trexx/trexx-tool/src/lsp/server.ts')
M.config = {
	cmd = { 'bun', trexx_tool_path, '--stdio' },

	filetypes = { 'trexx' },

	-- Define a raiz do projeto (onde está o db_schema.json)
	root_dir = require('lspconfig.util').root_pattern('db_schema.json', '.git', 'package.json'),

	settings = {
		trexx = {
			-- Configurações futuras podem vir aqui
		},
	},
}

return M
