local M = {}

function M.setup()
	return {
		'tpope/vim-fugitive',
		keys = {
			{ '<leader>ga', ':Git add %<CR>',        desc = '[g]it [A]dd current file' },
			{ '<leader>gA', ':Git add .<CR>',        desc = '[G]it add [A]ll files' },
			{ '<leader>gu', ':Git reset HEAD %<CR>', desc = '[G]it [u]nstage current file' },
			{ '<leader>gU', ':Git reset HEAD<CR>',   desc = '[G]it [U]nstage all files' },
			{ '<leader>gc', ':Git commit<CR>',       desc = '[G]it [c]ommit' },
			{ '<leader>gp', ':Git push<CR>',         desc = '[G]it [p]ush' },
		},
	}
end

return M
