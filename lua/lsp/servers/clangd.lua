local M = {}

M.capabilities = require('lsp').client_capabilities()
M.capabilities.offsetEncoding = { 'utf-16' }

return M
