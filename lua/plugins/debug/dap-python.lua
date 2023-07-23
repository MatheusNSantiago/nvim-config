local M = {}

function M.setup()
	require('dap-python').setup('python', {})
	table.insert(require('dap').configurations.python, {
		type = 'python',
		request = 'attach',
		connect = {
			port = 5678,
			host = '127.0.0.1',
		},
		mode = 'remote',
		name = 'Container Attach Debug',
		cwd = vim.fn.getcwd(),
	})
end

return M
