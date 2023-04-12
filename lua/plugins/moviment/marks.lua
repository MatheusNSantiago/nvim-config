local M = {}

function M.setup()
	return {
		"chentoast/marks.nvim",
		event = "BufReadPre",
		config = M.config,
	}
end

function M.config()
	require("marks").setup({
		default_mappings = false,
		builtin_marks = {}, -- which builtin marks to show. default {}
		force_write_shada = false, -- whether the shada file is updated after modifying uppercase marks. default false
		mappings = {
			set = "m", -- Sets a letter mark (will wait for input).
			delete_line = "dm", --Deletes all marks on current line.
			delete_buf = "dM", -- Deletes all marks in current buffer.
			next = "m]", -- Goes to next mark in buffer.
			prev = "m[", -- Goes to previous mark in buffer.
			preview = "m:", -- Previews mark (will wait for user input). press <cr> to just preview the next mark.
		},
	})
end

local c = require("utils.colors")
M.highlights = {
	MarkSignHL = { fg = c.purple, bold = true }, -- The highlight group for displayed mark signs.
	MarkSignNumHL = {}, --The highlight group for the number line in a signcolumn.
	MarkVirtTextHL = {}, -- The highlight group for bookmark virtual text annotations.
}

return M
