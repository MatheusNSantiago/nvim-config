local M = {}

function M.setup()
	return {
		'mg979/vim-visual-multi',
		keys = {
			{ '<C-n>', mode = { 'n', 'x' }, desc = 'vim-visual-multi: Find Under' },
			{ '<C-M-l>', desc = 'vim-visual-multi: Add Cursor Up' },
			{ '<C-M-k>', desc = 'vim-visual-multi: Add Cursor Down' },
		},
		init = M.config,
	}
end

function M.config()
	vim.g.VM_leader = {
		default = ' ',
		visual = ' ',
		buffer = 'z',
	}

	vim.g.VM_default_mappings = 0
	vim.g.VM_show_warnings = 0
	vim.g.VM_silent_exit = 1
	vim.g.VM_single_mode_maps = 0

	vim.g.VM_maps = {
		['Undo'] = 'u',
		['Redo'] = '<C-r>',
		['Find Under'] = '<C-n>',
		['Find Subword Under'] = '<C-n>',
		['Select All'] = '<leader>A',
		['Add Cursor Up'] = '<C-M-l>',
		['Add Cursor Down'] = '<C-M-k>',
	}

	vim.g.VM_custom_motions = {
		['j'] = 'h',
		['k'] = 'j',
		['l'] = 'k',
		['ç'] = 'l',
	}
end

return M
