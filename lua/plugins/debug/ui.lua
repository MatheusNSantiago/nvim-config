---@diagnostic disable: missing-fields
local M = {}

function M.setup()
	local dap = require('dap')
	local dapui = require('dapui')

	vim.fn.sign_define('DapBreakpoint', {
		text = utils.icons.base.bigCircle,
		texthl = 'DiagnosticError',
		linehl = '',
		numhl = '',
	})
	vim.fn.sign_define('DapStopped', {
		text = utils.icons.ui.BoldArrowRight,
		texthl = 'DiagnosticInfo',
		linehl = 'DiagnosticInfo',
		numhl = 'DiagnosticInfo',
	})
	vim.fn.sign_define('DapBreakpointRejected', {
		text = utils.icons.base.bug,
		texthl = 'DiagnosticHint',
		linehl = '',
		numhl = '',
	})

	dapui.setup({
		expand_lines = true,
		icons = { expanded = '', collapsed = '', circular = '' },
		mappings = {
			expand = { '<CR>', '<2-LeftMouse>' },
			open = 'o',
			remove = 'd',
			edit = 'e',
			repl = 'r',
			toggle = 't',
		},
		layouts = {
			{
				elements = {
					{ id = 'scopes', size = 0.33 },
					{ id = 'breakpoints', size = 0.17 },
					{ id = 'stacks', size = 0.25 },
					{ id = 'watches', size = 0.25 },
				},
				size = 0.33,
				position = 'right',
			},
			{
				elements = {
					{ id = 'repl', size = 0.45 },
					{ id = 'console', size = 0.55 },
				},
				size = 0.27,
				position = 'bottom',
			},
		},
		floating = {
			max_height = 0.9,
			max_width = 0.5, -- Floats will be treated as percentage of your screen.
			border = 'rounded', -- Border style. Can be 'single', 'double' or 'rounded'
			mappings = {
				close = { 'q', '<Esc>' },
			},
		},
	}) -- use default
	dap.listeners.after.event_initialized['dapui_config'] = function() dapui.open() end
	dap.listeners.before.event_terminated['dapui_config'] = function() dapui.close() end
	dap.listeners.before.event_exited['dapui_config'] = function() dapui.close() end
end

return M
