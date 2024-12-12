local H = require('filetypes.ft_helpers')
local is_bb_project = function() return U.fs.is_wsl() and vim.fs.find('gaw-reverse-conf.json', {}) end

return {
	picker = {
		keymap = '<leader><leader>o',
		title = 'JS/TS',
		actions = {
			{
				name = 'Iniciar Projeto BB',
				handler = function()
					local pkg = U.fs.read_json('package.json')
					if not pkg then error('arquivo package.json não foi encontrado') end

					local node_version = pkg['engines']['node']

					H.exec(('nvm use %s; npm run start'):format(node_version))
					H.exec('gaw-rev', 2)

					vim.defer_fn(function() vim.cmd('wincmd k') end, 100)
				end,
				condition = is_bb_project,
			},
			{ name = 'npm run dev', handler = 'npm run start' },
			{ name = 'Iniciar LiveServer', handler = ':LiveServerStart<CR>' },
		},
	},
	opt = {
		updatetime = 200,
	},
	mappings = {
		-- { 'n', '<leader>r', function() H.exec('clear && npm run start') end },
	},
	autocommands = {
		{
			event = 'BufWritePost',
			desc = 'format on save',
			command = function() require('conform').format({ async = true }) end,
		},
	},
}
