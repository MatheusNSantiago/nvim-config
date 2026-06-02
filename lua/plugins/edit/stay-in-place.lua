local M = {}

local function when_modifiable(fn)
	return function()
		if not vim.bo.modifiable then return end
		return fn()
	end
end

local function expr_when_modifiable(fn)
	return function()
		if not vim.bo.modifiable then return '<Ignore>' end
		return fn()
	end
end


function M.setup()
	return {
		'gbprod/stay-in-place.nvim',
		config = M.config,
		ft = { 'cobol' },
		keys = {
			{ '>', expr_when_modifiable(function() return require('stay-in-place').shift_right() end), mode = 'n', noremap = true, expr = true },
			{ '<', expr_when_modifiable(function() return require('stay-in-place').shift_left() end), mode = 'n', noremap = true, expr = true },
			{ '=', expr_when_modifiable(function() return require('stay-in-place').filter() end), mode = 'n', noremap = true, expr = true },
			{ '>>', when_modifiable(function() require('stay-in-place').shift_right_line() end), mode = 'n', noremap = true },
			{ '<<', when_modifiable(function() require('stay-in-place').shift_left_line() end), mode = 'n', noremap = true },
			{ '==', when_modifiable(function() require('stay-in-place').filter_line() end), mode = 'n', noremap = true },
			{ '>', when_modifiable(function() require('stay-in-place').shift_right_visual() end), mode = 'x', noremap = true },
			{ '<', when_modifiable(function() require('stay-in-place').shift_left_visual() end), mode = 'x', noremap = true },
		},
	}
end

function M.config() require('stay-in-place').setup({ set_keymaps = false }) end

return M
