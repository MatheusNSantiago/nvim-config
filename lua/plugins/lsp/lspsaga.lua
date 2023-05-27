local M = {}
local keymap = utils.api.keymap

function M.setup()
	return {
		'glepnir/lspsaga.nvim',
		config = M.config,
		opt = true,
		branch = 'main',
		event = 'LspAttach',
		-- cmd = { "Lspsaga" },
	}
end

function M.config()
	require('lspsaga').setup({
		scroll_preview = {
			scroll_down = '<C-d>',
			scroll_up = '<C-u>',
		},
		request_timeout = 3000,
		ui = {
			title = true,
			-- Border type can be single, double, rounded, solid, shadow.
			border = 'single',
			winblend = 0,
			expand = '',
			collapse = '',
			code_action = '💡',
			incoming = ' ',
			outgoing = ' ',
			hover = ' ',
			kind = {},
		},
		symbol_in_winbar = {
			enable = false,
			separator = ' ',
			ignore_patterns = {},
			hide_keyword = true,
			show_file = true,
			folder_level = 1,
			respect_root = false,
			color_mode = true,
		},
		rename = {
			quit = '<C-c>',
			exec = '<CR>',
			mark = 'x',
			confirm = '<CR>',
			in_select = true,
		},
		lightbulb = {
			enable = false,
			enable_in_insert = true,
			sign = false,
			sign_priority = 40,
			virtual_text = true,
		},
		code_action = {
			num_shortcut = true,
			show_server_name = false,
			extend_gitsigns = false,
			keys = {
				-- string | table type
				quit = 'q',
				exec = '<CR>',
			},
		},
		finder = {
			--percentage
			max_height = 0.5,
			force_max_height = false,
			keys = {
				jump_to = 'p',
				edit = { 'o', '<CR>' },
				vsplit = 's',
				split = 'i',
				tabe = 't',
				tabnew = 'r',
				quit = { 'q', '<ESC>' },
				close_in_preview = '<ESC>',
			},
		},
	})
end

return M
