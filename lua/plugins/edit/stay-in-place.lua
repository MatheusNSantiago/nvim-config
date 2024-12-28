local M = {}

function M.setup()
	return {
		'gbprod/stay-in-place.nvim',
		config = M.config,
		ft = { 'cobol' },
		keys = {
			{ '>', function() require('stay-in-place').shift_right() end, mode = 'n', noremap = true, expr = true },
			{ '<', function() require('stay-in-place').shift_left() end, mode = 'n', noremap = true, expr = true },
			{ '=', function() require('stay-in-place').filter() end, mode = 'n', noremap = true, expr = true },
			{ '>', function() require('stay-in-place').shift_right_line() end, mode = 'n', noremap = true },
			{ '<', function() require('stay-in-place').shift_left_line() end, mode = 'n', noremap = true },
			{ '>', function() require('stay-in-place').shift_right_visual() end, mode = 'x', noremap = true },
			{ '<', function() require('stay-in-place').shift_left_visual() end, mode = 'x', noremap = true },
		},
	}
end

function M.config() require('stay-in-place').setup({ set_keymaps = false }) end

return M
