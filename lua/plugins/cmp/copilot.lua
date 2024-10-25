local M = {}

function M.setup()
	-- require('copilot_cmp').setup({
	-- 	formatters = {
	-- 		label = require('copilot_cmp.format').format_label_text,
	-- 		insert_text = require('copilot_cmp.format').remove_existing,
	-- 		preview = require('copilot_cmp.format').deindent,
	-- 	},
	-- })
	--
	-- require('copilot').setup({
	-- 	panel = {
	-- 		enabled = false,
	-- 		auto_refresh = false,
	-- 		keymap = {
	-- 			jump_prev = '<M-[>',
	-- 			jump_next = '<M-]>',
	-- 			accept = '<CR>',
	-- 			refresh = 'gr',
	-- 			open = '<M-CR>',
	-- 		},
	-- 		layout = {
	-- 			position = 'bottom', -- | top | left | right
	-- 			ratio = 0.4,
	-- 		},
	-- 	},
	-- 	suggestion = {
	-- 		enabled = true,
	-- 		auto_trigger = false,
	-- 		debounce = 75,
	-- 		keymap = {
	-- 			-- accept = '<S-ç>', --"<C-f>",
	-- 			accept_word = false,
	-- 			accept_line = false,
	-- 			next = '<M-]>',
	-- 			prev = '<M-[>',
	-- 			-- jump_next = "<M-]>", --"<C-n>",
	-- 			-- dismiss = "<ESC>",
	-- 		},
	-- 	},
	-- 	filetypes = {
	-- 		help = false,
	-- 		['*'] = true,              -- disable for all other filetypes and ignore default `filetypes`
	-- 	},
	-- 	copilot_node_command = 'node', -- Node.js version must be > 16.x
	-- })
end

return M
