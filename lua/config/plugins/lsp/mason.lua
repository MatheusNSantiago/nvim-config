local M = {}

function M.setup()
	return {
		"williamboman/mason.nvim",
		-- cmd = {
		-- "Mason",
		-- "MasonUpdate",
		-- "MasonInstall",
		-- "MasonUninstall",
		-- "MasonUninstallAll",
		-- "MasonLog",
		-- },
		run = ":MasonUpdate", -- updates registry contents
		config = M.config,
	}
end

function M.config()
	local mason = require("mason")
	local mason_lspconfig = require("mason-lspconfig")
	local lsp = require("config.lsp")
	local mason_null_ls = require("mason-null-ls")
	-- local mason_tool_installer = require("mason-tool-installer")

	mason.setup({
		-- PATH = "prepend", -- "skip" seems to cause the spawning error
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
		-- automatic_installation = false,
		automatic_setup = true, -- Recommended, but optional
	})

	-- Instala third-party tools (que são baixados por fora)
	-- mason_tool_installer.setup({
	-- 	ensure_installed = {
	-- 		-- "codelldb",
	-- 		"stylua",
	-- 		"prettierd",
	-- 		"shfmt",
	-- 		"shellcheck",
	-- 	},
	-- 	auto_update = false,
	-- 	run_on_start = true,
	-- })

	mason_lspconfig.setup({
		-- A list of servers to automatically install if they're not already installed
		ensure_installed = vim.tbl_extend("force", lsp.servers, {
			-- "eslint_d",
		}),
		automatic_installation = true,
	})

	local lspconfig = require("lspconfig")

	mason_lspconfig.setup_handlers({
		function(server_name)
			local config = lsp.default_config

			-- Adicionar configurações personalizadas
			local has_custom_config, ls_configs = pcall(require, "config.lsp.servers." .. server_name)
			if has_custom_config then
				config = vim.tbl_extend("force", config, ls_configs)
			end

			lspconfig[server_name].setup(config)
		end,
	})
end

return M
