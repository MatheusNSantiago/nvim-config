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
		-- diff = {
		-- 	disable_inlay_hints = true,
		-- },
		eplorer = {
			view_mode = 'tree',
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
			},
			explorer = {
				select = 'o',
				-- refresh = 'R',
			},
		},
	})
end

return M
