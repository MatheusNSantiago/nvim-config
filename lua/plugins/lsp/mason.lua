local M = {}

function M.setup()
	return {
		'williamboman/mason.nvim',
		init = function()
			vim.env.CGO_ENABLED = '0'
		end,
		config = M.config,
		cmd = 'Mason',
		build = ':MasonUpdate', -- updates registry contents
	}
end

function M.config()
	require('mason').setup({
		registries = {
			'github:nvim-java/mason-registry',
			'github:mason-org/mason-registry',
		},
		ui = {
			border = 'rounded',
			icons = {
				package_installed = '✓',
				package_uninstalled = '✗',
				package_pending = '⟳',
			},
		},
	})
end

return M
