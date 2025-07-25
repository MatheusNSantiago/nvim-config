local M = {}
local keymap = utils.api.keymap

M.servers = {
	'cssls',
	'html',
	'angularls@17.0.0',
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
	'clangd',
	'rust-analyzer', -- inicializado pelo rustacean
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

function M.setup()
	-- vim.lsp.set_log_level('off')
	require('lspconfig.ui.windows').default_options.border = 'single' -- coloca borda no :LspInfo

	-- Setup handlers
	require('lsp.handlers').setup()

	for _, server in ipairs(M.servers) do
		local config = M.get_configs_for(server)
		vim.lsp.config[server] = vim.tbl_deep_extend('keep', config, vim.lsp.config[server] or {})
	end

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
