local M = {}

function M.setup()
	return {
		'petertriho/nvim-scrollbar',
		requires = {
			'kevinhwang91/nvim-hlslens',
		},
		config = M.config,
	}
end

function M.config()
	local c = require('utils.colors')
	local c_tokyo = require('tokyonight.colors').setup()
	require('scrollbar.handlers.search').setup({
		override_lens = function() end,
	})

	require('scrollbar').setup({
		show = true,
		set_highlights = true,
		handle = {
			text = ' ',
			blend = 30, -- Integer between 0 and 100. 0 for fully opaque and 100 to full transparent. Defaults to 30.
			color = nil,
			color_nr = nil, -- cterm
			highlight = 'CursorColumn',
			hide_if_all_visible = true, -- Hides handle if all lines are visible
		},
		marks = {
			Cursor = {
				text = '•',
				priority = 0,
				gui = nil,
				color = nil,
				cterm = nil,
				color_nr = nil, -- cterm
				highlight = 'Normal',
			},
			Search = {
				text = { '-' },
				priority = 1,
				color = c.secondary,
				-- cterm = nil,
				highlight = 'Search',
			},
			Error = {
				text = { '-', '=' },
				priority = 2,
				color = nil,
				cterm = nil,
				highlight = 'DiagnosticVirtualTextError',
			},
			Warn = {
				text = { '-', '=' },
				priority = 3,
				color = nil,
				cterm = nil,
				highlight = 'DiagnosticVirtualTextWarn',
			},
			Info = {
				text = { '-', '=' },
				priority = 4,
				color = nil,
				cterm = nil,
				highlight = 'DiagnosticVirtualTextInfo',
			},
			Hint = {
				text = { '-', '=' },
				priority = 5,
				color = nil,
				cterm = nil,
				highlight = 'DiagnosticVirtualTextHint',
			},
			Misc = {
				text = { '-', '=' },
				priority = 6,
				color = nil,
				cterm = nil,
				highlight = 'Normal',
			},
		},
		excluded_buftypes = {
			'terminal',
		},
		excluded_filetypes = {
			'prompt',
			'TelescopePrompt',
		},
		autocmd = {
			render = {
				'BufWinEnter',
				'TabEnter',
				'TermEnter',
				'WinEnter',
				'CmdwinLeave',
				-- "TextChanged",
				'VimResized',
				'WinScrolled',
			},
		},
		handlers = {
			cursor = true,
			diagnostic = true,
			search = true, -- Requires hlslens to be loaded, will run require("scrollbar.handlers.search").setup() for you
		},
	})
end

return M
