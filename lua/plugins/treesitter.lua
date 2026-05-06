local M = {}

function M.setup()
	return {
		'nvim-treesitter/nvim-treesitter',
		lazy = false,
		build = ':TSUpdate',
		config = M.config,
	}
end

function M.config()
	local ts = require('nvim-treesitter')
	local max_filesize = 1024 * 1024 -- 1 MB

	ts.install({
		'vim', 'vimdoc', 'bash', 'regex', 'javascript', 'typescript',
		'prisma', 'ruby', 'tsx', 'python', 'dart', 'json', 'html',
		'lua', 'css', 'scss', 'toml', 'fish', 'jsdoc', 'yaml',
	})

	vim.api.nvim_create_autocmd('FileType', {
		callback = function(ev)
			local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(ev.buf))
			if ok and stats and stats.size > max_filesize then return end

			local lang = vim.treesitter.language.get_lang(vim.bo[ev.buf].filetype)
			if lang and not vim.tbl_contains(ts.get_installed(), lang) then
				ts.install({ lang })
			end

			pcall(vim.treesitter.start, ev.buf)
		end,
	})

	require('nvim-treesitter-textobjects').setup({
		select = { lookahead = true, include_surrounding_whitespace = false },
		move = { set_jumps = true },
	})

	local select_to = require('nvim-treesitter-textobjects.select')
	local move_to = require('nvim-treesitter-textobjects.move')

	local ts_disable = { cobol = true, foo = true }

	local select_maps = {
		['af'] = '@function.outer',
		['if'] = '@function.inner',
		['ac'] = '@class.outer',
		['ic'] = '@class.inner',
		['iB'] = '@block.inner',
		['aB'] = '@block.outer',
	}
	for key, query in pairs(select_maps) do
		vim.keymap.set({ 'x', 'o' }, key, function()
			if ts_disable[vim.bo.filetype] then return end
			select_to.select_textobject(query, 'textobjects')
		end)
	end

	local move_maps = {
		[']f'] = { 'goto_next_start', '@function.outer' },
		[']c'] = { 'goto_next_start', '@class.outer' },
		['[f'] = { 'goto_previous_start', '@function.outer' },
		['[c'] = { 'goto_previous_start', '@class.outer' },
		[']F'] = { 'goto_next_end', '@function.outer' },
		[']C'] = { 'goto_next_end', '@class.outer' },
		['[F'] = { 'goto_previous_end', '@function.outer' },
		['[C'] = { 'goto_previous_end', '@class.outer' },
	}
	for key, spec in pairs(move_maps) do
		local fn, query = spec[1], spec[2]
		vim.keymap.set({ 'n', 'x', 'o' }, key, function()
			if ts_disable[vim.bo.filetype] then return end
			move_to[fn](query, 'textobjects')
		end)
	end
end

return M
