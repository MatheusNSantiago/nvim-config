local augroup, cmd, fn = utils.api.augroup, vim.cmd, vim.fn

augroup('random_autocommands', {
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
	command = 'silent! normal! g`"zv',
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
}, { ---@see repo https://github.com/nvimdev/hlsearch.nvim
	event = 'BufEnter',
	desc = 'Auto remove search highlight',
	command = function(args)
		local function stop_hl()
			-- if vim.v.hlsearch ~= 0 then U.api.feedkeys('<Cmd>nohl<CR>') end
			if vim.v.hlsearch == 0 then return end
			local keycode = vim.api.nvim_replace_termcodes('<Cmd>nohl<CR>', true, false, true)
			vim.api.nvim_feedkeys(keycode, 'n', false)
		end

		local function start_hl()
			local res = fn.getreg('/')
			if vim.v.hlsearch ~= 1 then return end
			if res:find([[%#]], 1, true) then return stop_hl() end
			local ok, _res = pcall(fn.search, [[\%#\zs]] .. res, 'cnW')
			if ok and _res == 0 then return stop_hl() end
		end
		augroup('auto_remove_search_hl', {
			event = 'CursorMoved',
			desc = 'Auto hlsearch',
			buffer = args.buf,
			command = function() start_hl() end,
		}, {
			event = 'InsertEnter',
			desc = 'Auto remove hlsearch',
			buffer = args.buf,
			command = function() stop_hl() end,
		}, {
			event = 'BufDelete',
			buffer = args.buf,
			command = function() pcall(vim.api.nvim_del_autocmd, 'auto_remove_search_hl') end,
		})
	end,
})
