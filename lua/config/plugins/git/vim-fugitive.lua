local map = require("utils").map

local M = {}

function M.setup()
	map("n", "<leader>gs", ":Git add %<CR>", { desc = "[g]it [s]tage current file" })
	map("n", "<leader>gS", ":Git add .<CR>", { desc = "[G]it [S]tage all files" })
	map("n", "<leader>gc", ":Git commit<CR>", { desc = "[G]it [c]ommit" })
	map("n", "<leader>gp", ":Git push<CR>", { desc = "[G]it [p]ush" })

	return { "tpope/vim-fugitive" }
end

return M
