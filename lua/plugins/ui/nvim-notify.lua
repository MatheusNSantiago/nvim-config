local M = {}

function M.setup()
	local is_installed, notify = pcall(require, "notify")
	if is_installed then
		vim.cmd([[command! Notify lua require("telescope").extensions.notify.notify() ]])

		utils.map("n", "<leader>nd", function()
			notify.dismiss({ silent = true, pending = true })
		end, { desc = "Dismiss notification" })

		utils.map("n", "<leader><leader>n", function()
			require("telescope").extensions.notify.notify()
		end, { desc = "Show notifications" })

		vim.notify = notify
	end

	return {
		"rcarriga/nvim-notify",
		config = M.config,
	}
end

function M.config()
	local notify = require("notify")
	local icons = require("utils.icons")
	notify.setup({
		render = "default",
		level = 2,
		stages = "fade_in_slide_out",
		fpg = 30,
		background_colour = "#121212",
		timeout = 2000,
		max_width = 120,
		icons = {
			ERROR = icons.diagnostics.Error,
			WARN = icons.diagnostics.Warning,
			INFO = icons.diagnostics.Information,
			DEBUG = icons.ui.Bug,
			TRACE = icons.ui.Pencil,
		},
		top_down = true,
	})
end

M.highlights = {
	NotifyERRORBorder = { link = "DiagnosticError" },
	NotifyWARNBorder = { link = "DiagnosticWarn" },
	NotifyINFOBorder = { link = "DiagnosticInfo" },
	NotifyHINTBorder = { link = "DiagnosticHint" },
	NotifyDEBUGBorder = { link = "Debug" },
	NotifyTRACEBorder = { link = "Comment" },
	NotifyERRORIcon = { link = "DiagnosticError" },
	NotifyWARNIcon = { link = "DiagnosticWarn" },
	NotifyINFOIcon = { link = "DiagnosticInfo" },
	NotifyHINTIcon = { link = "DiagnosticHint" },
	NotifyDEBUGIcon = { link = "Debug" },
	NotifyTRACEIcon = { link = "Comment" },
	NotifyERRORTitle = { link = "DiagnosticError" },
	NotifyWARNTitle = { link = "DiagnosticWarn" },
	NotifyINFOTitle = { link = "DiagnosticInfo" },
	NotifyHINTTitle = { link = "DiagnosticHint" },
	NotifyDEBUGTitle = { link = "Debug" },
	NotifyTRACETitle = { link = "Comment" },
}

return M
