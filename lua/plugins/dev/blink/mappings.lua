local is_copilot_suggestion_visible = function() --
	local copilot_ok, suggestion = pcall(require, 'copilot.suggestion')
	return copilot_ok and suggestion.is_visible()
end

local accept_copilot_sugestion = function() --
	local copilot_ok, suggestion = pcall(require, 'copilot.suggestion')
	if copilot_ok then
		suggestion.accept()
		return true
	end
end

return { ---@type table<string, blink.cmp.KeymapCommand[]>
	['<C-space>'] = { 'show', 'hide' },
	['<CR>'] = {
		function(cmp)
			if is_copilot_suggestion_visible() then return accept_copilot_sugestion() end
			if cmp.snippet_active() then
				return cmp.accept()
			else
				return cmp.select_and_accept()
			end
		end,
		'accept',
		'fallback',
	},

	['<Tab>'] = { 'snippet_forward', 'fallback' },
	['<S-Tab>'] = { 'snippet_backward', 'fallback' },

	['<Up>'] = { 'select_prev', 'fallback' },
	['<C-l>'] = { 'select_prev', 'fallback' },
	['<Down>'] = { 'select_next', 'fallback' },
	['<C-k>'] = { 'select_next', 'fallback' },

	['<C-u>'] = { 'scroll_documentation_up', 'fallback' },
	['<C-d>'] = { 'scroll_documentation_down', 'fallback' },
}
