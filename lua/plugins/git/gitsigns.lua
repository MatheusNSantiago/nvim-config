local M = {}
function M.setup()
	return {
		'lewis6991/gitsigns.nvim',
		event =  {"BufReadPre", "BufNewFile" },
		config = M.config,
	}
end

function M.config()
	local function on_attach(bufnr)
		local gs = package.loaded.gitsigns

		local function map(mode, l, r, opts)
			opts = opts or {}
			opts.buffer = bufnr
			vim.keymap.set(mode, l, r, opts)
		end

		-- Navigation
		map('n', ']h', function()
			if vim.wo.diff then return ']h' end
			vim.schedule(function() gs.next_hunk() end)
			return '<Ignore>'
		end, { expr = true })

		map('n', '[h', function()
			if vim.wo.diff then return '[h' end
			vim.schedule(function() gs.prev_hunk() end)
			return '<Ignore>'
		end, { expr = true })

		-- Actions
		map({ 'n', 'v' }, 'ha', gs.stage_hunk, { desc = 'gitsigns: [H]unk [A]dd' })
		map({ 'n', 'v' }, 'hr', gs.reset_hunk, { desc = 'gitsigns: [H]unk [R]eset' })
		map('n', 'hp', gs.preview_hunk, { desc = 'gitsigns: [H]unk [P]review' })
		map('n', 'hb', gs.blame_line, { desc = 'gitsigns: [H]unk [B]lame' })
	end

	require('gitsigns').setup({
		signs = {
			add = { hl = 'GitSignsAdd', text = '▍', numhl = 'GitSignsAddNr', linehl = 'GitSignsAddLn' },
			change = {
				hl = 'GitSignsChange',
				text = '▍',
				numhl = 'GitSignsChangeNr',
				linehl = 'GitSignsChangeLn',
			},
			delete = {
				hl = 'GitSignsDelete',
				text = '▸',
				numhl = 'GitSignsDeleteNr',
				linehl = 'GitSignsDeleteLn',
			},
			topdelete = {
				hl = 'GitSignsDelete',
				text = '▾',
				numhl = 'GitSignsDeleteNr',
				linehl = 'GitSignsDeleteLn',
			},
			changedelete = {
				hl = 'GitSignsChange',
				text = '▍',
				numhl = 'GitSignsChangeNr',
				linehl = 'GitSignsChangeLn',
			},
		},
		signcolumn = true,
		numhl = false,
		linehl = false,
		word_diff = false,
		watch_gitdir = {
			interval = 1000,
			follow_files = true,
		},
		attach_to_untracked = true,
		current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
		current_line_blame_opts = {
			virt_text = true,
			virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
			delay = 1000,
			ignore_whitespace = false,
		},
		current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
		sign_priority = 6,
		status_formatter = nil, -- Use default
		update_debounce = 200,
		max_file_length = 40000,
		preview_config = {
			-- Options passed to nvim_open_win
			border = 'rounded',
			style = 'minimal',
			relative = 'cursor',
			row = 0,
			col = 1,
		},
		yadm = { enable = false },
		on_attach = on_attach,
	})
end

return M
