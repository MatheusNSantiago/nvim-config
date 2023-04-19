local M = {}

M.servers = {
	"bashls",
	"cssls",
	"yamlls",
	"dockerls",
	"lua_ls",
	"pyright",
	"tsserver",
	"html",
	"tailwindcss",
	"jsonls",
}

function M.common_capabilities()
	local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
	if status_ok then
		return cmp_nvim_lsp.default_capabilities()
	end

	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities.textDocument.completion.completionItem.snippetSupport = true
	capabilities.textDocument.foldingRange = { dynamicRegistration = false, lineFoldingOnly = true } -- folding
	capabilities.textDocument.completion.completionItem.resolveSupport = {
		properties = {
			"documentation",
			"detail",
			"additionalTextEdits",
		},
	}
	return capabilities
end

function M.common_on_attach(client, bufnr)
	local caps = client.server_capabilities
	local utils = require("lsp.utils")

	-- Enable completion triggered by <C-X><C-O>
	if caps.completionProvider then
		vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
	end

	-- Use LSP as the handler for formatexpr.
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

	-- setup navic (breadcrumbs) e outros simbolos
	utils.setup_document_symbols(client, bufnr)

	local navbuddy_ok, navbuddy = pcall(require, "nvim-navbuddy")
	if navbuddy_ok then
		navbuddy.attach(client, bufnr)
	end
end

function M.get_commom_configs()
	return {
		handlers = {
			["textDocument/hover"] = require("lsp.functions").custom_hover_handler,
			["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
			-- ["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
			-- 	severity_sort = true,
			-- 	underline = true,
			-- 	update_in_insert = false,
			-- 	virtual_text = { spacing = 4, prefix = "●" },
			-- }),
		},
		on_attach = M.common_on_attach,
		-- on_init = M.common_on_init,
		-- on_exit = M.common_on_exit,
		capabilities = M.common_capabilities(),
	}
end

function M.setup()
	local lsp_status_ok, _ = pcall(require, "lspconfig")
	if not lsp_status_ok then
		return
	end

	require("lsp.handlers").setup() -- Setup LSP handlers
end

return M
