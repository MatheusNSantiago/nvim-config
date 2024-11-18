---@type FiletypeSettings
return {
	picker = {
		keymap = '<leader><leader>o',
		title = 'JS/TS',
		actions = {
			{
				name = 'Iniciar Projeto BB',
				handler = function()
					vim.cmd("TermExec cmd='nvm use v18; npm run start'")
					vim.cmd("2TermExec cmd='gaw-rev'")
					vim.defer_fn(function() vim.cmd('stopinsert') end, 100)
				end,
			},
			{ name = 'npm run dev', handler = 'npm run start' },
			{ name = 'Iniciar LiveServer', handler = ':LiveServerStart<CR>' },
		},
	},
	opt = {
		updatetime = 200,
	},
	mappings = {
		{ 'n', '<leader>r', ":TermExec cmd='clear && npm run start'<CR>" },
	},
	autocommands = {
		{
			event = 'BufWritePost',
			desc = 'format on save',
			command = function() require('conform').format({ async = true }) end,
		},
	},
}
