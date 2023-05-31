local c = vim.tbl_extend("force", require("utils.colors"), {
	outerbg = "#16161D",
	normal = "#7e9cd8",
	insert = "#98bb6c",
	visual = "#ffa066",
	replace = "#e46876",
	command = "#e6c384",
})

return {
	inactive = {
		a = { fg = c.gray, bg = c.outerbg, gui = "bold" },
		b = { fg = c.gray, bg = c.outerbg },
		c = { fg = c.gray, bg = c.transparent },
	},
	visual = {
		a = { fg = c.darkgray, bg = c.visual, gui = "bold" },
		b = { fg = c.gray, bg = c.outerbg },
		c = { fg = c.gray, bg = c.transparent },
	},
	replace = {
		a = { fg = c.darkgray, bg = c.replace, gui = "bold" },
		b = { fg = c.gray, bg = c.outerbg },
		c = { fg = c.gray, bg = c.transparent },
	},
	normal = {
		a = { fg = c.darkgray, bg = c.normal, gui = "bold" },
		b = { fg = c.gray, bg = c.outerbg },
		c = { fg = c.gray, bg = c.transparent },
	},
	insert = {
		a = { fg = c.darkgray, bg = c.insert, gui = "bold" },
		b = { fg = c.gray, bg = c.outerbg },
		c = { fg = c.gray, bg = c.transparent },
	},
	command = {
		a = { fg = c.darkgray, bg = c.command, gui = "bold" },
		b = { fg = c.gray, bg = c.outerbg },
		c = { fg = c.gray, bg = c.transparent },
	},
	terminal = {
		a = { bg = c.transparent, fg = c.gray, gui = "bold" },
		b = { bg = c.transparent, fg = c.gray, gui = "bold" },
	},
}
