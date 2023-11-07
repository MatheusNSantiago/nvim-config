local lsp = require('lsp')

local M = {
	name = 'cobol_ls',
	filetypes = { 'cobol' },
	capabilities = lsp.client_capabilities(),
	root_dir = require('lspconfig.util').find_git_ancestor(),
	single_file_support = true,
}

M.cmd = function(dispatchers)
	local is_wsl = utils.is_os_running_on_wsl()
	local lsp_path = '~/Documents/Programming/nvim-plugins/CobolLSP/extension/server/native/server-linux'

	if is_wsl then
		lsp_path =
		'~/.vscode-server/extensions/broadcommfd.cobol-language-support-2.0.3-linux-x64/server/native/server-linux'
	end

	local params =
	[[Dline.separator=\r\n Dlogback.statusListenerClass=ch.qos.logback.core.status.NopStatusListener DserverType=NATIVE]]
	-- [[pipeEnabled Dline.separator=\r\n Dlogback.statusListenerClass=ch.qos.logback.core.status.NopStatusListener DserverType=NATIVE]]

	vim.cmd(('silent !%s %s &'):format(lsp_path, params))

	os.execute('sleep 0.5')
	local lsp_rpc_client_factory = vim.lsp.rpc.connect('127.0.0.1', 1044)

	return lsp_rpc_client_factory(dispatchers)
end

M.handlers = {
	['copybook/resolve'] = function(err, result, ctx)
		return 'file:///home/matheus/Documents/Programming/cobol/copy-books/vendas.cpy'
	end,
}

M.on_attach = function(client, bufnr) lsp.common_on_attach(client, bufnr) end

return M
