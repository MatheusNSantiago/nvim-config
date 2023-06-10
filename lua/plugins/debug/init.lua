local M = {}

function M.setup()
	require('plugins.debug.keymaps').setup()

	return {
		'mfussenegger/nvim-dap',
		config = M.config,
	}
end

function M.config()
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

	require('plugins.debug.ui').setup()
	require('plugins.debug.python').setup()
	require('plugins.debug.virtual-text').setup()

end

M.highlights = {
	DapBreakpoint = { fg = utils.c.red, bg = utils.c.red },
	DapStopped = { fg = utils.c.green },
}

return M
