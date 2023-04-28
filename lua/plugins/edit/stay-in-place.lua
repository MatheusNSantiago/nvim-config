local M = {}
local keymap = utils.api.keymap
local is_installed, sip = pcall(require, 'stay-in-place')

function M.setup()
	if is_installed then
		keymap('n', '>', sip.shift_right, { noremap = true, expr = true })
		keymap('n', '<', sip.shift_left, { noremap = true, expr = true })
		keymap('n', '=', sip.filter, { noremap = true, expr = true })

		keymap('n', '>', sip.shift_right_line, { noremap = true })
		keymap('n', '<', sip.shift_left_line, { noremap = true })
		keymap('n', '==', sip.filter_line, { noremap = true })

		keymap('x', '>', sip.shift_right_visual, { noremap = true })
		keymap('x', '<', sip.shift_left_visual, { noremap = true })
		keymap('x', '=', sip.filter_visual, { noremap = true })
	end

	return {
		'gbprod/stay-in-place.nvim',
		config = M.config,
	}
end

function M.config()
	require('stay-in-place').setup({
		set_keymaps = false,
	})
end

return M
