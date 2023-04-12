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
			extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table
			-- colors = { "#cc241d", "#a89984", "#b16286", "#d79921", "#689d6a", "#d65d0e", "#458588" },
			colors = {
				"#4688f0",
				"#98c379",
				"#e06c75",
				"#e5c07b",
				"#aa94ff",
				"#56b6c2",
				"#c678dd",
			},
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

return M
