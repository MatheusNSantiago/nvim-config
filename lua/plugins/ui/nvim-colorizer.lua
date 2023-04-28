local M = {}

function M.setup()
	local is_installed = pcall(require, "colorizer")

	if is_installed then
		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, { command = [[ColorizerAttachToBuffer]] })
	end

	return {
		"norcalli/nvim-colorizer.lua",
		config = M.config,
	}
end

function M.config()
	require("colorizer").setup({
		filetypes = { "*" },
		user_default_options = {
			names = false,
			tailwind = "both",
			mode = "background",
		},
	})
end

return M
