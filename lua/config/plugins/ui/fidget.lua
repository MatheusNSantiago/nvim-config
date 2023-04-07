local M = {}

function M.setup()
	return {
		"j-hui/fidget.nvim",
		config = M.config
	}
end

function M.config()
	require("fidget").setup({
		text = {
			spinner = "pipe",
			done = "✔",
			commenced = "Started",
			completed = "Completed",
		},
		align = {
			bottom = true,
			right = true,
		},
		window = {
			relative = "win",
			blend = 10,
			zindex = nil,
			border = "none",
		},
		timer = {
			spinner_rate = 125,
			fidget_decay = 2000,
			task_decay = 1000,
		},
		fmt = {
			leftpad = true,
			stack_upwards = true,
			max_width = 0,
			fidget = function(fidget_name, spinner)
				return string.format("%s %s", spinner, fidget_name)
			end,
			task = function(task_name, message, percentage)
				return string.format(
					"%s%s [%s]",
					message,
					percentage and string.format(" (%.0f%%)", percentage) or "",
					task_name
				)
			end,
		},
		sources = {},
		debug = {
			logging = false,
			strict = false,
		},
	})
end

return M
