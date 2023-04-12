local M = {}

M.servers = {
	"bashls",
	"cssls",
	"yamlls",
	"eslint",
	-- "dartls",
	"eslint",
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

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.foldingRange = { dynamicRegistration = false, lineFoldingOnly = true } -- folding
capabilities.textDocument.completion.completionItem.resolveSupport = {
	properties = { "documentation", "detail", "additionalTextEdits" },
}

local cmp_nvim_lsp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if cmp_nvim_lsp_ok then
	M.capabilities = cmp_nvim_lsp.default_capabilities(capabilities) -- for nvim-cmp
else
	M.capabilities = capabilities
end

local function on_attach(client, bufnr)
	local caps = client.server_capabilities

	-- Enable completion triggered by <C-X><C-O>
	-- See `:help omnifunc` and `:help ins-completion` for more information.
	if caps.completionProvider then
		vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
	end
	-- Use LSP as the handler for formatexpr.
	-- See `:help formatexpr` for more information.
	if caps.documentFormattingProvider then
		vim.bo[bufnr].formatexpr = "v:lua.vim.lsp.formatexpr()"
	end

	-- sqls
	if client.name == "sqls" then
		require("sqls").on_attach(client, bufnr)
	end

	-- Configure for jdtls
	if client.name == "jdt.ls" then
		require("jdtls").setup_dap({ hotcodereplace = "auto" })
		require("jdtls.dap").setup_dap_main_class_configs()
		vim.lsp.codelens.refresh()
	end

end

M.default_config = {
	handlers = {
		["textDocument/hover"] = require("plugins.lsp.functions").custom_hover_handler,
		["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
		["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
			severity_sort = true,
			underline = true,
			update_in_insert = false,
			virtual_text = { spacing = 4, prefix = "●" },
		}),
	},
	on_attach = on_attach,
	capabilities = M.capabilities,
	flags = {
		debounce_text_changes = 150,
	},
}

-- Setup LSP handlers
require("plugins.lsp.diagnostic_handlers").setup()

return M
