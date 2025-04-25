local M = {}

function M.setup()
	return { ---@type LazyPluginSpec
		'zbirenbaum/copilot.lua',
		config = M.config,
		keys = {
			{ '<M-[>', mode = { 'i' } },
			{ '<M-]>', mode = { 'i' } },
		},
	}
end

function M.config()
	require('copilot').setup({
		panel = { enabled = false },
		suggestion = {
			enabled = true,
			auto_trigger = false,
			debounce = 75,
			keymap = {
				-- accept = '<S-ç>', --"<C-f>",
				accept_word = false,
				accept_line = false,
				next = '<M-]>',
				prev = '<M-[>',
				-- jump_next = "<M-]>", --"<C-n>",
				-- dismiss = "<ESC>",
			},
		},
		filetypes = {
			help = false,
			['*'] = true, -- disable for all other filetypes and ignore default `filetypes`
		},
		copilot_node_command = 'node', -- Node.js version must be > 16.x
	})
end

return M
