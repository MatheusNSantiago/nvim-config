local M = {}
-- https://github.com/numToStr/Sakura.nvim/commit/392a5d5a2e6097b816314b38d727e641a5bde7c9
-- https://github.com/LunarVim/onedarker.nvim/blob/master/lua/onedarker/theme.lua
local c = require("utils.colors")

local highlights = {
	code = {
		Comment = { fg = c.comments },
		Boolean = { fg = c.red },
		Conditional = { fg = c.purple },
		Todo = { fg = c.comments },
		Constant = { fg = c.yellow },
		String = { fg = c.green },
		Identifier = { fg = c.yellow },
		Type = { fg = c.purple },
		Function = { fg = c.yellow },
		Statement = { fg = c.purple },
		Operator = { fg = c.purple },
		WarningMsg = { fg = c.orange },
		PreProc = { fg = c.purple },
		Define = { fg = c.purple },
		Special = { fg = c.red },
		Conceal = { fg = c.orange },
		Character = { fg = c.green },
		Include = { fg = c.purple },
		Macro = { fg = c.purple },
		Structure = { fg = c.red },
		Underlined = { fg = "None" },
		Error = { fg = c.red, underline = true },
		--  ╭──────────────────────────────────────────────────────────╮
		--  │                        TreeSitter                        │
		--  ╰──────────────────────────────────────────────────────────╯
		["@lsp.mod.annotation"] = { fg = c.purple }, -- @[annotation]
		["@lsp.type.annotation"] = { fg = c.purple }, -- [@]annotation
		["@lsp.type.interface"] = { fg = c.yellow }, -- interfaces
		["@tag"] = { fg = c.pink }, -- interfaces
		["@tag.delimiter"] = { fg = c.white }, -- interfaces
		["@constructor"] = { fg = c.red }, -- interfaces
		["@property"] = { fg = c.cyan }, -- interfaces
		["@parameter"] = { fg = c.cyan }, -- interfaces
	},
	editor = {
		CursorLineNR = { fg = c.secondary },
		BufferOffset = { fg = c.secondary },
		FloatBorder = { bg = "None" },
		CursorLine = { bg = c.bg_highlight },
		ErrorMsg = { fg = c.red, bg = c.bg, underline = true },
		Float = { fg = c.red },
		Folded = { bg = c.invisible },
		Keyword = { fg = c.purple },
		Label = { fg = c.green },
		LineNr = { fg = c.comments },
		MatchParen = { fg = c.white, bg = c.comments },
		ModeMsg = { fg = "None", bg = "None" },
		NonText = { fg = c.invisibles, bg = c.bg },
		Number = { fg = c.orange },
		Search = { fg = c.bg, bg = c.secondary },
		SpecialComment = { fg = c.comments },
		SpecialKey = { fg = c.invisibles, bg = c.bg },
		StorageClass = { fg = c.purple },
		Tag = { fg = c.purple },
		Title = { fg = c.red },
		VertSplit = { fg = c.black, bg = c.black },
		--  ╭──────────────────────────────────────────────────────────╮
		--  │                           CSS                            │
		--  ╰──────────────────────────────────────────────────────────╯
		cssBraces = { fg = c.fg },
		cssInclude = { fg = c.purple },
		cssTagName = { fg = c.yellow },
		cssClassName = { fg = c.yellow },
		cssPseudoClass = { fg = c.yellow },
		cssPseudoClassId = { fg = c.yellow },
		cssPseudoClassLang = { fg = c.yellow },
		cssIdentifier = { fg = c.yellow },
		cssProp = { fg = c.fg },
		cssDefinition = { fg = c.fg },
		cssAttr = { fg = c.orange },
		cssAttrRegion = { fg = c.orange },
		cssColor = { fg = c.orange },
		cssFunction = { fg = c.purple },
		cssFunctionName = { fg = c.yellow },
		cssVendor = { fg = c.orange },
		cssValueNumber = { fg = c.orange },
		cssValueLength = { fg = c.orange },
		cssUnitDecorators = { fg = c.orange },
		cssStyle = { fg = c.fg },
		cssImportant = { fg = c.blue },
		cssPropriety = { fg = c.purple },
		--  ╭──────────────────────────────────────────────────────────╮
		--  │                           HTML                           │
		--  ╰──────────────────────────────────────────────────────────╯
		htmlH1 = { fg = c.fg },
		htmlH2 = { fg = c.fg },
		htmlH3 = { fg = c.fg },
		htmlH4 = { fg = c.fg },
		htmlH5 = { fg = c.fg },
		htmlH6 = { fg = c.fg },
		htmlHead = { fg = c.fg },
		htmlTitle = { fg = c.fg },
		htmlArg = { fg = c.fg },
		htmlTag = { fg = c.blue },
		htmlTagN = { fg = c.blue },
		htmlTagName = { fg = c.blue },
		htmlComment = { fg = c.green },
		htmlLink = { fg = c.orange, underline = true },
		--  ╭──────────────────────────────────────────────────────────╮
		--  │                           XML                            │
		--  ╰──────────────────────────────────────────────────────────╯
		xmlTag = { fg = c.cyan },
		xmlTagName = { fg = c.cyan },
		xmlEndTag = { fg = c.cyan },
	},
}

function M.get_base_highlights()
	return utils.flatten(highlights)
end

function M.get_plugin_highlights()
	local all_hls = {}
	local plugin_files = vim.fn.glob(vim.fn.stdpath("config") .. "/lua/plugins" .. "/**/*.lua", true, true)

	for _, file in ipairs(plugin_files) do
		local is_installed, plugin = pcall(require, file:match("/(plugins/.*).lua"):gsub("/", "."))

		if is_installed then
			if type(plugin) == "table" then
				if plugin.highlights then -- plugin has highlights
					for group, highlight in pairs(plugin.highlights) do
						all_hls[group] = highlight
					end
				end
			end
		end
	end

	return all_hls
end

function M.get_all_highlights()
	return vim.tbl_extend("force", M.get_base_highlights(), M.get_plugin_highlights())
end

return M
