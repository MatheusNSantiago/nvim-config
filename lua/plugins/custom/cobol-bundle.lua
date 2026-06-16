local M = {}

function M.setup()
	return { ---@type LazyPluginSpec
		dir = '~/dev/cobol-bundle',
		config = M.config,
		dependencies = {
			'MunifTanjim/nui.nvim',
			'gbprod/stay-in-place.nvim',
			'nvim-treesitter/nvim-treesitter',
		},
		build = function() require('cobol-bundle').install_treesitter_parser({ sync = true }) end,
	}
end

function M.config()
	require('cobol-bundle').setup({
		kdz = {
			wsl_path = '/tmp/temp/zOSsrc',
			windows_path = '/mnt/c/Users/F7023235/ws_kdz170/#sigla-mainframe-ORIGINAL170/zOSsrc',
		},
		features = {
			outline = {
				enabled = true,
				keymaps = {
					open = '<leader>oo',
					search = '<leader>ss',
				},
			},
			hover = {
				enabled = true,
				keymaps = { open = 'K' },
			},
			rename = {
				enabled = true,
				keymaps = { open = 'gr' },
			},
			quick_add = {
				enabled = true,
				keymaps = {
					section = '<leader>as',
					picture = '<leader>ap',
				},
			},
			refactor_section = {
				enabled = true,
				keymaps = { extract = 'rs' },
			},
			add_file = {
				enabled = true,
				keymaps = { open = '<leader>af' },
			},
			add_copybook = {
				enabled = true,
				keymaps = { open = '<leader>ab' },
			},
			clean_file = {
				enabled = true,
				keymaps = { open = '<leader>cf' },
			},
			export_file = {
				enabled = true,
				keymaps = { open = '<leader>ef' },
			},
			displays = {
				enabled = true,
				keymaps = {
					comment = '<leader>cd',
					uncomment = '<leader>ud',
				},
			},
			sequence_code = {
				enabled = true,
				keymaps = { order = '<leader>os' },
			},
			glossary = {
				enabled = true,
				keymaps = {
					open = '<leader>gl',
				},
			},
			download_copybook = { enabled = true, keymaps = { open = '<leader>dc' } },
			compile = { enabled = true, keymaps = { current = '<leader>cc' } },
			spool = { enabled = true, keymaps = { open = '<leader>cl' } },
			editor_actions = {
				enabled = true,
				keymaps = {
					search_backward = '#',
					search_forward = '*',
					search_next = 'n',
					search_previous = 'N',
					shift_right = '>',
					shift_left = '<',
					shift_right_visual = '>',
					shift_left_visual = '<',
					tab_forward = '<Tab>',
					tab_backward = '<S-Tab>',
					complete_statement = '<CR>',
				},
			},
			virtcolumn = { enabled = true },
			local_run = { enabled = true, keymaps = { run = '<leader>r' } },
		},
	})
end

return M
