local M = {}
-- REF (lsp-config): https://github.com/neovim/nvim-lspconfig/wiki

function M.setup()
	return {
		'williamboman/mason.nvim',
		build = ':MasonUpdate', -- updates registry contents
		enabled = not utils.is_os_running_on_wsl(),
		config = M.config,
	}
end

function M.config()
	local mason = require('mason')
	local lspconfig = require('lspconfig')
	local mason_lspconfig = require('mason-lspconfig')
	local lsp = require('lsp')
	local mason_null_ls = require('mason-null-ls')

	mason.setup({
		ui = {
			border = 'rounded',
			icons = {
				package_installed = '✓',
				package_uninstalled = '✗',
				package_pending = '⟳',
			},
		},
	})

	mason_null_ls.setup({
		ensure_installed = {
			'ruff',             -- python linter
			'debugpy',          -- python debugger
			'black',            -- python formatter
			'yamlfmt',          -- yaml formatter
			'prettierd',        -- javascript formatter
			'cpplint',          -- c/c++ linter
			'clang-format',     -- c/c++ formatter
			'fixjson',          -- json
		},
		automatic_setup = true, -- Recommended, but optional
	})

	local lsp_list = vim.tbl_filter(function(server)
		local custom_lsps = { 'tsserver', 'dart_ls', 'cobol_ls' }
		local is_custom_lsp = vim.tbl_contains(custom_lsps, server)
		return not is_custom_lsp
	end, lsp.servers)

	mason_lspconfig.setup({
		ensure_installed = lsp_list,
		automatic_installation = true,
	})

	local neodev_ok, neodev = pcall(require, 'neodev')
	if neodev_ok then
		neodev.setup({
			-- type checking, documentation and autocompletion for nvim-dap-ui
			library = { plugins = { 'nvim-dap-ui' }, types = true },
		}) -- IMPORTANT: make sure to setup neodev BEFORE lspconfig
	end

	for _, server in ipairs(lsp_list) do
		local config = lsp.get_configs_for(server)
		lspconfig[server].setup(config)
	end

	-- local cobol_cfg = lsp.get_configs_for('cobol_ls')
	-- lspconfig['cobol_ls'].setup(cobol_cfg)

	require('lspconfig.ui.windows').default_options.border = 'single'
end

return M
