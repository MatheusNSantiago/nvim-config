local lsp = require('lsp')

local M = {
	filetypes = { 'cobol' },
	on_attach = lsp.common_on_attach,
	capabilities = lsp.client_capabilities(),
	root_dir = require('lspconfig.util').find_git_ancestor,
	single_file_support = true,
}

M.cmd = function(dispatcher)
	local lsp_path = '~/Documents/Programming/nvim-plugins/CobolLSP/extension/server/native/server-linux'
	local params =
	[[-pipeEnabled --Dline.separator=\r\n Dlogback.statusListenerClass=ch.qos.logback.core.status.NopStatusListener DserverType=NATIVE]]

	vim.cmd(('silent !%s %s &'):format(lsp_path, params))

	os.execute('sleep 0.1')
	local lsp_rpc_client_factory = vim.lsp.rpc.connect('127.0.0.1', 1044)

	return lsp_rpc_client_factory(dispatcher)
end

return M
