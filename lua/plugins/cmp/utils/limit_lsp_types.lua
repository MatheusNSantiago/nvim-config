-- Limits LSP results to specific types based on line context (FIelds, Methods, Variables)
return function(entry, ctx)
	local deu_certo, res = utils.pcall(function()
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

		-- [(,{]\n█)
		if prev_line ~= nil then
			local prev_line_last_char = prev_line:sub(-1, -1)
			if
					prev_line_last_char:match('[({,]') -- { ou ( ou ,
					and (cur_line:match('^%s*%w*█'))
			then
				return (kind ~= 'Snippet')
			end
		end
		--  ╾───────────────────────────────────────────────────────────────────────────────────╼
		--- iterate each pattern and return false if cur_line matches
		local function line_matches_patterns(patterns)
			for _, pattern in ipairs(patterns) do
				if cur_line:match(pattern) then return true end
			end
		end

		if
				line_matches_patterns({
					':%s*█', -- { foo: █ }
					'.*%.%w*█', -- <object>.█ <- metodos/atributos
					[[['"]%w*█]], -- 'foo█' ou "foo█"
					'%(%w*█%w*%)', -- (foo█)
					'{%s*█', -- {█'
					'{.+,%s*█.*}?', -- {foo: bar, █ } | {foo: bar, █, baz: qux}
					'(.+,%s*█.*)?', -- (foo: bar, █ ) | (foo: bar, █, baz: qux)
				})
		then
			return (kind ~= 'Snippet')
		end

		if filetype == 'python' then
			if cur_line:match(':█$') then return false end -- def function():█
			if
					line_matches_patterns({
						'import%s█', -- from X import █
					})
			then
				return (kind ~= 'Snippet')
			end
		end

		return true
	end)
	if deu_certo then
		return res
	else
		return true
	end
end
