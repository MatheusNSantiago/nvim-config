local M = {}

M.cmd = { 'lua-language-server' }
M.settings = {
	Lua = {
		completion = { callSnippet = 'Replace' },
		diagnostics = {
			globals = { 'vim', 'bit', 'packer_plugins' },
			disable = { 'missing-fields' },
		},
		runtime = { version = 'LuaJIT' },
		telemetry = { enable = false },
	},
}

return M
