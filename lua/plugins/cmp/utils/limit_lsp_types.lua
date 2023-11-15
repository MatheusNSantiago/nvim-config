-- Limits LSP results to specific types based on line context (FIelds, Methods, Variables)
return function(entry, ctx)
	local deu_certo, res = utils.pcall(function()
		local kind = require('cmp.types.lsp').CompletionItemKind[entry:get_kind()]
		local filetype = vim.api.nvim_buf_get_option(0, 'filetype')

		local lnum = vim.fn.line('.')
		local prev_line = vim.fn.getline(lnum - 1)

		local cur_line = utils.get_current_line_with_cursor()

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
