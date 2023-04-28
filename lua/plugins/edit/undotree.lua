local M = {}

function M.setup()
	utils.api.keymap('n', '<leader>uT', '<Cmd>UndotreeToggle<CR>', { desc = 'Toggle undotree' })

	return {
		'mbbill/undotree',
		config = M.config,
	}
end

function M.config()
	vim.g.undotree_SetFocusWhenToggle = 1
	vim.g.undotree_TreeNodeShape = '◉'
	vim.g.undotree_WindowLayout = 3

	vim.cmd([[
        function! g:Undotree_CustomMap() abort
		nmap <buffer> L <plug>UndotreeNextState
		nmap <buffer> K <plug>UndotreePreviousState
        endfunction
      ]])
end

return M
