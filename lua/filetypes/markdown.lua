---@type FiletypeSettings
return {
	picker = {
		keymap = '<leader><leader>o',
		title = 'Markdown',
		actions = {
			-- { name = 'Ativar Preview', handler = ':MarkdownPreview<CR>' },
		},
	},
	mappings = {
		{
			'x',
			'<C-b>',
			function()
				local text, range = U.get_visual_selection()
				utils.api.set_text({ text = '**' .. text .. '**', range = range })
			end,
			desc = 'markdown: [B]old',
		},
	},
	bo = {
		tabstop = 3,
		shiftwidth = 3,
		softtabstop = 3,
	},
}
