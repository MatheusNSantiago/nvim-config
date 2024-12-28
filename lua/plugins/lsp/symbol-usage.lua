local M = {}

function M.setup()
	return {
		'Wansmer/symbol-usage.nvim',
		event = 'LspAttach', -- need run before LspAttach if you use nvim 0.9. On 0.10 use 'LspAttach'
		config = M.config,
	}
end

function M.config()
	local SymbolKind = vim.lsp.protocol.SymbolKind
	local default_opts = {
		---@type table<string, any> `nvim_set_hl`-like options for highlight virtual text
		hl = { link = 'Comment' },
		kinds = { SymbolKind.Function, SymbolKind.Method },
		---Additional filter for kinds. Recommended use in the filetypes override table.
		---fiterKind: function(data: { symbol:table, parent:table, bufnr:integer }): boolean
		---`symbol` and `parent` is an item from `textDocument/documentSymbol` request
		---See: #filter-kinds
		kinds_filter = {},
		---@type 'above'|'end_of_line'|'textwidth'
		vt_position = 'end_of_line',
		---Text to display when request is pending. If `false`, extmark will not be
		---created until the request is finished. Recommended to use with `above`
		---vt_position to avoid "jumping lines".
		---@type string|table|false
		request_pending_text = false,
		---@type function(symbol: Symbol): string
		text_format = function(symbol)
			vim.api.nvim_set_hl(0, 'SymbolUsageRounding', { fg = c.bg_highlight })
			vim.api.nvim_set_hl(0, 'SymbolUsageContent', { bg = c.bg_highlight, fg = c.gray })
			vim.api.nvim_set_hl(0, 'SymbolUsageRef', { fg = c.gray, bg = c.bg_highlight })

			local res = {}
			local number_of_references = symbol.references

			local round_start = { '', 'SymbolUsageRounding' }
			local round_end = { '', 'SymbolUsageRounding' }

			if number_of_references > 0 then
				table.insert(res, round_start)
				table.insert(res, { ' ', 'SymbolUsageRef' }) --
				table.insert(res, { tostring(number_of_references), 'SymbolUsageContent' })
				table.insert(res, round_end)
			end

			return res
		end,
		references = { enabled = true, include_declaration = false },
		definition = { enabled = false },
		implementation = { enabled = false },
		filetypes = {
			cobol = {
				kinds = {}, -- não exibir nada para cobol
			},
		},
	}

	require('symbol-usage').setup(default_opts)
end

return M
