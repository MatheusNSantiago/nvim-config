local lsp = require('lsp')

local M = {
	name = 'cobol_ls',
	filetypes = { 'cobol', 'copybook' },
	capabilities = lsp.client_capabilities(),
	root_dir = lsp.utils.find_root_dir,
}

M.cmd = function(dispatchers)
	local is_wsl = utils.is_os_running_on_wsl()
	-- local lsp_path = '~/Documents/Programming/nvim-plugins/CobolLSP/extension/server/native/server-linux'
	local lsp_path = '~/dev/cobol/plugins/server-linux'

	if is_wsl then lsp_path = '~/dev/cobol/server-linux' end

	local params =
	[[Dline.separator=\r\n Dlogback.statusListenerClass=ch.qos.logback.core.status.NopStatusListener DserverType=NATIVE]]
	-- [[pipeEnabled Dline.separator=\r\n Dlogback.statusListenerClass=ch.qos.logback.core.status.NopStatusListener DserverType=NATIVE]]

	vim.cmd(('silent !%s %s &'):format(lsp_path, params))

	os.execute('sleep 0.5')
	local lsp_rpc_client_factory = vim.lsp.rpc.connect('127.0.0.1', 1044)

	return lsp_rpc_client_factory(dispatchers)
end

M.handlers = {
	['copybook/resolve'] = function(_, result, _)
		local uri, name = unpack(result)
		local filename = name .. '.cpy'
		local path = uri:gsub('file://', '')

		while path ~= '/' do
			local parent_dir_path = vim.fn.fnamemodify(path, ':h')
			local parent_dir_files = Array(vim.fn.readdir(parent_dir_path))

			if parent_dir_files:contains('copybook') then
				local copybook_uri = ('file://%s/copybook/%s'):format(parent_dir_path, filename)
				return copybook_uri
			end

			path = parent_dir_path
		end

		print("Não foi possível encontrar o copybook '" .. filename .. "'")
	end,
}

M.on_attach = function(client, bufnr)
	local keymap = utils.api.keymap

	local caps = client.server_capabilities

	-- Enable completion triggered by <C-X><C-O>
	if caps.completionProvider then vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc' end

	-- Use LSP as the handler for formatexpr.
	if caps.documentFormattingProvider then vim.bo[bufnr].formatexpr = 'v:lua.vim.lsp.formatexpr()' end

	-- setup navic (breadcrumbs) e outros simbolos
	require('lsp.utils').setup_document_symbols(client, bufnr)

	-- Diagnostic jump
	keymap('n', '[e', ':Lspsaga diagnostic_jump_prev<CR>')
	keymap('n', ']e', ':Lspsaga diagnostic_jump_next<CR>')

	-- Diagnostic jump with filters such as only jumping to an error
	keymap('n', '[E', ":lua require('lspsaga.diagnostic').goto_prev({ severity = 1 })<CR>")
	keymap('n', ']E', ":lua require('lspsaga.diagnostic').goto_next({ severity = 1 })<CR>")

	keymap('n', '<leader>sd', ':Telescope diagnostics<CR>', { desc = '[S]earch [D]iagnostics' })
	keymap('n', '<leader>sR', ':Telescope lsp_references<CR>', { desc = '[S]earch [R]eferences' })
	keymap('n', '<leader>si', ':Telescope lsp_implementations<CR>', { desc = '[S]earch [I]mplementations' })

	keymap('n', 'gr', ':Lspsaga rename<CR>')
	keymap('n', 'gp', ':Lspsaga peek_definition<CR>')
	keymap('n', 'gf', ':Lspsaga finder<CR>')

	keymap('n', 'gd', ':Lspsaga goto_definition<CR>')
	keymap('n', 'gD', ':tab split | Lspsaga goto_definition<CR>')           -- Abre a definição em um novo buffer
	keymap('n', 'gV', ':vsplit<CR><C-w>w<C-w>L:Lspsaga goto_definition<CR>') -- Abre a definição em um novo buffer na vertical
	keymap('n', '<leader>ca', ':Lspsaga code_action<CR>')                   -- Code action
	keymap('n', 'gl', ':Lspsaga show_line_diagnostics<CR>')                 -- Show line diagnostics
end

return M
