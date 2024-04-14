local M = {}

function M.setup()
	return {
		'mfussenegger/nvim-dap',
		config = M.config,
		dependencies = { 'rcarriga/nvim-dap-ui' },
		lazy = true,
		keys = {
			{ '<leader>dap', desc = 'dap ui: toggle' },
			{ '<leader>db',  desc = 'dap: toggle breakpoint' },
			{ '<leader>dL',  desc = 'dap: set log breakpoint' },
			{ '<leader>dC',  desc = 'dap: set condition breakpoint' },
			{ '<leader>ds',  desc = 'dap: start/continue debug' },
			-- { '<leader>dl',  desc = 'dap: run last' },
			{ '<leader>dc',  desc = 'dap: run to cursor' },
			{ '<leader>dh',  desc = 'dap: hover' },
		},
	}
end

function M.config()
	require('plugins.debug.keymaps').setup()

	local dap_breakpoint = {
		breakpoint = {
			text = utils.icons.base.bug,
			texthl = 'LspDiagnosticsSignError',
			linehl = '',
			numhl = '',
		},
		rejected = {
			text = utils.icons.base.bug,
			texthl = 'LspDiagnosticsSignHint',
			linehl = '',
			numhl = '',
		},
		stopped = {
			text = utils.icons.ui.BoldArrowRight,
			texthl = 'LspDiagnosticsSignInformation',
			linehl = 'DiagnosticUnderlineInfo',
			numhl = 'LspDiagnosticsSignInformation',
		},
	}

	vim.fn.sign_define('DapBreakpoint', dap_breakpoint.breakpoint)
	vim.fn.sign_define('DapStopped', dap_breakpoint.stopped)
	vim.fn.sign_define('DapBreakpointRejected', dap_breakpoint.rejected)

	-- require('plugins.debug.ui').setup()
	-- require('plugins.debug.virtual-text').setup()
	require('plugins.debug.dap-python').setup()
end

M.highlights = {
	DapBreakpoint = { fg = c.red, bg = c.red },
	DapStopped = { fg = c.green },
}

return M
