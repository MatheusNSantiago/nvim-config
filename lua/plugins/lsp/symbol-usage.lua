local M = {}

function M.setup()
	return {
		'Wansmer/symbol-usage.nvim',
		event = 'LspAttach',
		config = M.config,
	}
end

function M.config()
	local SymbolKind = vim.lsp.protocol.SymbolKind

	local default_opts = {
		hl = { link = 'Comment' },
		kinds = { SymbolKind.Function, SymbolKind.Method },
		kinds_filter = {},
		vt_position = 'end_of_line',
		request_pending_text = false,
		text_format = function(symbol)
			vim.api.nvim_set_hl(0, 'SymbolUsageRounding', { fg = c.bg_highlight })
			vim.api.nvim_set_hl(0, 'SymbolUsageContent', { bg = c.bg_highlight, fg = c.gray })
			vim.api.nvim_set_hl(0, 'SymbolUsageRef', { fg = c.gray, bg = c.bg_highlight })

			local res = {}
			local number_of_references = symbol.references

			local round_start = { '', 'SymbolUsageRounding' }
			local round_end = { '', 'SymbolUsageRounding' }

			if number_of_references > 0 then
				table.insert(res, round_start)
				table.insert(res, { ' ', 'SymbolUsageRef' })
				table.insert(res, { tostring(number_of_references), 'SymbolUsageContent' })
				table.insert(res, round_end)
			end

			return res
		end,
		references = { enabled = true, include_declaration = false },
		definition = { enabled = false },
		implementation = { enabled = false },
		disable = {
			cond = {
				function(bufnr) return M._is_large_python_project(bufnr, 100) end,
			},
		},
		filetypes = {
			cobol = {
				kinds = {},
			},
		},
	}

	require('symbol-usage').setup(default_opts)
end

-- Cache para não recontar arquivos a cada buffer
local _project_size_cache = {}

--- Verifica se o projeto Python é grande demais para o symbol-usage.
--- O plugin dispara N requests `textDocument/references` ao Pyright por símbolo visível,
--- o que trava o LSP em projetos grandes. Resultado cacheado por root dir.
---@param bufnr integer
---@param threshold? integer Número máximo de arquivos .py (default: 100)
---@return boolean
function M._is_large_python_project(bufnr, threshold)
	threshold = threshold or 100
	if vim.bo[bufnr].filetype ~= 'python' then return false end

	local root = vim.fn.getcwd()
	if _project_size_cache[root] ~= nil then return _project_size_cache[root] end

	local cmd = 'find '
		.. vim.fn.shellescape(root)
		.. ' -name "*.py"'
		.. ' -not -path "*/.venv/*"'
		.. ' -not -path "*/__pycache__/*"'
		.. ' -not -path "*/node_modules/*"'
		.. ' | head -'
		.. (threshold + 1)
	local result = vim.fn.systemlist(cmd)
	local is_large = #result > threshold
	_project_size_cache[root] = is_large
	return is_large
end

return M
