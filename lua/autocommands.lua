local augroup, cmd, fn = utils.api.augroup, vim.cmd, vim.fn

augroup('Não comenta nova linha automaticamente', {
	pattern = '*',
	event = 'BufEnter',
	command = [[set formatoptions-=cro]],
})

augroup('Mover para a última posição quando abrir um buffer', {
	pattern = '*',
	event = 'BufReadPost',
	command = [[if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g`\"" | endif]],
})

augroup('Limpar trailing spaces antes de salvar', {
	event = 'BufWritePre',
	pattern = '*',
	command = function() cmd([[ %s/\s\+$//e ]]) end,
})

augroup('Abrir imagens com o aplicativo padrão', {
	event = { 'BufEnter' },
	pattern = { '*.png', '*.jpg', '*.gif' },
	command = function()
		cmd('silent! !open ' .. fn.expand('%'))
		cmd('silent! :bw!')
	end,
})

augroup('Salvar antes de sair', {
	event = 'BufLeave',
	pattern = '*',
	command = function()
		local save_excluded = { 'NvimTree', 'lua.luapad', 'gitcommit', 'NeogitCommitMessage' }
		local can_save = utils.falsy(fn.win_gettype())
				and utils.falsy(vim.bo.buftype)
				and not utils.falsy(vim.bo.filetype)
				and vim.bo.modifiable
				and not vim.tbl_contains(save_excluded, vim.bo.filetype)

		if can_save then cmd('silent! write ++p') end
	end,
})
