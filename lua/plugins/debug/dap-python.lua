local M = {}

function M.setup()
	return { ---@type LazyPluginSpec
		'mfussenegger/nvim-dap-python',
		config = M.config,
		dependencies = { 'mfussenegger/nvim-dap' },
		lazy = true,
	}
end

function M.config()
	require('dap-python').setup('python', {})
	require('dap').configurations.python = {
		{
			type = 'python',
			request = 'launch',
			name = 'Launch file',
			program = '${file}',
		},
	}
end

return M
