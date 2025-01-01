---@type FiletypeSettings
return {
	picker = {
		keymap = '<leader><leader>o',
		title = 'Rust',
		actions = {},
	},
	mappings = {
		{
			'n',
			'<leader>r',
			function()
				U.exec_cmd('clear && cargo run')
				vim.defer_fn(function() vim.cmd('stopinsert') end, 100)
			end,
		},
	},
}
