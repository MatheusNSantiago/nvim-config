local M = {}

function M.setup()
	local is_installed, notify = pcall(require, "notify")
	if is_installed then
		utils.map("n", "<leader>nd", function()
			notify.dismiss({ silent = true, pending = true })
		end, { desc = "Dismiss notification" })

		vim.cmd([[command! Notify lua require("telescope").extensions.notify.notify() ]])
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
	-- hl(0, "NotifyERRORBorder", { fg = "#8A1F1F", bg = "NONE" })
	-- hl(0, "NotifyWARNBorder", { fg = "#79491D", bg = "NONE" })
	-- hl(0, "NotifyINFOBorder", { fg = c.ui_blue, bg = "NONE" })
	-- hl(0, "NotifyDEBUGBorder", { fg = c.gray, bg = "NONE" })
	-- hl(0, "NotifyTRACEBorder", { fg = "#4F3552", bg = "NONE" })
	-- hl(0, "NotifyERRORIcon", { fg = c.error, bg = "NONE" })
	-- hl(0, "NotifyWARNIcon", { fg = c.warn, bg = "NONE" })
	-- hl(0, "NotifyINFOIcon", { fg = c.ui4_blue, bg = "NONE" })
	-- hl(0, "NotifyDEBUGIcon", { fg = c.gray, bg = "NONE" })
	-- hl(0, "NotifyTRACEIcon", { fg = c.ui_purple, bg = "NONE" })
	-- hl(0, "NotifyERRORTitle", { fg = c.error, bg = "NONE" })
	-- hl(0, "NotifyWARNTitle", { fg = c.warn, bg = "NONE" })
	-- hl(0, "NotifyINFOTitle", { fg = c.ui4_blue, bg = "NONE" })
	-- hl(0, "NotifyDEBUGTitle", { fg = c.gray, bg = "NONE" })
	-- hl(0, "NotifyTRACETitle", { fg = c.ui_purple, bg = "NONE" })
	--
}

return M
