local M = {}
local keymap = utils.api.keymap

M.servers = {
	'cssls',
	'html',
	'angularls',
	'ts_ls',
	'jdtls',
	'tailwindcss',

	'jsonls',
	'yamlls',
	'dockerls',
	'lua_ls',
	'bashls',
	'cobol_ls',
	'dart_ls',
	'pyright',
	'clangd',
	'rust-analyzer', -- inicializado pelo rustacean
}

---editor's capabilities + some overrides.
M.client_capabilities = function()
	return vim.tbl_deep_extend(
		'force',
		vim.lsp.protocol.make_client_capabilities(),
		-- nvim-cmp supports additional completion capabilities, so broadcast that to servers.
		require('cmp_nvim_lsp').default_capabilities(),
		{
			textDocument = {
				foldingRange = { dynamicRegistration = true, lineFoldingOnly = true },
			},
		}
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

	keymap('n', 'K', vim.lsp.buf.hover)

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
	keymap('n', 'gp', ":lua require('goto-preview').goto_preview_definition()<CR>")
	-- keymap('n', 'gf', ':Lspsaga finder<CR>')
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
		on_attach = function(client, bufnr) M.common_on_attach(client, bufnr) end,
		capabilities = M.client_capabilities(),
		flags = { debounce_text_changes = 150 },
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
	-- vim.lsp.set_log_level('off')
	require('lspconfig.ui.windows').default_options.border = 'single' -- coloca borda no :LspInfo

	-- Setup handlers
	require('lsp.handlers').setup()

	-- Definir icones dos diagnósticos
	local icons = utils.icons.diagnostics
	local signs = {
		{ name = 'DiagnosticSignError', text = icons.Error },
		{ name = 'DiagnosticSignWarn', text = icons.Warning },
		{ name = 'DiagnosticSignHint', text = icons.Hint },
		{ name = 'DiagnosticSignInfo', text = icons.Information },
	}
	for _, sign in ipairs(signs) do
		vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
	end

	-- Diagnosticos
	vim.diagnostic.config({
		-- virtual_text = false,
		virtual_text = {
			spacing = 4,
			prefix = '●',
			source = false,
		},
		signs = { active = signs },
		underline = true,
		update_in_insert = false,
		severity_sort = true,
	})
end

return M
