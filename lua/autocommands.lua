local augroup, cmd, fn = utils.api.augroup, vim.cmd, vim.fn

augroup('my_autocommands_augroup', {
	desc = 'Não comenta nova linha automaticamente',
	pattern = '*',
	event = 'BufEnter',
	command = [[set formatoptions-=cro]],
}, {
	desc = 'Seta os highlights quando entra no vim',
	event = 'VimEnter',
	command = function()
		local hls = require('colorscheme').get_all_highlights()
		utils.set_hls(hls)
	end,
}, {
	desc = 'Mover para a última posição editada quando abrir um buffer',
	pattern = '*',
	event = 'BufReadPost',
  command = 'silent! normal! g`"zv'
}, {
	desc = 'Limpar trailing spaces antes de salvar',
	event = 'BufWritePre',
	pattern = '*',
	command = function() cmd([[ %s/\s\+$//e ]]) end,
}, {
	desc = 'Abrir imagens com o aplicativo padrão',
	event = { 'BufEnter' },
	pattern = { '*.png', '*.jpg', '*.gif' },
	command = function()
		cmd('silent! !open ' .. fn.expand('%'))
		cmd('silent! :bw!')
	end,
}, {
	desc = 'Salvar antes de sair',
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
}, {
	desc = 'conserta keymaps/colorschemes que bugam de vez em quando',
	event = 'BufWritePost',
	pattern = '*.{lua,js,ts,py,c,cbl,cpy}',
	command = function()
		utils.api.bulk_delete_keymaps({
			['n'] = { '<C-D>', '<C-U>', 'p' },
		})

		require("keymappings")
	end,
})
