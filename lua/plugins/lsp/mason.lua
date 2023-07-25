local M = {}

function M.setup()
	return {
		'williamboman/mason.nvim',
		run = ':MasonUpdate', -- updates registry contents
		config = M.config,
	}
end

function M.config()
	local mason = require('mason')
	local lspconfig = require('lspconfig')
	local neodev = require('neodev')
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
			'ruff',       -- python linter
			'debugpy',    -- python debugger
			'black',      -- python formatter
			'yamlfmt',    -- yaml formatter
			'prettierd',  -- javascript formatter
			'cpplint',    -- c/c++ linter
			'clang-format', -- c/c++ formatter
		},
		automatic_setup = true, -- Recommended, but optional
	})

	mason_lspconfig.setup({
		ensure_installed = lsp.servers,
		automatic_installation = true,
	})

	neodev.setup({
		-- type checking, documentation and autocompletion for nvim-dap-ui
		library = { plugins = { 'nvim-dap-ui' }, types = true },
	}) -- IMPORTANT: make sure to setup neodev BEFORE lspconfig

	mason_lspconfig.setup_handlers({
		function(server_name)
			local config = lsp.get_configs_for(server_name)
			lspconfig[server_name].setup(config)
		end,
		-- Custom handlers
		['lua_ls'] = function()
			local config = lsp.get_configs_for('lua_ls')
			lspconfig['lua_ls'].setup(config)
		end,
		['tsserver'] = function()
			-- Está sendo feito pelo typescript-tools
			-- ver plugins/dev/typescript.lua
		end,
	})

	require('lspconfig.ui.windows').default_options.border = 'single'
end

return M
