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
	'jdtls',
	'cobol_ls',
	'dart_ls',
	'pyright',
	'typescript-tools',
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
			textDocument = {
				foldingRange = { dynamicRegistration = true, lineFoldingOnly = true },
			},
		}
	)
end

---Sets up LSP keymaps and autocommands for the given buffer.
---@param client lsp.Client
---@param bufnr integer
---@param disable_navic? boolean
function M.common_on_attach(client, bufnr, disable_navic)
	local caps = client.server_capabilities

	-- Enable completion triggered by <C-X><C-O>
	if caps.completionProvider then vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc' end

	-- Use LSP as the handler for formatexpr.
	if caps.documentFormattingProvider then vim.bo[bufnr].formatexpr = 'v:lua.vim.lsp.formatexpr()' end

	if not disable_navic then
		-- setup navic (breadcrumbs) e outros simbolos
		require('lsp.utils').setup_document_symbols(client, bufnr)

		-- Setup nav buddy
		local navbuddy_ok, navbuddy = pcall(require, 'nvim-navbuddy')
		if navbuddy_ok then navbuddy.attach(client, bufnr) end
	end

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
	keymap('n', 'gf', ':Lspsaga finder<CR>')

	keymap('n', 'gd', ':Lspsaga goto_definition<CR>')
	keymap('n', 'gD', ':tab split | Lspsaga goto_definition<CR>')           -- Abre a definição em um novo buffer
	keymap('n', 'gV', ':vsplit<CR><C-w>w<C-w>L:Lspsaga goto_definition<CR>') -- Abre a definição em um novo buffer na vertical
	keymap('n', '<leader>ca', ':Lspsaga code_action<CR>')                   -- Code action
	keymap('n', 'gl', ':Lspsaga show_line_diagnostics<CR>')                 -- Show line diagnostics
end

function M.get_commom_configs()
	return {
		on_attach = M.common_on_attach,
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
	require('lspconfig.ui.windows').default_options.border = 'single'
	vim.lsp.set_log_level('off')

	local diagnostics = utils.icons.diagnostics

	-- Define Signs
	local signs = {
		{ name = 'DiagnosticSignError', text = diagnostics.Error },
		{ name = 'DiagnosticSignWarn',  text = diagnostics.Warning },
		{ name = 'DiagnosticSignHint',  text = diagnostics.Hint },
		{ name = 'DiagnosticSignInfo',  text = diagnostics.Information },
	}

	for _, sign in ipairs(signs) do
		vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
	end

	-- Diagnostic configuration
	vim.diagnostic.config({
		virtual_text = true,
		-- virtual_text = { spacing = 4, prefix = "●" },
		-- virtual_text = { severity = { min = vim.diagnostic.severity.ERROR } },
		signs = { active = signs },
		underline = true,
		update_in_insert = false,
		severity_sort = true,
		float = {
			focusable = true,
			style = 'minimal',
			border = 'rounded',
			source = 'always',
			header = '',
			prefix = '',
			format = function(d)
				local code = d.code or (d.user_data and d.user_data.lsp.code)
				if code then return string.format('%s [%s]', d.message, code):gsub('1. ', '') end
				return d.message
			end,
		},
	})

	-- define handlers
	local float = { focusable = true, style = 'minimal', border = 'rounded' }

	vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, float)
	vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, float)
end

M.utils = require('lsp.utils')

return M
