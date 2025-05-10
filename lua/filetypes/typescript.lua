local is_bb_project = function() return U.fs.is_wsl() and vim.fs.find('gaw-reverse-conf.json', {}) end

return {
	picker = {
		keymap = '<leader><leader>o',
		title = 'Typescript',
		actions = {
			{
				name = 'Iniciar Projeto BB',
				handler = function()
					local pkg = U.fs.read_json('package.json')
					if not pkg then error('arquivo package.json não foi encontrado') end

					local node_version = pkg['engines']['node']

					U.exec_cmd(('nvm use %s; npm run start'):format(node_version))
					U.exec_cmd('gaw-rev', 2)

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
		{
			'n',
			'<leader>ff',
			function()
				require('conform').format({ async = true }, function()
					-- vim.cmd('TSToolsSortImports')
					-- vim.cmd('TSToolsRemoveUnusedImports')
				end)
			end,
		},
	},
}
