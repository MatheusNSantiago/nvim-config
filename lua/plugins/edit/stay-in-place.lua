local M = {}

function M.setup()
	return {
		'gbprod/stay-in-place.nvim',
		config = M.config,
		ft = {'cobol'},
		keys = M.keys,
	}
end

function M.keys()
	local is_installed, sip = pcall(require, 'stay-in-place')
	if not is_installed then return end

	return {
		{ '>',  sip.shift_right,        mode = 'n', noremap = true, expr = true },
		{ '<',  sip.shift_left,         mode = 'n', noremap = true, expr = true },
		{ '=',  sip.filter,             mode = 'n', noremap = true, expr = true },
		{ '>',  sip.shift_right_line,   mode = 'n', noremap = true },
		{ '<',  sip.shift_left_line,    mode = 'n', noremap = true },
		{ '==', sip.filter_line,        mode = 'n', noremap = true },
		{ '>',  sip.shift_right_visual, mode = 'x', noremap = true },
		{ '<',  sip.shift_left_visual,  mode = 'x', noremap = true },
		{ '=',  sip.filter_visual,      mode = 'x', noremap = true },
	}
end

function M.config() require('stay-in-place').setup({ set_keymaps = false }) end

return M
