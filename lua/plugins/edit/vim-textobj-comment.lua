local M = {}
local keymap = utils.api.keymap

function M.setup()
	keymap({ 'x', 'o' }, 'ax', '<Plug>(textobj-comment-a)')
	keymap({ 'x', 'o' }, 'ix', '<Plug>(textobj-comment-i)')

	return {
		'glts/vim-textobj-comment',
		config = M.config,
	}
end

function M.config()
	vim.g.textobj_comment_no_default_key_mappings = 1
end

return M
