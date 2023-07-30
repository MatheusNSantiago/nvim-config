local M = {}
local keymap = utils.api.keymap
local severity = vim.diagnostic.severity

M.servers = {
	'bashls',
	'cssls',
	'yamlls',
	'dockerls',
	'html',
	'jsonls',
	'lua_ls',
	'pyright',
	'tsserver',
	'tailwindcss',
	'clangd',
}

function M.commom_keymaps()
	local telescope_ok, _ = utils.pcall(require, 'telescope')
	local lspsaga_ok, _ = utils.pcall(require, 'lspsaga')

	if not (telescope_ok and lspsaga_ok) then return end

	local b = require('telescope.builtin')
	local saga_diagnostic = require('lspsaga.diagnostic')
	-- keymap('n', 'K', ':Lspsaga hover_doc<CR>')
	keymap('n', 'K', require("plugins.ui.pretty-hover.init").hover)

	-- Diagnostic jump
	keymap('n', '[e', ':Lspsaga diagnostic_jump_prev<CR>')
	keymap('n', ']e', ':Lspsaga diagnostic_jump_next<CR>')

	-- Diagnostic jump with filters such as only jumping to an error
	keymap('n', '[E', function() saga_diagnostic.goto_prev({ severity = severity.ERROR }) end)
	keymap('n', ']E', function() saga_diagnostic.goto_next({ severity = severity.ERROR }) end)

	keymap('n', '<leader>sd', b.diagnostics, { desc = '[S]earch [D]iagnostics' })
	keymap('n', '<leader>sR', b.lsp_references, { desc = '[S]earch [R]eferences' })
	keymap('n', '<leader>si', b.lsp_implementations, { desc = '[S]earch [I]mplementations' })

	keymap('n', 'gr', ':Lspsaga rename<CR>')
	keymap('n', 'gp', ':Lspsaga peek_definition<CR>')
	keymap('n', 'gf', ':Lspsaga lsp_finder<CR>')

	keymap('n', 'gd', ':Lspsaga goto_definition<CR>')
	keymap('n', 'gD', ':tab split | Lspsaga goto_definition<CR>')     -- Abre a definição em um novo buffer
	keymap('n', 'gV', ':vsplit<CR><C-w>w:Lspsaga goto_definition<CR>') -- Abre a definição em um novo buffer na vertical
	keymap('n', '<leader>ca', ':Lspsaga code_action<CR>')             -- Code action
	keymap('n', 'gl', ':Lspsaga show_line_diagnostics<CR>')           -- Show line diagnostics
end

function M.common_capabilities()
	local cmp_lsp = require('cmp_nvim_lsp')
	local capabilities = vim.lsp.protocol.make_client_capabilities()

	capabilities.textDocument.completion.completionItem.snippetSupport = true
	capabilities.textDocument.completion.completionItem.resolveSupport = {
		properties = { 'documentation', 'detail', 'additionalTextEdits' },
	}
	return vim.tbl_deep_extend('force', capabilities, cmp_lsp.default_capabilities())
end

function M.common_on_attach(client, bufnr)
	local caps = client.server_capabilities

	-- Enable completion triggered by <C-X><C-O>
	if caps.completionProvider then vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc' end

	-- Use LSP as the handler for formatexpr.
	if caps.documentFormattingProvider then vim.bo[bufnr].formatexpr = 'v:lua.vim.lsp.formatexpr()' end

	-- sqls
	if client.name == 'sqls' then require('sqls').on_attach(client, bufnr) end

	-- Configure for jdtls
	if client.name == 'jdt.ls' then
		require('jdtls').setup_dap({ hotcodereplace = 'auto' })
		require('jdtls.dap').setup_dap_main_class_configs()
		vim.lsp.codelens.refresh()
	end

	-- setup navic (breadcrumbs) e outros simbolos
	require('lsp.utils').setup_document_symbols(client, bufnr)

	-- Setup nav buddy
	local navbuddy_ok, navbuddy = pcall(require, 'nvim-navbuddy')
	if navbuddy_ok then navbuddy.attach(client, bufnr) end

	M.commom_keymaps()
end

function M.get_commom_configs()
	return {
		handlers = {
			-- ['textDocument/hover'] = require('lsp.functions').custom_hover_handler,
			['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'rounded' }),
		},
		on_attach = M.common_on_attach,
		-- on_init = M.common_on_init,
		-- on_exit = M.common_on_exit,
		capabilities = M.common_capabilities(),
		flags = {
			debounce_text_changes = 150,
		},
	}
end

function M.extend_commom_configs(config) return vim.tbl_deep_extend('force', config, M.get_commom_configs()) end

function M.get_configs_for(server_name)
	local config = M.get_commom_configs()

	local has_custom_config, ls_configs = pcall(require, 'lsp.servers.' .. server_name)
	if has_custom_config then
		config = vim.tbl_deep_extend('force', config, ls_configs) -- adicioar configurações personalizadas
	end

	return config
end

function M.setup()
	local lsp_status_ok, _ = pcall(require, 'lspconfig')
	if not lsp_status_ok then return end

	require('lsp.handlers').setup() -- Setup LSP handlers
end

return M
