local api, cmd, fn = vim.api, vim.cmd, vim.fn

--  ╭──────────────────────────────────────────────────────────╮
--  │               don't auto comment new line                │
--  ╰──────────────────────────────────────────────────────────╯
api.nvim_create_autocmd('BufEnter', { command = [[set formatoptions-=cro]] })

--  ╭──────────────────────────────────────────────────────────╮
--  │           go to last loc when opening a buffer           │
--  ╰──────────────────────────────────────────────────────────╯
api.nvim_create_autocmd(
	'BufReadPost',
	{ command = [[if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g`\"" | endif]] }
)

--  ╭──────────────────────────────────────────────────────────╮
--  │            Strip trailing spaces before write            │
--  ╰──────────────────────────────────────────────────────────╯
api.nvim_create_autocmd({ 'BufWritePre' }, {
	pattern = { '*' },
	callback = function() cmd([[ %s/\s\+$//e ]]) end,
})

--  ╭──────────────────────────────────────────────────────────╮
--  │    Open images in an image viewer (probably Preview)     │
--  ╰──────────────────────────────────────────────────────────╯
utils.api.augroup('ExternalCommands', {
	event = { 'BufEnter' },
	pattern = { '*.png', '*.jpg', '*.gif' },
	command = function()
		cmd('silent! !open ' .. fn.expand('%'))
		cmd('silent! :bw!')
	end,
})

--  ╭──────────────────────────────────────────────────────────╮
--  │                   Salva antes de sair                    │
--  ╰──────────────────────────────────────────────────────────╯
api.nvim_create_autocmd({ 'BufLeave' }, {
	pattern = { '*' },
	callback = function()
		local save_excluded = { 'NvimTree', 'lua.luapad', 'gitcommit', 'NeogitCommitMessage' }
		local can_save = utils.falsy(fn.win_gettype())
			and utils.falsy(vim.bo.buftype)
			and not utils.falsy(vim.bo.filetype)
			and vim.bo.modifiable
			and not vim.tbl_contains(save_excluded, vim.bo.filetype)

		if can_save then cmd('silent! write ++p') end
	end,
})

--  ╭──────────────────────────────────────────────────────────╮
--  │                       Salvar Folds                       │
--  ╰──────────────────────────────────────────────────────────╯
---@see https://stackoverflow.com/a/68156828
utils.api.augroup(
	'RememberFolds',
	{ event = 'BufWinLeave', pattern = '*.*', command = 'mkview' },
	{ event = 'BufWinEnter', pattern = '*.*', command = 'silent! loadview' }
)
