---@type FiletypeSettings
return {
	picker = {
		keymap = '<leader><leader>o',
		title = 'Markdown',
		actions = {
			{ name = 'Ativar Preview', handler = ':MarkdownPreview<CR>' },
		},
	},
	bo = {
		tabstop = 3,
		shiftwidth = 3,
		softtabstop = 3,
	},
}
