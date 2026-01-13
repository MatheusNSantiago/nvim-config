local M = {}
local keymap = utils.api.keymap

M.servers = {
	'cssls',
	'html',
	-- 'angularls@17.0.0',
	'jdtls',
	'tailwindcss',
	'ts_ls',
	'jsonls',
	'yamlls',
	'dockerls',
	'lua_ls',
	'bashls',
	'cobol_ls',
	'dart_ls',
	'gopls',
	'pyright',
	'ruff',
	'sqls',
	'clangd',
	'rust-analyzer', -- inicializado pelo rustacean
	'trexx_ls',
}

M.custom_lsps = {
	'dart_ls',
	'rust-analyzer',
	'jdtls',
	'cobol_ls',
	'trexx_ls',
}

---editor's capabilities + some overrides.
M.client_capabilities = function()
	return vim.tbl_deep_extend(
		'force',
		vim.lsp.protocol.make_client_capabilities(),
		require('blink.cmp').get_lsp_capabilities()
	)
end

---Sets up LSP keymaps and autocommands for the given buffer.
---@param client vim.lsp.Client
---@param bufnr integer
function M.common_on_attach(client, bufnr)
	local caps = client.server_capabilities
	if not caps then return end

	if caps.documentSymbolProvider then -- Setup nav buddy
		local navbuddy_ok, navbuddy = pcall(require, 'nvim-navbuddy')
		if navbuddy_ok then navbuddy.attach(client, bufnr) end
	end

	-- keymap('n', 'K', vim.lsp.buf.hover)
	keymap('n', 'K', ':Lspsaga hover_doc<CR>')

	-- Diagnostic jump
	keymap('n', '[e', ':Lspsaga diagnostic_jump_prev<CR>')
	keymap('n', ']e', ':Lspsaga diagnostic_jump_next<CR>')

	-- Diagnostic jump with filters such as only jumping to an error
	keymap('n', '[E', ":lua require('lspsaga.diagnostic').goto_prev({ severity = 1 })<CR>")
	keymap('n', ']E', ":lua require('lspsaga.diagnostic').goto_next({ severity = 1 })<CR>")

	keymap('n', '<leader>sd', ':Telescope diagnostics<CR>', { desc = '[S]earch [D]iagnostics' })
	keymap('n', 'gf', ':Telescope lsp_references<CR>', { desc = '[S]earch [R]eferences' })

	--  ╾───────────────────────────────────────────────────────────────────────────────────╼
	keymap('n', 'gr', ':Lspsaga rename<CR>')
	keymap('n', 'gp', function() require('goto-preview').goto_preview_definition({}) end)
	keymap('n', 'gf', ':Lspsaga finder<CR>')
	--  ╾───────────────────────────────────────────────────────────────────────────────────╼
	keymap('n', 'gd', ':Lspsaga goto_definition<CR>')
	keymap('n', 'gD', ':tab split | Lspsaga goto_definition<CR>') -- Abre a definição em um novo buffer
	keymap('n', 'gV', ':vsplit<CR><C-w>L:Lspsaga goto_definition<CR>') -- Abre a definição em um novo buffer na vertical
	--  ╾───────────────────────────────────────────────────────────────────────────────────╼
	keymap('n', '<leader>ca', ':Lspsaga code_action<CR>') -- Code action
	keymap('n', 'gl', ':Lspsaga show_line_diagnostics<CR>') -- Show line diagnostics
end

function M.get_commom_configs()
	return {
		on_attach = M.common_on_attach,
		capabilities = M.client_capabilities(),
	}
end

function M.get_configs_for(server_name)
	local config = M.get_commom_configs()

	local has_custom_config, ls_configs = pcall(require, 'lsp.servers.' .. server_name)

	if has_custom_config then
		config = vim.tbl_deep_extend('force', config, ls_configs) -- adicioar configurações personalizadas
	end

	return config
end

