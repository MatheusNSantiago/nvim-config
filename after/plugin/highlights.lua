local set_hls = require("utils").set_hls
local c = require("utils.colors")
local hls = {}
-- https://github.com/numToStr/Sakura.nvim/commit/392a5d5a2e6097b816314b38d727e641a5bde7c9

--  ╭──────────────────────────────────────────────────────────╮
--  │                     Highlights Nvim                      │
--  ╰──────────────────────────────────────────────────────────╯

hls.base = {
	-- CursorLineNR = { fg = c.secondary },
	CursorLineNR = { fg = c.secondary },
	BufferOffset = { fg = c.secondary },
	-- StatusLineNC = { bg = "None" },
	-- """ Vim editor
	FloatBorder = { bg = "None" },
	-- CursorColumn = { fg = c.bg },─
	CursorLine = { bg = c.bg_highlight },
	-- Directory = { fg = c.comments, bg = c.bg },
	-- EndOfBuffer = { fg = "None", bg = "None" },
	ErrorMsg = { fg = c.red, bg = c.bg, underline = true },
	Float = { fg = c.red },
	-- Folded = { fg = c.bg, bg = c.comments },
	Folded = { bg = c.invisible },
	Keyword = { fg = c.purple },
	Label = { fg = c.green },
	LineNr = { fg = c.comments },
	MatchParen = { fg = c.white, bg = c.comments },
	ModeMsg = { fg = "None", bg = "None" },
	NonText = { fg = c.invisibles, bg = c.bg },
	-- Normal = { fg = c.white, bg = c.bg },
	Number = { fg = c.orange },
	-- Pmenu = { fg = c.white, bg = c.invisibles },
	-- PmenuSel = { fg = c.bg, bg = c.yellow },
	-- PmenuSbar = { bg = c.invisibles },
	-- PmenuThumb = { bg = c.comments },
	Search = { fg = c.bg, bg = c.secondary },
	SpecialComment = { fg = c.comments },
	SpecialKey = { fg = c.invisibles, bg = c.bg },
	-- StatusLine = { fg = c.red, bg = c.comments },
	-- StatusLineNC = { fg = c.red, bg = c.comments },
	StorageClass = { fg = c.purple },
	-- TabLine = { fg = c.comments },
	-- TabLineFill = { fg = "None", bg = "None" },
	Tag = { fg = c.purple },
	-- Terminal = { fg = "None", bg = "None" },
	Title = { fg = c.red },
	VertSplit = { fg = c.black, bg = c.black },
	-- Visual         = { fg = "None", bg = c.invisibles },
}

hls.syntax = {
	Comment = { fg = c.comments },
	Boolean = { fg = c.red },
	Conditional = { fg = c.purple },
	Todo = { fg = c.comments },
	Constant = { fg = c.yellow },
	String = { fg = c.green },
	Identifier = { fg = c.cyan, bg = c.bg },
	Type = { fg = c.purple },
	Function = { fg = c.yellow },
	Statement = { fg = c.purple },
	Operator = { fg = c.purple },
	WarningMsg = { fg = c.orange },
	PreProc = { fg = c.purple },
	Define = { fg = c.purple },
	Special = { fg = c.red },
	Conceal = { fg = c.orange, bg = c.bg },
	Character = { fg = c.green },
	Include = { fg = c.cyan },
	Macro = { fg = c.purple },
	Structure = { fg = c.red },
	Underlined = { fg = "None" },
	Error = { fg = c.red, underline = true },
	-- Special (tem que usar :Inspect em cima da palavra)
	["@lsp.mod.annotation"] = { fg = c.purple }, -- @[annotation]
	["@lsp.type.annotation"] = { fg = c.purple }, -- [@]annotation
}

set_hls(require("utils").flatten(hls))

--  ╭──────────────────────────────────────────────────────────╮
--  │                  Highlights dos Plugins                  │
--  ╰──────────────────────────────────────────────────────────╯

local plugin_files = vim.fn.glob(vim.fn.stdpath("config") .. "/lua/plugins" .. "/**/*.lua", true, true)
for _, file in ipairs(plugin_files) do
	local is_installed, plugin =  pcall(require, file:match("/(plugins/.*).lua"):gsub("/", "."))

	if is_installed then
		if type(plugin) == "table" then
			if plugin.highlights then -- plugin has highlights
				set_hls(plugin.highlights)
			end
		end
	end
end
