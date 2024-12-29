---@class LspTypeLimiter
---@field kind string
---@field cur_line string

---@param entry cmp.Entry
---@param ctx cmp.Context
---@param handler? fun(info: LspTypeLimiter):boolean
---@return boolean
return function(entry, ctx, handler)
	local deu_certo, res = utils.pcall(function()
		local kind = require('cmp.types.lsp').CompletionItemKind[entry:get_kind()]
		local prev_line = vim.fn.getline(ctx.cursor.line)
		local cur_line = ctx.cursor_before_line .. '█' .. ctx.cursor_after_line

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

		if handler then return handler({ kind = kind, cur_line = cur_line }) end
		return true
	end)

	if deu_certo then return res end
	return true
end
