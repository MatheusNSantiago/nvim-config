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

		-- workspace = {
		-- 	checkThirdParty = true,
		-- 	-- make the language server aware of runtime files
		-- 	library = {
		-- 		[vim.fn.expand('$VIMRUNTIME/lua')] = true,
		-- 		[vim.fn.stdpath('config') .. '/lua'] = true,
		-- 	},
		-- },
	},
}

return M
