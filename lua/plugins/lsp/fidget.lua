local M = {}

function M.setup()
	return {
		"j-hui/fidget.nvim",
		event = "LspAttach",
		config = M.config,
	}
end

function M.config()
	require("fidget").setup({
		window = {
			blend = 0, -- set 0 if using transparent background, otherwise set 100
		},
	})
end

return M
