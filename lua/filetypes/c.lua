---@type FiletypeSettings
return {
	mappings = {
		{
			'n',
			'<leader>r',
			function()
				vim.cmd('w')
				U.exec_cmd('gcc % -o exec; ./exec')
			end,
			desc = 'C: [R]un',
		},
	},
}
