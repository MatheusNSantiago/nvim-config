---@class LspTypeLimiter
---@field kind string
---@field cur_line string

---@param entry blink.cmp.CompletionItem
---@param ctx blink.cmp.Context
---@return boolean
return function(entry, ctx)
		local kind = entry.kind_name
		-- blink.cmp.Context: cursor = { row 1-indexed, col 0-indexed em bytes }, line = linha atual
		local line = ctx.line or ''
		local cursor = ctx.cursor or { 1, 0 }
		local col = cursor[2] or 0
		local cur_line = line:sub(1, col) .. '█' .. line:sub(col + 1)
		local prev_line = vim.fn.getline(cursor[1] - 1)

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
				'%(%w*%.?█%w*%)', -- (foo█) ou (foo.█)
				'{%s*█', -- {█'
				'{.+,%s*█.*}?', -- {foo: bar, █ } | {foo: bar, █, baz: qux}
				'(.+,%s*█.*)?', -- (foo: bar, █ ) | (foo: bar, █, baz: qux)
			})
		then
			return (kind ~= 'Snippet')
		end

		-- if handler then return handler({ kind = kind, cur_line = cur_line }) end
    return true
end
