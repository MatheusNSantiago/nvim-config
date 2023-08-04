local M = {}

function M.setup()
	return {
		'shellRaining/hlchunk.nvim',
		config = M.config,
	}
end

function M.config()
	require('hlchunk').setup({
		chunk = {
			enable = true,
			use_treesitter = true,
			notify = true, -- notify if some situation(like disable chunk mod double time)
			exclude_filetypes = {
				aerial = true,
				dashboard = true,
			},
			support_filetypes = {
				'*.py',
				'*.lua',
				'*.jsx?',
				'*.tsx?',
				'*.dart',
				'*.yaml',
				'*.json',
				'*.c',
			},
			chars = {
				horizontal_line = '─',
				vertical_line = '│',
				left_top = '╭',
				left_bottom = '╰',
				right_arrow = '─', -- '>',
			},
			style = { { fg = '#806d9c' } },
		},
		indent = {
			enable = true,
			use_treesitter = false,
			chars = { '│', '¦', '┆', '┊' },
			style = {
				'#3b4261',
			},
		},
		line_num = {
			enable = false,
			use_treesitter = false,
			style = '#806d9c',
		},
		blank = {
			enable = false,
			chars = { '․' },
			style = { vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID('Whitespace')), 'fg', 'gui') },
		},
	})
end

return M

--[[ local M = {}

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

return M ]]
