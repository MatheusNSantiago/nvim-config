local M = {}

M.servers = {
	"bashls",
	"cssls",
	"yamlls",
	"eslint",
	-- "ansiblels",
	-- "dartls",
	-- "eslint",
	-- "marksman", -- markdown
	-- "prismals",
	"dockerls",
	"lua_ls",
	"pyright",
	"tsserver",
	"html",
	"tailwindcss",
	"jsonls",
}

M.default_config = {
	handlers = {
		["textDocument/hover"] = require("config.lsp.functions").custom_hover_handler,
		["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
		["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
			severity_sort = true,
			underline = true,
			update_in_insert = false,
			virtual_text = { spacing = 4, prefix = "●" },
		}),
	},
	on_attach = function(client, bufnr) end,
	capabilities = require("cmp_nvim_lsp").default_capabilities(),
}

return M
