local M = {}

function M.setup()
	return {
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
		config = M.config,
	}
end

function M.config()
	local ts = require("nvim-treesitter.configs")

	ts.setup({
		ensure_installed = {
			"javascript",
			"typescript",
			"prisma",
			"ruby",
			"tsx",
			"python",
			"dart",
			"json",
			"html",
			"lua",
			"css",
			"scss",
			"markdown",
			"markdown_inline",
			"toml",
			"fish",
			"jsdoc",
			"regex",
			"yaml",
			"bash",
		},
		autotag = { enable = true },
		refactor = {
			highlight_definitions = { enable = true },
			highlight_current_scope = { enable = false },
		},
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = "<C-space>",
				node_incremental = "<C-space>",
				-- scope_incremental = "<nop>",
				-- node_decremental = "<bs>",
			},
		},
		highlight = { enable = true, use_languagetree = true, additional_vim_regex_highlighting = false },
		indent = { enable = true, disable = {} },
		rainbow = {
			enable = true,
			extended_mode = false, -- Also highlight non-bracket delimiters like html tags, boolean or table
		},
		context_commentstring = { enable = true, enable_autocmd = false },
		textobjects = {
			move = {
				enable = true,
				set_jumps = true, -- whether to set jumps in the jumplist
				goto_next_start = {
					["]]"] = "@function.outer",
					["]m"] = "@class.outer",
				},
				goto_previous_start = {
					["[["] = "@function.outer",
					["[m"] = "@class.outer",
				},
				goto_next_end = {
					["]["] = "@function.outer",
					["]M"] = "@class.outer",
				},
				goto_previous_end = {
					["[]"] = "@function.outer",
					["[M"] = "@class.outer",
				},
			},
			select = {
				enable = true,
				-- Automatically jump forward to textobj, similar to targets.vim
				lookahead = true,
				keymaps = {
					-- You can use the capture groups defined in textobjects.scm
					["af"] = "@function.outer",
					["if"] = "@function.inner",
					["ac"] = "@class.outer",
					["ic"] = "@class.inner",
				},
				include_surrounding_whitespace = false,
			},
			swap = { enable = false, swap_next = {} },
		},
		matchup = { enable = false },
		endwise = { enable = true }, -- Automatically add end to blocks
	})
end

M.highlights = {
	rainbowcol1  = {fg="Yellow"},
	rainbowcol2  = {fg="#4688f0"},
	rainbowcol4  = {fg="#98c379"},
}

return M
