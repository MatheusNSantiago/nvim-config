local M = {}

function M.setup()
	-- make autopairs and completion work together
	local cmp_status_ok, cmp = pcall(require, "cmp")
	if cmp_status_ok then
		cmp.event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done({ tex = "" }))
	end

	return {
		"windwp/nvim-autopairs",
		config = M.config,
	}
end

function M.config()
	require("nvim-autopairs").setup({
		check_ts = true,
		ts_config = {
			lua = { "string", "source" },
			javascript = { "string", "template_string" },
			java = false,
		},
		disable_filetype = { "TelescopePrompt", "vim" },
		fast_wrap = {},
	})
end

return M
