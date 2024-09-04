local M = {}

function M.setup()
	return {
		'lilibyte/tabhula.nvim',
		event = 'InsertEnter',
		config = M.config,
	}
end

function M.config()
	local doit = function(_) return 1 end
	require('tabhula').setup({
		tabkey = '<Tab>',
		backward_tabkey = '<S-Tab>',
		evil_tabkey = '',
		evil_backward_tabkey = '',
		completion = nil,
		range = 0,
		forward_characters = {
			[')'] = doit,
			['('] = doit,
			--
			[']'] = doit,
			['['] = doit,
			--
			['}'] = doit,
			['{'] = doit,
			--
			[','] = doit,
			['.'] = doit,
			[';'] = doit,
			--
			['"'] = doit,
			["'"] = doit,
			['`'] = doit,
			-- hula past { only if line ends with { character (ignoring whitespace)
			-- 	["{"] = function(line) return line:match("^(.*){(%s*)$") ~= nil end,
			-- -- hula past > only if line is a C-style header inclusion
			-- [">"] = function(line)
			-- 	return line:match("^(%s*)#(%s*)include(%s*)<(%g*)>(%s*)$") ~= nil
			-- end,
			-- 	[";"] = function(line) return line:match("(.*);(%s*)$") ~= nil end,
		},
		backward_characters = {
			[')'] = doit,
			['('] = doit,
			--
			[']'] = doit,
			['['] = doit,
			--
			['}'] = doit,
			['{'] = doit,
			--
			[','] = doit,
			['.'] = doit,
			[';'] = doit,
			--
			['"'] = doit,
			["'"] = doit,
			['`'] = doit,
		},
	})
end

return M
