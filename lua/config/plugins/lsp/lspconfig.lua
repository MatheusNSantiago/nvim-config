local M = {}

function M.setup()
	return {
		"neovim/nvim-lspconfig",
		config = M.config,
	}
end

function M.config()
	local neodev = require("neodev")
	local lspconfig = require("lspconfig")
	local lsp = require("config.lsp")

	neodev.setup() -- IMPORTANT: make sure to setup neodev BEFORE lspconfig
	--
	-- for _, server in ipairs(lsp.servers) do
	-- 	local config = lsp.default_config
	--
	-- 	-- Adicionar as configurações personalizadas
	-- 	local has_custom_config, ls_configs = pcall(require, "config.lsp.servers." .. server)
	-- 	if has_custom_config then
	-- 		config = vim.tbl_extend("force", config, ls_configs)
	-- 	end
	--
	-- 	lspconfig[server].setup(config)
	-- end

	-- It enables tsserver automatically so no need to call lspconfig.tsserver.setup
	-- require("typescript").setup({
	-- 	disable_commands = false, -- prevent the plugin from creating Vim commands
	-- 	debug = false, -- enable debug logging for commands
	-- 	-- LSP Config options
	-- 	server = {
	-- 		capabilities = require("config.lsp.servers.tsserver").capabilities,
	-- 		handlers = require("config.lsp.servers.tsserver").handlers,
	-- 		on_attach = require("config.lsp.servers.tsserver").on_attach,
	-- 		settings = require("config.lsp.servers.tsserver").settings,
	-- 	},
	-- })

	--   lspconfig.tailwindcss.setup({
	--     capabilities = require("lsp.servers.tailwindcss").capabilities,
	--     filetypes = require("lsp.servers.tailwindcss").filetypes,
	--     handlers = defaut_handlers,
	--     init_options = require("lsp.servers.tailwindcss").init_options,
	--     on_attach = require("lsp.servers.tailwindcss").on_attach,
	--     settings = require("lsp.servers.tailwindcss").settings,
	--   })

	--   lspconfig.pyright.setup({
	--     capabilities = default_capabilities,
	--     handlers = defaut_handlers,
	--     on_attach = default_on_attach,
	--     settings = require("lsp.servers.pyright").settings,
	--   })

	--   lspconfig.cssls.setup({
	--     capabilities = default_capabilities,
	--     handlers = defaut_handlers,
	--     on_attach = require("lsp.servers.cssls").on_attach,
	--     settings = require("lsp.servers.cssls").settings,
	--   })

	--   lspconfig.eslint.setup({
	--     capabilities = default_capabilities,
	--     handlers = defaut_handlers,
	--     on_attach = require("lsp.servers.eslint").on_attach,
	--     settings = require("lsp.servers.eslint").settings,
	--   })

	--   lspconfig.jsonls.setup({
	--     capabilities = default_capabilities,
	--     handlers = defaut_handlers,
	--     on_attach = default_on_attach,
	--     settings = require("lsp.servers.jsonls").settings,
	--   })

	  -- lspconfig.lua_ls.setup({
	    -- capabilities = default_capabilities,
	    -- handlers = defaut_handlers,
	    -- on_attach = default_on_attach,
	    -- settings = require("config.lsp.servers.lua_ls").settings,
	  -- })

	--   lspconfig.vuels.setup({
	--     filetypes = require("lsp.servers.vuels").filetypes,
	--     handlers = defaut_handlers,
	--     init_options = require("lsp.servers.vuels").init_options,
	--     on_attach = default_on_attach,
	--   })
end

return M