-- function M.setup()
-- 	-- vim.lsp.set_log_level('off')
-- 	require('lspconfig.ui.windows').default_options.border = 'single' -- coloca borda no :LspInfo
--
-- 	-- Setup handlers
-- 	require('lsp.handlers').setup()
--
-- 	local lspconfig = require('lspconfig')
-- 	local configs = require('lspconfig.configs')
--
-- 	-- 1. Registrar a configuração do servidor customizado (Se ainda não existir no nvim-lspconfig)
-- 	if not configs.trexx_ls then configs.trexx_ls = {
-- 		default_config = require('lsp.servers.trexx_ls').config,
-- 	} end
--
-- 	-- 2. Iterar e inicializar
-- 	for _, server in ipairs(M.servers) do
-- 		local config = M.get_configs_for(server)
--
-- 		-- Mantém sua lógica existente para os outros (se necessário)
-- 		vim.lsp.config[server] = vim.tbl_deep_extend('keep', config, vim.lsp.config[server] or {})
--
-- 		if server == 'trexx_ls' then lspconfig.trexx_ls.setup(config) end
-- 	end
--
-- 	vim.lsp.enable('cobol_ls')
--
-- 	U.api.augroup('cobol_ls activation', {
-- 		event = 'FileType',
-- 		pattern = 'cobol',
-- 		command = function()
-- 			vim.lsp.start(vim.lsp.config['cobol_ls']) --
-- 		end,
-- 	})
--
-- 	-- Diagnosticos
-- 	vim.diagnostic.config({
-- 		-- virtual_text = false,
-- 		virtual_text = { spacing = 4, prefix = '●', source = false },
-- 		signs = {
-- 			text = {
-- 				[vim.diagnostic.severity.ERROR] = U.icons.diagnostics.Error,
-- 				[vim.diagnostic.severity.WARN] = U.icons.diagnostics.Warning,
-- 				[vim.diagnostic.severity.HINT] = U.icons.diagnostics.Hint,
-- 				[vim.diagnostic.severity.INFO] = U.icons.diagnostics.Information,
-- 			},
-- 		},
-- 		underline = true,
-- 		update_in_insert = false,
-- 		severity_sort = true,
-- 	})
-- end

function M.setup()
	-- vim.lsp.set_log_level('off')
	require('lspconfig.ui.windows').default_options.border = 'single' -- coloca borda no :LspInfo

	-- Setup handlers
	require('lsp.handlers').setup()

	local lspconfig = require('lspconfig')
	local configs = require('lspconfig.configs')

	-- 1. Registrar a configuração do servidor customizado (Se ainda não existir no nvim-lspconfig)
	if not configs.trexx_ls then configs.trexx_ls = {
		default_config = require('lsp.servers.trexx_ls').config,
	} end

	-- 2. Iterar e inicializar
	for _, server in ipairs(M.servers) do
		local config = M.get_configs_for(server)

		-- Se for o nosso servidor customizado, FORÇA o setup aqui
		if server == 'trexx_ls' then lspconfig.trexx_ls.setup(config) end

		-- Mantém sua lógica existente para os outros (se necessário)
		vim.lsp.config[server] = vim.tbl_deep_extend('keep', config, vim.lsp.config[server] or {})
	end

  vim.lsp.enable('cobol_ls')

	-- Diagnosticos
	vim.diagnostic.config({
		-- virtual_text = false,
		virtual_text = { spacing = 4, prefix = '●', source = false },
		signs = {
			text = {
				[vim.diagnostic.severity.ERROR] = U.icons.diagnostics.Error,
				[vim.diagnostic.severity.WARN] = U.icons.diagnostics.Warning,
				[vim.diagnostic.severity.HINT] = U.icons.diagnostics.Hint,
				[vim.diagnostic.severity.INFO] = U.icons.diagnostics.Information,
			},
		},
		underline = true,
		update_in_insert = false,
		severity_sort = true,
	})
end

return M
