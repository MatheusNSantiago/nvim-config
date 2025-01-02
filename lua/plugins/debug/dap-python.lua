local M = {}

function M.setup()
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
