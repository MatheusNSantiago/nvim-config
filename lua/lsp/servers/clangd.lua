local M = {}

M.capabilities = require('lsp').common_capabilities()
M.capabilities.offsetEncoding = { 'utf-16' }

return M
