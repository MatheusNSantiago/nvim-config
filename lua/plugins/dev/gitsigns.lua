local M = {}
function M.setup()
	return {
		'lewis6991/gitsigns.nvim',
		event = { 'BufReadPre', 'BufNewFile' },
		config = M.config,
	}
end

function M.config()
	local gs = require('gitsigns')

	gs.setup({
		signs = {
			add = { text = '┃' },
			change = { text = '┃' },
			delete = { text = '_' },
			topdelete = { text = '‾' },
			changedelete = { text = '~' },
			untracked = { text = '┆' },
		},
		signs_staged = {
			add = { text = '┃' },
			change = { text = '┃' },
			delete = { text = '_' },
			topdelete = { text = '‾' },
			changedelete = { text = '~' },
			untracked = { text = '┆' },
		},
		signs_staged_enable = true,
		signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
		linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
		word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
		watch_gitdir = {
			follow_files = true,
		},
		auto_attach = true,
		attach_to_untracked = false,
		-- attach_to_untracked = true,
		current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
		current_line_blame_opts = {
			virt_text = true,
			virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
			delay = 1000,
			ignore_whitespace = false,
			virt_text_priority = 100,
			use_focus = true,
		},
		current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
		sign_priority = 6,
		update_debounce = 100,
		status_formatter = nil, -- Use default
		max_file_length = 40000, -- Disable if file is longer than this (in lines)
		preview_config = {
			-- Options passed to nvim_open_win
			border = 'rounded',
			style = 'minimal',
			relative = 'cursor',
			row = 0,
			col = 1,
		},
		on_attach = function(bufnr)
			local function map(mode, l, r, opts)
				opts = opts or {}
				opts.buffer = bufnr
				vim.keymap.set(mode, l, r, opts)
			end

			-- Navigation
			map('n', ']h', function()
				if vim.wo.diff then
					vim.cmd.normal({ ']h', bang = true })
				else
					gs.nav_hunk('next')
				end
			end)

			map('n', '[h', function()
				if vim.wo.diff then
					return vim.cmd.normal({ '[h', bang = true })
				else
					gs.nav_hunk('prev')
				end
			end)

			-- Actions
			map({ 'n', 'v' }, '<leader>ha', function()
				if vim.fn.mode() == 'n' then
					gs.stage_hunk()
				else
					gs.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
				end
			end, { desc = 'gitsigns: [H]unk [A]dd' })

			map('v', '<leader>hr', function()
				if vim.fn.mode() == 'n' then
					gs.reset_hunk()
				else
					gs.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
				end
			end, { desc = 'gitsigns: [H]unk [R]eset' })

			map('n', '<leader>hu', gs.undo_stage_hunk)
			map('n', '<leader>ht', gs.toggle_deleted, { desc = 'gitsigns: [H]unk [T]oggle Deleted' })

			map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
		end,
	})
end

M.highlights = {
	DiffAdd = { bg = '#002800' },
	DiffDelete = { bg = '#3f0001' },
}

return M
