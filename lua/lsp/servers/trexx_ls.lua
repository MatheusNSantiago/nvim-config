local M = {}

local trexx_tool_path = vim.fn.expand('~/dev/trexx/trexx-tool/src/lsp/server.ts')
M.cmd = { 'bun', trexx_tool_path, '--stdio' }
M.filetypes = { 'trexx' }

-- Define a raiz do projeto (onde está o db_schema.json)
M.root_dir = require('lspconfig.util').root_pattern('db_schema.json', '.git', 'package.json')

return M
