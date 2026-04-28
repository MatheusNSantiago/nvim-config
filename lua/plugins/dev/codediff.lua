local M = {}

function M.setup()
	return { ---@type LazyPluginSpec
		'esmuellert/codediff.nvim',
		config = M.config,
		cmd = 'CodeDiff',
		dependencies = { 'MunifTanjim/nui.nvim' },
	}
end

function M.config()
	require('codediff').setup({
		diff = {
			layout = 'inline', -- Diff layout: "side-by-side" (two panes) or "inline" (single pane with virtual lines)
			disable_inlay_hints = true, -- Disable inlay hints in diff windows for cleaner view
			ignore_trim_whitespace = false, -- Ignore leading/trailing whitespace changes (like diffopt+=iwhite)
			hide_merge_artifacts = false, -- Hide merge tool temp files (*.orig, *.BACKUP.*, *.BASE.*, *.LOCAL.*, *.REMOTE.*)
			conflict_result_height = 30, -- Height of result pane in bottom layout (% of total height)
			conflict_result_width_ratio = { 1, 1, 1 }, -- Width ratio for center layout panes {left, center, right} (e.g., {1, 2, 1} for wider result)
			jump_to_first_change = true, -- Auto-scroll to first change when opening a diff: false to stay at same line
			compute_moves = true, -- Detect moved code blocks (opt-in, matches VSCode experimental.showMoves)
		},
		explorer = {
			position = 'left',
			view_mode = 'tree',
			width = 30,
		},
		keymaps = {
			view = {
				quit = 'q', -- Close diff tab
				toggle_explorer = '<leader>e', -- Toggle explorer visibility (explorer mode only)
				next_hunk = ']c', -- Jump to next change
				prev_hunk = '[c', -- Jump to previous change
				-- next_file = ']f', -- Next file in explorer mode
				-- prev_file = '[f', -- Previous file in explorer mode
				next_file = '<Tab>',
				prev_file = '<S-Tab>',
				diff_get = 'do', -- Get change from other buffer (like vimdiff)
				diff_put = 'dp', -- Put change to other buffer (like vimdiff)
				--  ╾───────────────────────────────────────────────────────────────────────────────────╼
				-- focus_explorer = '<leader>e', -- Focus explorer panel (explorer mode only)
				open_in_prev_tab = 'gf', -- Open current buffer in previous tab (or create one before)
				close_on_open_in_prev_tab = false, -- Close codediff tab after gf opens file in previous tab
				toggle_stage = '-', -- Stage/unstage current file (works in explorer and diff buffers)
				stage_hunk = '<leader>hs', -- Stage hunk under cursor to git index
				unstage_hunk = '<leader>hu', -- Unstage hunk under cursor from git index
				discard_hunk = '<leader>hr', -- Discard hunk under cursor (working tree only)
				hunk_textobject = 'ih', -- Textobject for hunk (vih to select, yih to yank, etc.)
				show_help = 'g?', -- Show floating window with available keymaps
				align_move = 'gm', -- Temporarily align moved code blocks across panes
				toggle_layout = 't', -- Toggle between side-by-side and inline layout
			},
			explorer = {
				select = 'o',
				hover = 'K', -- Show file diff preview
				refresh = 'R', -- Refresh git status
				toggle_view_mode = 'i', -- Toggle between 'list' and 'tree' views
				stage_all = 'S', -- Stage all files
				unstage_all = 'U', -- Unstage all files
				restore = 'X', -- Discard changes (restore file)
				toggle_changes = 'gu', -- Toggle Changes (unstaged) group visibility
				toggle_staged = 'gs', -- Toggle Staged Changes group visibility
				-- Fold keymaps (Vim-style)
				fold_open = 'zo', -- Open fold (expand current node)
				fold_open_recursive = 'zO', -- Open fold recursively (expand all descendants)
				fold_close = 'zc', -- Close fold (collapse current node)
				fold_close_recursive = 'zC', -- Close fold recursively (collapse all descendants)
				fold_toggle = 'za', -- Toggle fold (expand/collapse current node)
				fold_toggle_recursive = 'zA', -- Toggle fold recursively
				fold_open_all = 'zR', -- Open all folds in tree
				fold_close_all = 'zM', -- Close all folds in tree
			},
			history = {
				select = '<CR>', -- Select commit/file or toggle expand
				toggle_view_mode = 'i', -- Toggle between 'list' and 'tree' views
				refresh = 'R', -- Refresh history (re-fetch commits)
				-- Fold keymaps (Vim-style, apply to directory nodes only)
				fold_open = 'zo', -- Open fold (expand current node)
				fold_open_recursive = 'zO', -- Open fold recursively (expand all descendants)
				fold_close = 'zc', -- Close fold (collapse current node)
				fold_close_recursive = 'zC', -- Close fold recursively (collapse all descendants)
				fold_toggle = 'za', -- Toggle fold (expand/collapse current node)
				fold_toggle_recursive = 'zA', -- Toggle fold recursively
				fold_open_all = 'zR', -- Open all folds in tree
				fold_close_all = 'zM', -- Close all folds in tree
			},
			conflict = {
				accept_incoming = '<leader>ct', -- Accept incoming (theirs/left) change
				accept_current = '<leader>co', -- Accept current (ours/right) change
				accept_both = '<leader>cb', -- Accept both changes (incoming first)
				discard = '<leader>cx', -- Discard both, keep base
				-- Accept all (whole file) - uppercase versions
				accept_all_incoming = '<leader>cT', -- Accept ALL incoming changes
				accept_all_current = '<leader>cO', -- Accept ALL current changes
				accept_all_both = '<leader>cB', -- Accept ALL both changes
				discard_all = '<leader>cX', -- Discard ALL, reset to base
				next_conflict = ']x', -- Jump to next conflict
				prev_conflict = '[x', -- Jump to previous conflict
				diffget_incoming = '2do', -- Get hunk from incoming (left/theirs) buffer
				diffget_current = '3do', -- Get hunk from current (right/ours) buffer
			},
		},
	})
end

return M
