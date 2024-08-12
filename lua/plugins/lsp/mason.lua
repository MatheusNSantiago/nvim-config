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
		registries = {
			'github:nvim-java/mason-registry',
			'github:mason-org/mason-registry',
		},
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
			'rustywind',        -- tailwind formatter
			'debugpy',          -- python debugger
			'black',            -- python formatter
			'isort',            -- python formatter (imports)
			'stylua',           -- Lua formatter
			'yamlfmt',          -- yaml formatter
			'prettierd',        -- javascript formatter
			'cpplint',          -- c/c++ linter
			'clang-format',     -- c/c++ formatter
			'fixjson',          -- json
		},
		automatic_setup = true, -- Recommended, but optional
	})

	local custom_lsps = { 'dart_ls', 'cobol_ls', 'rust-analyzer' }
	local lsp_list = vim.tbl_filter(function(server)
		local is_custom_lsp = vim.tbl_contains(custom_lsps, server)
		return not is_custom_lsp
	end, lsp.servers)

	mason_lspconfig.setup({
		ensure_installed = lsp_list,
		automatic_installation = { exclude = custom_lsps },
	})

	local setup_lsp = function(server)
		local config = lsp.get_configs_for(server)
		lspconfig[server].setup(config)
	end

	mason_lspconfig.setup_handlers({
		function(server_name)
			setup_lsp(server_name) --
		end,
	})

	setup_lsp('cobol_ls')

	require('lspconfig.ui.windows').default_options.border = 'single'
end

return M
