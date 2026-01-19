local lsp = require('lsp')
local keymap = utils.api.keymap

local server_path = vim.fn.expand('~/dev/che4z-example/dist/server.jar')
local dialect_path = vim.fn.expand('~/dev/che4z-example/dist/dialects/dialect-example.jar')
local dialects_dir = vim.fn.expand('~/dev/che4z-example/dist/dialects')
local M = {
	cmd = {
		'/usr/lib/jvm/java-21-openjdk-amd64/bin/java',
		'-Dline.separator=\r\n',
		'-Dlogback.statusListenerClass=ch.qos.logback.core.status.NopStatusListener',
		'-DserverType=JAVA',
		'-Ddialect.path=' .. dialects_dir,
		'-jar',
		server_path,
		'pipeEnabled',
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
			['cpy-manager'] = {
				['paths-local'] = {},  -- Será preenchido dinamicamente com pastas 'copybook'
				['copybook-extensions'] = { '', '.cpy', '.CPY', '.copy', '.COPY' },
			},
			dialect = {
				registry = {
					{
						name = 'example',
						protocolVersion = 1,
						uri = { scheme = 'file', path = dialect_path },
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

-- Decodifica URL encoding (%XX -> caractere)
local function url_decode(str)
	return str:gsub('%%(%x%x)', function(hex)
		return string.char(tonumber(hex, 16))
	end)
end

-- Handler para resolver URIs de copybooks
-- Retorna apenas a URI, o conteúdo é buscado via file/content
M.handlers['copybook/resolve'] = function(_, params)
	-- params = [documentUri, copybookName, dialect]
	local document_uri = params[1]
	local copybook_name = params[2]

	-- Extensões possíveis
	local extensions = { '.cpy', '.CPY', '.copy', '.COPY', '' }

	-- Começa procurando a partir do diretório do documento
	local document_path = url_decode(document_uri:gsub('^file://', ''))
	local search_path = vim.fn.fnamemodify(document_path, ':h')

	-- Procura em diretórios 'copybook' na hierarquia
	while search_path ~= '/' do
		local parent_dir = vim.fn.fnamemodify(search_path, ':h')
		local copybook_dir = parent_dir .. '/copybook'

		if vim.fn.isdirectory(copybook_dir) == 1 then
			for _, ext in ipairs(extensions) do
				local copybook_path = copybook_dir .. '/' .. copybook_name .. ext
				if vim.fn.filereadable(copybook_path) == 1 then
					copybook_path = vim.fn.fnamemodify(copybook_path, ':p')
					return 'file://' .. copybook_path
				end
			end
		end

		search_path = parent_dir
	end

	-- Não encontrou - retorna vim.NIL (JSON null)
	return vim.NIL
end

M.handlers['copybook/uri'] = function(_, result, err)
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

M.handlers['file/content'] = function(_, params)
	local uri = params
	if type(params) == 'table' then
		uri = params.uri or params[1]
	end

	-- Se não tem URI, retorna null
	if not uri or uri == '' then
		return vim.NIL
	end

	-- Remove file:// prefix e decodifica URL
	local file_path = url_decode(uri:gsub('^file://', ''))

	-- Lê o arquivo
	local file = io.open(file_path, 'r')
	if file then
		local content = file:read('*all')
		file:close()
		return content
	end

	-- Não conseguiu ler - retorna null
	return vim.NIL
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
