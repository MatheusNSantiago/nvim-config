local M = {}
local map = require("utils").map
local is_installed, sip = pcall(require, "stay-in-place")

function M.setup()
	if is_installed then
		map("n", ">", sip.shift_right, { noremap = true, expr = true })
		map("n", "<", sip.shift_left, { noremap = true, expr = true })
		map("n", "=", sip.filter, { noremap = true, expr = true })

		map("n", ">", sip.shift_right_line, { noremap = true })
		map("n", "<", sip.shift_left_line, { noremap = true })
		map("n", "==", sip.filter_line, { noremap = true })

		map("x", ">", sip.shift_right_visual, { noremap = true })
		map("x", "<", sip.shift_left_visual, { noremap = true })
		map("x", "=", sip.filter_visual, { noremap = true })
	end

	return {
		"gbprod/stay-in-place.nvim",
		config = M.config,
	}
end

function M.config()
	require("stay-in-place").setup({
		set_keymaps = false,
	})
end

return M
