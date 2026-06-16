local M = {}

M.cmd = { 'lua-language-server' }
M.settings = {
	Lua = {
		completion = { callSnippet = 'Replace' },
		hint = { enable = false },
		codeLens = { enable = false },
		diagnostics = {
			globals = { 'vim', 'bit', 'packer_plugins' },
			disable = { 'missing-fields' },
		},
		runtime = { version = 'LuaJIT' },
		telemetry = { enable = false },
	},
}

return M
