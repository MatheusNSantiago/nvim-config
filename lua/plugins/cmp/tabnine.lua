local M = {}

function M.setup()
	-- faz um prefetch na página toda. sem precisar esperar o cmp pedir
	local prefetch = vim.api.nvim_create_augroup("prefetch", { clear = true })
	vim.api.nvim_create_autocmd("BufRead", {
		group = prefetch,
		pattern = "*.{js,ts,jsx,tsx,py,dart,java,c,cpp,html,css}",
		callback = function()
			require("cmp_tabnine"):prefetch(vim.fn.expand("%:p"))
		end,
	})
	--
	require("cmp_tabnine.config").setup({
		max_lines = 1000,
		max_num_results = 3,
		sort = true,
		run_on_every_keystroke = true,
		snippet_placeholder = "..",
		ignored_file_types = {},
		show_prediction_strength = false,
	})
end

return M
