local M = {}

M.cmd = { 'lua-language-server' }
M.settings = {
	Lua = {
		completion = { callSnippet = 'Replace' },
		diagnostics = { globals = { 'vim', 'bit', 'packer_plugins' } },
		runtime = { version = 'LuaJIT' },
		workspace = { checkThirdParty = false },
		telemetry = { enable = false },
	},
}

return M
