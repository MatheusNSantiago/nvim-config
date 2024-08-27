local M = {}

function M.setup()
	return {
		'chentoast/marks.nvim',
		event = 'BufReadPre',
		config = M.config,
	}
end

function M.config()
	require('marks').setup({
		default_mappings = false,
		builtin_marks = { },

		-- whether movements cycle back to the beginning/end of buffer. default true
		cyclic = true,

		-- whether the shada file is updated after modifying uppercase marks. default false
		force_write_shada = false,

		-- how often (in ms) to redraw signs/recompute mark positions.
		-- higher values will have better performance but may cause visual lag,
		-- while lower values may cause performance penalties. default 150.
		refresh_interval = 250,

		-- sign priorities for each type of mark - builtin marks, uppercase marks, lowercase
		-- marks, and bookmarks.
		-- can be either a table with all/none of the keys, or a single number, in which case
		-- the priority applies to all marks.
		-- default 10.
		sign_priority = { lower = 10, upper = 15, builtin = 8, bookmark = 20 },
		excluded_filetypes = {},
		mappings = {
			set = 'm',       -- Sets a letter mark (will wait for input).
			delete_line = 'dm', --Deletes all marks on current line.
			delete_buf = 'dM', -- Deletes all marks in current buffer.
			next = 'm]',     -- Goes to next mark in buffer.
			prev = 'm[',     -- Goes to previous mark in buffer.
			preview = 'mp',  -- Previews mark (will wait for user input). press <cr> to just preview the next mark.
		},
	})
end

M.highlights = {
	MarkSignHL = { fg = c.purple, bold = true }, -- The highlight group for displayed mark signs.
	MarkSignNumHL = {},                         --The highlight group for the number line in a signcolumn.
	MarkVirtTextHL = {},                        -- The highlight group for bookmark virtual text annotations.
}

return M
