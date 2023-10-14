local M = {}
local keymap = utils.api.keymap

M.servers = {
	'bashls',
	'cssls',
	'yamlls',
	'dockerls',
	'html',
	'jsonls',
	'lua_ls',
	'cobol_ls',
	'dart_ls',
	'pyright',
	'tsserver',
	'tailwindcss',
	'clangd',
}

---editor's capabilities + some overrides.
M.client_capabilities = function()
	return vim.tbl_deep_extend(
		'force',
		vim.lsp.protocol.make_client_capabilities(),
		-- nvim-cmp supports additional completion capabilities, so broadcast that to servers.
		require('cmp_nvim_lsp').default_capabilities(),
		{
			workspace = {
				-- PERF: didChangeWatchedFiles is too slow.
				-- TODO: Remove this when https://github.com/neovim/neovim/issues/23291#issuecomment-1686709265 is fixed.
				didChangeWatchedFiles = { dynamicRegistration = false },
			},
		},
		{
			textDocument = {
				foldingRange = { dynamicRegistration = false, lineFoldingOnly = true }, -- Enable folding.
			},
		}
	)
end

---Sets up LSP keymaps and autocommands for the given buffer.
---@param client lsp.Client
---@param bufnr integer
function M.common_on_attach(client, bufnr)
	local caps = client.server_capabilities

	-- Enable completion triggered by <C-X><C-O>
	if caps.completionProvider then vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc' end

	-- Use LSP as the handler for formatexpr.
	if caps.documentFormattingProvider then vim.bo[bufnr].formatexpr = 'v:lua.vim.lsp.formatexpr()' end

	-- setup navic (breadcrumbs) e outros simbolos
	require('lsp.utils').setup_document_symbols(client, bufnr)

	-- Setup nav buddy
	local navbuddy_ok, navbuddy = pcall(require, 'nvim-navbuddy')
	if navbuddy_ok then navbuddy.attach(client, bufnr) end

	keymap('n', 'K', ':Lspsaga hover_doc<CR>')
	-- keymap('n', 'K', require('plugins.ui.pretty-hover.init').hover)

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
	keymap('n', 'gf', ':Lspsaga lsp_finder<CR>')

	keymap('n', 'gd', ':Lspsaga goto_definition<CR>')
	keymap('n', 'gD', ':tab split | Lspsaga goto_definition<CR>')           -- Abre a definição em um novo buffer
	keymap('n', 'gV', ':vsplit<CR><C-w>w<C-w>L:Lspsaga goto_definition<CR>') -- Abre a definição em um novo buffer na vertical
	keymap('n', '<leader>ca', ':Lspsaga code_action<CR>')                   -- Code action
	keymap('n', 'gl', ':Lspsaga show_line_diagnostics<CR>')                 -- Show line diagnostics
end

function M.get_commom_configs()
	return {
		on_attach = M.common_on_attach,
		-- on_init = M.common_on_init,
		-- on_exit = M.common_on_exit,
		capabilities = M.client_capabilities(),
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
	local lsp_status_ok, lspconfig = pcall(require, 'lspconfig')
	if not lsp_status_ok then return end

	local neodev_ok, neodev = pcall(require, 'neodev')                        -- nvim-dap-ui type checking/docs/autocompletion
	if neodev_ok then
		neodev.setup({ library = { plugins = { 'nvim-dap-ui' }, types = true } }) -- Atenção: setup neodev BEFORE lspconfig
	end

	for _, server in ipairs(M.servers) do
		local config = M.get_configs_for(server)

		local is_server_special = vim.tbl_contains({ 'dart_ls', 'tsserver' }, server)
		if not is_server_special then
			lspconfig[server].setup(config) --
		end
	end

	require('lspconfig.ui.windows').default_options.border = 'single'
	require('lsp.handlers').setup() -- Setup LSP handlers
end

return M
