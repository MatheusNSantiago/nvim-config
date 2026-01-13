local lsp = require('lsp')
local keymap = utils.api.keymap

  -- server.jar  : /home/matheus/dev/che4z-example/che-che4z-lsp-for-cobol/server/engine/target/server.jar
  -- dialect jar :
  --
  -- local server_path = vim.fn.expand('~/dev/che-che4z-lsp-for-cobol/server/engine/target/server.jar')
-- local dialect_path = vim.fn.expand('~/dev/cobol-dialect-template/server/dialect-example/target/dialect-example.jar')

local server_path = vim.fn.expand("~/dev/che4z-example/che-che4z-lsp-for-cobol/server/engine/target/server.jar")
local dialect_path = vim.fn.expand('~/dev/che4z-example/dialects/dialect-example.jar')
local M = {
	cmd = {
		'java',
		'-jar',
		server_path,
		'pipeEnabled',
		'-Dline.separator=\r\n',
		'-Dlogback.statusListenerClass=ch.qos.logback.core.status.NopStatusListener',
		'-DserverType=NATIVE',
	},
	filetypes = { 'cobol', 'copybook' },
	capabilities = lsp.client_capabilities(),
	settings = {
		['cobol-lsp'] = {
			dialects = { 'example' },
			['analysis-mode'] = 'ADVANCED',
			['target-sql-backend-enable-processing'] = true,
			['target-sql-backend'] = 'DB2_SERVER',
			cics = { translator = true },
			logging = { level = { root = 'ERROR' } },
			dialect = {

				registry = {
					{
						name = 'example',
						protocolVersion = 1,
						uri = {
							scheme = 'file',
							path = dialect_path,
						},
						description = 'Example dialect (local)',
						extensionId = 'nvim-local',
					},
				},
			},
		},
	},
}
-- M.cmd = function(dispatchers)
-- 	local is_wsl = utils.is_wsl()
-- 	local lsp_path = '~/dev/cobol/plugins/server-linux'
--
-- 	if is_wsl then lsp_path = '~/dev/cobol/server-linux' end
--
-- 	local params =
-- 		[[Dline.separator=\r\n Dlogback.statusListenerClass=ch.qos.logback.core.status.NopStatusListener DserverType=NATIVE]]
--
-- 	vim.cmd(('silent !%s %s &'):format(lsp_path, params))
--
-- 	os.execute('sleep 0.5')
-- 	local lsp_rpc_client_factory = vim.lsp.rpc.connect('127.0.0.1', 1044)
--
-- 	return lsp_rpc_client_factory(dispatchers)
-- end

M.handlers = vim.lsp.handlers
M.handlers['copybook/resolve'] = function(_, result, err)
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
	return err
end

M.on_attach = function(client, bufnr)
	lsp.common_on_attach(client, bufnr)

	-- Abre a definição em um novo buffer na vertical
	keymap('n', 'gV', function()
		vim.cmd('vsplit')

		vim.cmd('wincmd w')
		vim.cmd('wincmd L')
		vim.cmd('Lspsaga goto_definition')

		vim.cmd('vertical resize ' .. 127)
	end)
end

return M
