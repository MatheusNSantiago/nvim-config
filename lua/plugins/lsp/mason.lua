local M = {}

function M.setup()
	return {
		"williamboman/mason.nvim",
		run = ":MasonUpdate", -- updates registry contents
		config = M.config,
	}
end

function M.config()
	local mason = require("mason")
	local lspconfig = require("lspconfig")
	local neodev = require("neodev")
	local mason_lspconfig = require("mason-lspconfig")
	local lsp = require("plugins.lsp")
	local mason_null_ls = require("mason-null-ls")

	mason.setup({
		ui = {
			border = "rounded",
			icons = {
				package_installed = "✓",
				package_uninstalled = "✗",
				package_pending = "⟳",
			},
		},
	})

	mason_null_ls.setup({
		ensure_installed = {
			-- Opt to list sources here, when available in mason.
		},
		automatic_setup = true, -- Recommended, but optional
	})

	mason_lspconfig.setup({
		ensure_installed = lsp.servers,
		automatic_installation = true,
	})

	local function install_lsp(server_name)
		local config = lsp.default_config

		local has_custom_config, ls_configs = pcall(require, "plugins.lsp.servers." .. server_name)
		if has_custom_config then
			config = vim.tbl_extend("force", config, ls_configs) -- adicioar configurações personalizadas
		end

		lspconfig[server_name].setup(config)
	end

	mason_lspconfig.setup_handlers({
		install_lsp, -- Default handler
		-- Custom handlers
		["lua_ls"] = function()
			neodev.setup() -- IMPORTANT: make sure to setup neodev BEFORE lspconfig
			install_lsp("lua_ls")
		end,
	})
end

return M
