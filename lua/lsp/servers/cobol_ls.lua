local lsp= require('lsp')
local M = {}


M.cmd = function(dispatcher)
	vim.cmd('silent !~/Documents/Programming/nvim-plugins/CobolLSP/extension/server/native/server-linux &')

	os.execute('sleep 0.1')
	local lsp_rpc_client_factory = vim.lsp.rpc.connect('127.0.0.1', 1044)

	return lsp_rpc_client_factory(dispatcher)
end

M.filetypes = { 'cobol' }
M.on_attach = lsp.common_on_attach
M.capabilities = lsp.client_capabilities()

return M
