vim.keymap.set({ "n", "i" }, "<C-A-a>", function()
	local col = vim.api.nvim_win_get_cursor(0)[2]
	local line = vim.api.nvim_get_current_line()

	local char = line:sub(col, col)
	local next_char = line:sub(col + 1, col + 1)
	print(char, next_char == "")
end)
