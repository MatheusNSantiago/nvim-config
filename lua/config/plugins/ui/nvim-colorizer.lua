local M = {}

function M.setup()
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
