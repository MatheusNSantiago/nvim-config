local keymap = utils.api.keymap
local M = {}

function M.setup()
	keymap('n', '<leader>ga', ':Git add %<CR>', { desc = '[g]it [A]dd current file' })
	keymap('n', '<leader>gA', ':Git add .<CR>', { desc = '[G]it add [A]ll files' })

	keymap('n', '<leader>gu', ':Git reset HEAD %<CR>', { desc = '[G]it [u]nstage current file' })
	keymap('n', '<leader>gU', ':Git reset HEAD<CR>', { desc = '[G]it [U]nstage all files' })

	keymap('n', '<leader>gc', ':Git commit<CR>', { desc = '[G]it [c]ommit' })
	keymap('n', '<leader>gp', ':Git push<CR>', { desc = '[G]it [p]ush' })

	return { 'tpope/vim-fugitive' }
end

return M
