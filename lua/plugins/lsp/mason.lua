local M = {}
-- REF (lsp-config): https://github.com/neovim/nvim-lspconfig/wiki

function M.setup()
	return {
		'williamboman/mason.nvim',
		build = ':MasonUpdate', -- updates registry contents
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

	mason_lspconfig.setup({
		ensure_installed = lsp.servers,
		automatic_installation = true,
	})

	local neodev_ok, neodev = pcall(require, 'neodev')
	if neodev_ok then
		neodev.setup({
			-- type checking, documentation and autocompletion for nvim-dap-ui
			library = { plugins = { 'nvim-dap-ui' }, types = true },
		}) -- IMPORTANT: make sure to setup neodev BEFORE lspconfig
	end

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
			local config = require('lsp').get_configs_for('tsserver')

			require('typescript').setup({
				disable_commands = false, -- prevent the plugin from creating Vim commands
				debug = false,        -- enable debug logging for commands
				go_to_source_definition = {
					fallback = true,    -- fall back to standard LSP definition on failure
				},
				server = config,
			})
		end,
	})

	require('lspconfig.ui.windows').default_options.border = 'single'
end

return M
