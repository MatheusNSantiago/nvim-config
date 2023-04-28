local M = {}

function M.setup()
	local is_installed, ssr = pcall(require, 'ssr')
	if is_installed then
		utils.api.keymap({ 'n', 'x' }, '<leader>sr', ssr.open, { desc = 'structured search and replace' })
	end

	return {
		'cshuaimin/ssr.nvim',
		module = 'ssr',
		config = M.config,
	}
end

function M.config()
	require('ssr').setup({
		border = 'rounded',
		min_width = 50,
		min_height = 5,
		max_width = 120,
		max_height = 25,
		keymaps = {
			close = 'q',
			next_match = 'n',
			prev_match = 'N',
			replace_confirm = '<cr>',
			replace_all = '<leader><cr>',
		},
	})
end

return M
