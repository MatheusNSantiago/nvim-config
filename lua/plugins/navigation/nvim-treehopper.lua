local M = {}
local keymap = utils.api.keymap

function M.setup()
	local is_installed, tsht = pcall(require, 'tsht')
	if is_installed then
		keymap('o', 'm', tsht.nodes, { desc = 'treehopper: toggle' })
		keymap('x', 'm', ":lua require('tsht').nodes()<CR>", { desc = 'treehopper: toggle' })
	end

	return {
		'mfussenegger/nvim-treehopper',
		config = M.config,
	}
end

function M.config()
	require('tsht').config.hint_keys = { 'ç', 'a', 'l', 's', 'k', 'd', 'j', 'f', 'w', 'o', 'e', 'i', 'c', 'm', 'v', 'n' }
end

return M
