local M = {}

function M.setup()
	local is_installed = pcall(require, "colorizer")
	if is_installed then
		vim.api.nvim_create_autocmd(
			"BufEnter",
			{ command = [[ColorizerAttachToBuffer]] }
		)
	end
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
