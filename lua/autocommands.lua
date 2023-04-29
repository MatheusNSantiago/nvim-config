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

--  ╭──────────────────────────────────────────────────────────╮
--  │     Desligar o highlight da pesquisa automaticamente     │
--  ╰──────────────────────────────────────────────────────────╯
utils.api.keymap({ 'n', 'v', 'o', 'i', 'c' }, '<Plug>(StopHL)', ':execute("nohlsearch")<CR>')

local function stop_hl()
	if vim.v.hlsearch == 0 or api.nvim_get_mode().mode ~= 'n' then return end
	api.nvim_feedkeys(utils.api.replace_termcodes('<Plug>(StopHL)'), 'm', false)
end

local function hl_search()
	local col = api.nvim_win_get_cursor(0)[2]
	local curr_line = api.nvim_get_current_line()
	local ok, match = pcall(fn.matchstrpos, curr_line, fn.getreg('/'), 0)
	if not ok then return end
	local _, p_start, p_end = unpack(match)
	-- if the cursor is in a search result, leave highlighting on
	if col < p_start or col > p_end then stop_hl() end
end

utils.api.augroup('VimrcIncSearchHighlight', {
	event = { 'CursorMoved' },
	command = function() hl_search() end,
}, {
	event = { 'InsertEnter' },
	command = function() stop_hl() end,
}, {
	event = { 'OptionSet' },
	pattern = { 'hlsearch' },
	command = function()
		vim.schedule(function() cmd.redrawstatus() end)
	end,
}, {
	event = 'RecordingEnter',
	command = function() vim.o.hlsearch = false end,
}, {
	event = 'RecordingLeave',
	command = function() vim.o.hlsearch = true end,
})
