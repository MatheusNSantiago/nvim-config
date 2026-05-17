local M = {}

function M.setup()
	return { ---@type LazyPluginSpec
		'zbirenbaum/copilot.lua',
		config = M.config,
		lazy = false,
		-- keys = {
		-- 	{ '<M-]>', mode = { 'i' } },
		-- 	{ '<M-[>', mode = { 'i' } },
		-- },
		-- cmd = 'Copilot',
	}
end

function M.config()
	require('copilot').setup({
		panel = { enabled = false },
		suggestion = {
			enabled = true,
			auto_trigger = false,
			debounce = 75,
			hide_during_completion = true,
			trigger_on_accept = true,
			keymap = {
				accept = false,
				accept_word = false,
				accept_line = false,
				next = false,
				prev = false,
				dismiss = false,
			},
		},
		disable_limit_reached_message = true,
		filetypes = {
			help = false,
			['*'] = true, -- disable for all other filetypes and ignore default `filetypes`
		},
		copilot_node_command = 'node', -- Node.js version must be > 16.x
	})
	M.setup_suggestion_keymaps()
end

function M.repair_blink_keymaps()
	local blink_ok, blink = pcall(require, 'plugins.dev.blink')
	if blink_ok then blink.repair_keymaps() end
end

function M.setup_suggestion_keymaps()
	vim.keymap.set('i', '<M-]>', function()
		M.repair_blink_keymaps()
		require('copilot.suggestion').next()
	end, { desc = '[copilot] next suggestion', silent = true })

	vim.keymap.set('i', '<M-[>', function()
		M.repair_blink_keymaps()
		require('copilot.suggestion').prev()
	end, { desc = '[copilot] prev suggestion', silent = true })
end

return M
