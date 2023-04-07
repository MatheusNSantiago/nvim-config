local M = {}
local c = require("utils.colors")
local flatten = require("utils").flatten

-- https://github.com/numToStr/Sakura.nvim/commit/392a5d5a2e6097b816314b38d727e641a5bde7c9

M.base = {
	CursorLineNR = { fg = c.secondary },
	BufferOffset = { fg = c.secondary },
	-- StatusLineNC = { bg = "None" },
	-- """ Vim editor
	-- LineNr= { fg = "#5B6268", bg = "None" },
	FloatBorder = { bg = "None" },
	-- Cursor = { fg = c.bg, bg = c.white },
	-- CursorColumn = { fg = c.bg },
	-- CursorLine = { fg = c.white, bg = c.black },
	-- Directory = { fg = c.comments, bg = c.bg },
	-- EndOfBuffer = { fg = "None", bg = "None" },
	ErrorMsg = { fg = c.red, bg = c.bg, underline = true },
	Float = { fg = c.red },
	Folded = { fg = c.bg, bg = c.comments },
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
	-- TabLineSel = { fg = c.cyan },
	Tag = { fg = c.purple },
	-- Terminal = { fg = "None", bg = "None" },
	Title = { fg = c.red },
	VertSplit = { fg = c.black, bg = c.black },
	-- Visual         = { fg = "None", bg = c.invisibles },
}

M.syntax = {
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
	Structure = { fg = c.cyan },
	Underlined = { fg = "None" },
	Error = { fg = c.red, underline = true },
}

return flatten(M)


