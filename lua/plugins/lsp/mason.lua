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
	local lsp = require("lsp")
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
			"ruff",
			-- Opt to list sources here, when available in mason.
		},
		automatic_setup = true, -- Recommended, but optional
	})

	mason_lspconfig.setup({
		ensure_installed = lsp.servers,
		automatic_installation = true,
	})

	local function get_configs(server_name)
		local config = lsp.get_commom_configs()

		local has_custom_config, ls_configs = pcall(require, "lsp.servers." .. server_name)
		if has_custom_config then
			config = vim.tbl_extend("force", config, ls_configs) -- adicioar configurações personalizadas
		end
		return config
	end

	mason_lspconfig.setup_handlers({
		function(server_name)
			local config = get_configs(server_name)
			lspconfig[server_name].setup(config)
		end,
		-- Custom handlers
		["lua_ls"] = function()
			neodev.setup() -- IMPORTANT: make sure to setup neodev BEFORE lspconfig
			local config = get_configs("lua_ls")
			lspconfig["lua_ls"].setup(config)
		end,
		["tsserver"] = function()
			require("typescript").setup({
				disable_commands = false,
				debug = false,
				server = get_configs("tsserver"),
			})
		end,
	})

	require("lspconfig.ui.windows").default_options.border = "single"
end

return M
