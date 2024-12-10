local M = {}

function M.setup()
	return { ---@type LazyPluginSpec
		'supermaven-inc/supermaven-nvim',
		config = M.config,
		keys = {
			{ '<M-[>', function() M.request_completions() end, mode = 'i', desc = 'supermaven: request completion' },
		},
	}
end

M.request_completions = function()
	-- Remove o popup do cmp
	require('cmp').abort()

	local buffer = vim.api.nvim_get_current_buf()
	local buffer_lines = vim.api.nvim_buf_get_lines(buffer, 0, -1, false)
	local cursor = vim.api.nvim_win_get_cursor(0)

	local context = {
		document_text = table.concat(buffer_lines, '\n'),
		cursor = cursor,
		file_name = vim.api.nvim_buf_get_name(buffer),
	}

	local binary = M.get_binary()
	binary:provide_inline_completion_items(buffer, cursor, context)
end

function M.config()
	utils.api.augroup('supermaven_tweaks', {
		desc = 'Tira os extmarks (preview da completion)',
		event = 'InsertLeave',
		command = function() require('supermaven-nvim.completion_preview'):dispose_inlay() end,
	})

	require('supermaven-nvim').setup({
		ignore_filetypes = {},
		color = { suggestion_color = c.comments },
		log_level = 'off', -- set to "off" to disable logging completely
		disable_inline_completion = false, -- disables inline completion for use with cmp
		disable_keymaps = true, -- disables built in keymaps for more manual control
		condition = function() return true end, -- condition to check for stopping supermaven, `true` means to stop supermaven when the condition is true.
	})
end

M.get_binary = function()
	local binary = require('supermaven-nvim.binary.binary_handler')

	if not binary:is_running() then --
		binary:start_binary()
	end

	require('supermaven-nvim.document_listener'):teardown()
	return binary
end

M.is_suggestion_visible = function()
	local ok, suggestion = pcall(require, 'supermaven-nvim.completion_preview')
	return ok and suggestion.has_suggestion()
end

M.accept_sugestion = function()
	local suggestion = require('supermaven-nvim.completion_preview')
	suggestion.on_accept_suggestion()
	suggestion:dispose_inlay()
end

return M
