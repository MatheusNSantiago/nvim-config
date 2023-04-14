local M = {}
local icons = require("utils.icons")

function M.setup()
	-- UI
	local signs = {
		{ name = "DiagnosticSignError", text = icons.diagnostics.Error },
		{ name = "DiagnosticSignWarn",  text = icons.diagnostics.Warning },
		{ name = "DiagnosticSignHint",  text = icons.diagnostics.Hint },
		{ name = "DiagnosticSignInfo",  text = icons.diagnostics.Information },
	}
	for _, sign in ipairs(signs) do
		vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
	end

	-- LSP handlers configuration
	local config = {
		float = { focusable = true, style = "minimal", border = "rounded" },
		diagnostic = {
			virtual_text = true,
			-- virtual_text = { spacing = 4, prefix = "●" },
			-- virtual_text = { severity = { min = vim.diagnostic.severity.ERROR } },
			signs = { active = signs },
			underline = true,
			update_in_insert = false,
			severity_sort = true,
			float = {
				focusable = true,
				style = "minimal",
				border = "rounded",
				source = "always",
				header = "",
				prefix = "",
				format = function(d)
					local code = d.code or (d.user_data and d.user_data.lsp.code)
					if code then
						return string.format("%s [%s]", d.message, code):gsub("1. ", "")
					end
					return d.message
				end,
			},
		},
	}

	-- Diagnostic configuration
	vim.diagnostic.config(config.diagnostic)

	-- Hover configuration
	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, config.float)

	-- Signature help configuration
	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, config.float)
end

return M
