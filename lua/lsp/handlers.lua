local M = {}

M.setup = function()
	M.setup_virtual_text_handler()
	M.setup_lsp_handlers()
end


M.setup_lsp_handlers = function ()
	local float = { focusable = true, style = 'minimal', border = 'rounded' }

	vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, float)
	vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, float)
end

---@source https://github.com/lucasvianav/nvim/blob/8f763b85e2da9ebd4656bf732cbdd7410cc0e4e4/lua/v/settings/handlers.lua#L18-L48_
M.setup_virtual_text_handler = function()
	local ns = vim.api.nvim_create_namespace('virtual_text_diagnostics')
	local handler = vim.diagnostic.handlers.virtual_text

	vim.diagnostic.handlers.virtual_text = {
		show = function(_, bufnr, _, opts)
			local diagnostics = vim.diagnostic.get(bufnr)

			-- filter os "piores" diagnosticos por linha
			local most_severe = {}
			for _, cur in pairs(diagnostics) do
				local max = most_severe[cur.lnum]
				if not max or cur.severity < max.severity then most_severe[cur.lnum] = cur end
			end
			local worst_diagnostics = vim.tbl_values(most_severe)

			-- pass the filtered diagnostics (with the custom namespace) to the original handler
			handler.show(ns, bufnr, worst_diagnostics, opts)
		end,

		hide = function(_, bufnr) handler.hide(ns, bufnr) end,
	}

end

---@param diagnostics vim.Diagnostic[]
M._get_most_severe_diagnostic = function(diagnostics)
	local most_severe = nil

	for _, diagnostic in ipairs(diagnostics) do
		if not most_severe or diagnostic.severity < most_severe.severity then most_severe = diagnostic end
	end

	return most_severe
end

return M
