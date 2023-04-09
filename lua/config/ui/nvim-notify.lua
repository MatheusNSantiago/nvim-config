local M = {}


function M.setup()
	vim.cmd([[command! Notify lua require("telescope").extensions.notify.notify() ]])

	return {
		"rcarriga/nvim-notify",
		event = "BufReadPre",
		config = M.config,
	}
end

M.highlights = {
	NotifyBackground = { bg = "#000000" },
}

function M.config()
	local notify = require("notify")
	local icons = require("utils.icons")

	notify.setup({
		icons = {
			ERROR = icons.diagnostics.Error,
			WARN = icons.diagnostics.Warning,
			INFO = icons.diagnostics.Information,
			DEBUG = icons.ui.Bug,
			TRACE = icons.ui.Pencil,
		},
	})
	-- vim.notify = notify
end

return M
