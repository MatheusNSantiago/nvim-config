-- Limits LSP results to specific types based on line context (FIelds, Methods, Variables)
return function(entry, ctx)
	local deu_certo, res = pcall(function()
		local kind = require('cmp.types.lsp').CompletionItemKind[entry:get_kind()]

		local col = vim.api.nvim_win_get_cursor(0)[2]
		local line = vim.api.nvim_win_get_cursor(0)[1]
		local prev_line = vim.api.nvim_buf_get_lines(0, line - 2, line - 1, false)[1]
		local cur_line = vim.api.nvim_get_current_line()

		local char_before = cur_line:sub(col - 1, col - 1)
		local char = cur_line:sub(col, col)
		local char_after = cur_line:sub(col + 1, col + 1)

		local prev_line_last_char = prev_line:sub(-1, -1)

		-- Evita que mostre autocomplete no final de funções do python
		if char == ':' and char_after == '' then return false end

		if char == '.' then return (kind ~= 'Snippet') end


		if
			char_before == '\t' and (prev_line_last_char == '(' or prev_line_last_char == ',' or prev_line_last_char == '{')
		then
			return (kind ~= 'Snippet')
		end

		return true
	end)
	if deu_certo then
		return res
	else
		return true
	end
end
