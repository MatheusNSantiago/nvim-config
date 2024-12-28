local M = {}

function M.setup()
	return { ---@type LazyPluginSpec
		'williamboman/mason-lspconfig.nvim',
		config = M.config,
		event = { 'BufReadPre', 'BufNewFile' },
		dependencies = {
			'williamboman/mason.nvim',
		},
	}
end

-- REF (lsp-config): https://github.com/neovim/nvim-lspconfig/wiki
function M.config()
	local lspconfig = require('lspconfig')
	local mason_lspconfig = require('mason-lspconfig')
	local lsp = require('lsp')

	local custom_lsps = {
		'dart_ls',
		'rust-analyzer',
		-- 'cobol_ls',
	}
	local lsp_list = vim.tbl_filter(function(server)
		local is_custom_lsp = vim.tbl_contains(custom_lsps, server)
		return not is_custom_lsp
	end, lsp.servers)

	mason_lspconfig.setup({
		ensure_installed = lsp_list,
		automatic_installation = true,
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
	-- setup_lsp("cobol_ls")

	require('lspconfig.ui.windows').default_options.border = 'single'
end

return M
