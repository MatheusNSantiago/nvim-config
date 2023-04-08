local M = {}

function M.setup()
	vim.api.nvim_create_autocmd(
		"BufEnter",
		{ command = [[ColorizerAttachToBuffer]] }
	)
	return {
		"norcalli/nvim-colorizer.lua",
		event = "BufRead",
		cmd = { "ColorizerToggle", "ColorizerAttachToBuffer", "ColorizerDetachFromBuffer", "ColorizerReloadAllBuffers" },
		config = M.config,
	}
end

function M.config()
	require("colorizer").setup({})
end

return M
