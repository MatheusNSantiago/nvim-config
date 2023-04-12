local M = {}

function M.setup()
	return {
		"lilibyte/tabhula.nvim",
		config = M.config,
	}
end

function M.config()
	local foo = function(line)
		return 1
	end

	require("tabhula").setup({
		tabkey = "<Tab>",
		backward_tabkey = "<S-Tab>",
		evil_tabkey = "",
		evil_backward_tabkey = "",
		completion = nil,
		range = nil,
		forward_characters = {
			[")"] = foo,
			["("] = foo,
			--
			["]"] = foo,
			["["] = foo,
			--
			["}"] = foo,
			["{"] = foo,
			--
			[","] = foo,
			["."] = foo,
			[";"] = foo,
			--
			['"'] = foo,
			["'"] = foo,
			["`"] = foo,
			-- hula past { only if line ends with { character (ignoring whitespace)
			-- 	["{"] = function(line) return line:match("^(.*){(%s*)$") ~= nil end,
			-- -- hula past > only if line is a C-style header inclusion
			-- [">"] = function(line)
			-- 	return line:match("^(%s*)#(%s*)include(%s*)<(%g*)>(%s*)$") ~= nil
			-- end,
			-- 	[";"] = function(line) return line:match("(.*);(%s*)$") ~= nil end,
		},
		backward_characters = {
			[")"] = foo,
			["("] = foo,
			--
			["]"] = foo,
			["["] = foo,
			--
			["}"] = foo,
			["{"] = foo,
			--
			[","] = foo,
			["."] = foo,
			[";"] = foo,
			--
			['"'] = foo,
			["'"] = foo,
			["`"] = foo,
		},
	})
end

return M
