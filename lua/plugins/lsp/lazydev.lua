local M = {}

function M.setup()
	return {
		'folke/lazydev.nvim',
		ft = 'lua',
		config = M.config,
		dependencies = {
			{ 'Bilal2453/luvit-meta', lazy = true }, -- optional `vim.uv` typings
		},
	}
end

function M.config()
	require('lazydev').setup({
		runtime = vim.env.VIMRUNTIME --[[@as string]],
		library = {
			-- Or relative, which means they will be resolved from the plugin dir.
			'lazy.nvim',
			-- always load the LazyVim library
			'LazyVim',
			'nvim-dap-ui',
		},

		integrations = {
			-- Fixes lspconfig's workspace management for LuaLS
			-- Only create a new workspace if the buffer is not part
			-- of an existing workspace or one of its libraries
			lspconfig = true,
			-- add the cmp source for completion of:
			-- `require "modname"`
			-- `---@module "modname"`
			cmp = true,
			-- same, but for Coq
			coq = false,
		},

		-- always enable unless `vim.g.lazydev_enabled = false`
		---@type boolean|(fun(root:string):boolean?)
		enabled = function(root_dir)
			return vim.g.lazydev_enabled == nil and true or vim.g.lazydev_enabled --
		end,
	})
end

return M
