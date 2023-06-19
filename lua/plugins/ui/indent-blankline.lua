local M = {}

function M.setup()
	return {
		"lukas-reineke/indent-blankline.nvim",
		config = M.config,
	}
end

function M.config()
	require("indent_blankline").setup({
		char = "│", -- ┊ ┆ 
		context_char = "│", -- "▎",
		show_foldtext = false,
		char_priority = 12,
		show_trailing_blankline_indent = false,
		buftype_exclude = { "terminal", "telescope", "nofile" },
		filetype_exclude = {
			"dbout",
			"neo-tree-popup",
			"log",
			"gitcommit",
			"txt",
			"help",
			"NvimTree",
			"git",
			"flutterToolsOutline",
			"undotree",
			"markdown",
			"norg",
			"org",
			"orgagenda",
			"", -- for all buffers without a file type
		},
		show_current_context = true,
		show_current_context_start = true,
		show_current_context_start_on_current_line = false,
		show_end_of_line = false,
		show_first_indent_level = true,
		space_char_blankline = " ",
		-- use_treesitter = true,
	})
end

M.highlights = {
	-- IndentBlanklineChar = { fg = theme.ui.whitespace },
	-- IndentBlanklineSpaceChar = { fg = theme.ui.whitespace },
	-- IndentBlanklineSpaceCharBlankline = { fg = theme.ui.whitespace },
	IndentBlanklineContextChar = { fg = "#938AA9" },
	IndentBlanklineContextStart = { sp = "#938AA9", underline = true },
}

return M
