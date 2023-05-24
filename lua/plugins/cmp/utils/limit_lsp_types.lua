-- Limits LSP results to specific types based on line context (FIelds, Methods, Variables)
return function(entry, ctx)
	local deu_certo, res = pcall(function()
		local kind = require('cmp.types.lsp').CompletionItemKind[entry:get_kind()]
		local filetype = vim.api.nvim_buf_get_option(0, 'filetype')

		local col = vim.api.nvim_win_get_cursor(0)[2]
		local line = vim.api.nvim_win_get_cursor(0)[1]
		local prev_line = vim.api.nvim_buf_get_lines(0, line - 2, line - 1, false)[1]
		local cur_line = vim.api.nvim_get_current_line()
		-- O cursor fica uma posição a frente do que realmente está
		-- para pegar o char na posição do cursor verdadeiro, é preciso subtrair 1
		cur_line = cur_line:sub(1, col) .. '█' .. cur_line:sub(col + 1)

		--  ╾───────────────────────────────────────────────────────────────────────────────────╼
		local function limitSnippetsIfLineMatches(pattern)
			if cur_line:match(pattern) then return (kind ~= 'Snippet') end
		end
		--  ╾───────────────────────────────────────────────────────────────────────────────────╼

		-- def function():█
		if (filetype == 'python') and cur_line:match(':█') then return false end

		limitSnippetsIfLineMatches(':%s*█') -- { foo: █ }

		limitSnippetsIfLineMatches('%.%w*█') -- <object>.█ <- metodos/atributos
		limitSnippetsIfLineMatches([[['"]%w*█]]) -- 'foo█' ou "foo█"
		limitSnippetsIfLineMatches('%(%w*█%w*%)') -- (foo█)
		limitSnippetsIfLineMatches('{%s*█') -- {█'
		limitSnippetsIfLineMatches('{.+,%s*█.*}') -- {foo: bar, █ } | {foo: bar, █, baz: qux}

		-- [(,{]\n█)
		local prev_line_last_char = prev_line:sub(-1, -1)
		if
			(cur_line:match('^%s*█'))
			and (prev_line_last_char == '(' or prev_line_last_char == ',' or prev_line_last_char == '{')
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
