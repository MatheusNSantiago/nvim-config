local M = {}

function M.get_border(hl_name)
	return {
		{ "╭", hl_name },
		{ "─", hl_name },
		{ "╮", hl_name },
		{ "│", hl_name },
		{ "╯", hl_name },
		{ "─", hl_name },
		{ "╰", hl_name },
		{ "│", hl_name },
	}
end
--

-- M.buffer_option = {
-- 	-- Complete from all visible buffers (splits)
-- 	get_bufnrs = function()
-- 		local bufs = {}
-- 		for _, win in ipairs(vim.api.nvim_list_wins()) do
-- 			bufs[vim.api.nvim_win_get_buf(win)] = true
-- 		end
-- 		return vim.tbl_keys(bufs)
-- 	end,
-- }


return M
