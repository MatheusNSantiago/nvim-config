local M = {}

function M.setup()
	return {
		'glepnir/lspsaga.nvim',
		config = M.config,
		dependencies = {
			'nvim-treesitter/nvim-treesitter',
			'nvim-tree/nvim-web-devicons',
		},
		event = 'LspAttach',
	}
end

function M.config()
	utils.api.augroup('lspsaga-fix', {
		desc = 'Conserta keymaps no lspsaga rename',
		event = 'Filetype',
		pattern = 'sagarename',
		command = function(args)
			vim.schedule(function() --
				vim.api.nvim_buf_del_keymap(args.buf, 'i', 'q')
			end)
		end,
	})

	require('lspsaga').setup({
		scroll_preview = {
			scroll_down = '<C-d>',
			scroll_up = '<C-u>',
		},
		request_timeout = 3000,
		beacon = {
			enable = false,
			frequency = 7,
		},
		ui = {
			title = true,
			-- Border type can be single, double, rounded, solid, shadow.
			border = 'single',
			winblend = 0,
			expand = '',
			collapse = ' ',
			code_action = '💡',
			incoming = ' ',
			outgoing = ' ',
			hover = ' ',
			kind = {},
		},
		hover = {
			max_width = 0.6,
			max_height = 0.8,
			open_link = 'gx',
		},
		definition = {
			width = 0.6,
			height = 0.5,
			keys = {
				edit = '<C-c>o',
				vsplit = '<C-c>v',
				split = '<C-c>h',
				tabe = '<C-c>t',
				quit = 'q',
				close = '<C-c>k',
			},
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
			in_select = true, -- Whether the name is selected when the float opens in some situation, just like want to change one or less characters, in_select is not so useful. You can tell the Lspsaga to start in normal mode using an extra argument like :Lspsaga lsp_rename mode=n
			auto_save = false, -- Auto save file when the rename is done
			project_max_width = 0.5, -- Width for the project_replace float window
			project_max_height = 0.5, -- Height for the project_replace float window
			keys = {
				quit = 'q',
				exec = '<CR>',
				confirm = '<CR>',
				select = 'x',
			},
		},
		lightbulb = {
			enable = false,
			sign = true,
			debounce = 10,
			sign_priority = 40,
			virtual_text = false,
			enable_in_insert = true,
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
			max_height = 0.5, -- max_height of the finder window (float layout)
			left_width = 0.3, -- Width of the left finder window (float layout)
			right_width = 0.3, -- Width of the right finder window (float layout)
			default = 'ref', -- Default search results shown, ref for “references” and imp for “implementation”
			layout = 'float', -- available value is normal and float normal will use the normal layout window priority is lower than command layout
			keys = {
				shuttle = '[w',
				toggle_or_open = { 'o', '<CR>' },
				vsplit = 'v',
				split = 'h',
				tabnew = 't',
				-- close = { '<C-c>k' },
				quit = { 'q', '<ESC>' },
			},
		},
		implement = {
			enable = false,
			sign = true,
			virtual_text = true,
			priority = 100,
		},
		diagnostic = {
			show_code_action = true,
			show_layout = 'float',
			show_normal_height = 10,
			jump_num_shortcut = true,
			max_width = 0.8,
			max_height = 0.6,
			max_show_width = 0.9,
			max_show_height = 0.6,
			text_hl_follow = true,
			border_follow = true,
			extend_relatedInformation = false,
			diagnostic_only_current = false,
			keys = {
				exec_action = 'o',
				quit = 'q',
				toggle_or_jump = '<CR>',
				quit_in_show = { 'q', '<ESC>' },
			},
		},
	})
end

return M
