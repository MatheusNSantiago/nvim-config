local c = require("utils.colors")
require("utils").set_hls({
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
})