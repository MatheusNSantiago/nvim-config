-- When specifying 'preset' in the keymap table, the custom key mappings are merged with the preset,
-- and any conflicting keys will overwrite the preset mappings.
-- The "fallback" command will run the next non blink keymap.
--
-- Example:
--
-- keymap = {
--   preset = 'default',
--   ['<Up>'] = { 'select_prev', 'fallback' },
--   ['<Down>'] = { 'select_next', 'fallback' },
--
--   -- disable a keymap from the preset
--   ['<C-e>'] = {},
--
--   -- show with a list of providers
--   ['<C-space>'] = { function(cmp) cmp.show({ providers = { 'snippets' } }) end },
--
--   -- note that your function will often be run in a "fast event" where most vim.api functions will throw an error
--   -- you may want to wrap your function in `vim.schedule` or use `vim.schedule_wrap`
--   ['<C-space>'] = { function(cmp) vim.schedule(function() your_behavior end) },
--
--   -- optionally, define different keymaps for cmdline
--   cmdline = {
--     preset = 'super-tab'
--   }
-- }
--
-- When defining your own keymaps without a preset, no keybinds will be assigned automatically.
--
-- Available commands:
--   show, hide, cancel, accept, select_and_accept, select_prev, select_next, show_documentation, hide_documentation,
--   scroll_documentation_up, scroll_documentation_down, snippet_forward, snippet_backward, fallback
--
-- "default" keymap
--   ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
--   ['<C-e>'] = { 'hide' },
--   ['<C-y>'] = { 'select_and_accept' },
--
--   ['<C-p>'] = { 'select_prev', 'fallback' },
--   ['<C-n>'] = { 'select_next', 'fallback' },
--
--   ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
--   ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
--
--   ['<Tab>'] = { 'snippet_forward', 'fallback' },
--   ['<S-Tab>'] = { 'snippet_backward', 'fallback' },
--
-- "super-tab" keymap
--   you may want to set `completion.trigger.show_in_snippet = false`
--   or use `completion.list.selection = "manual" | "auto_insert"`
--
--   ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
--   ['<C-e>'] = { 'hide', 'fallback' },
--
--   ['<Tab>'] = {
--     function(cmp)
--       if cmp.snippet_active() then return cmp.accept()
--       else return cmp.select_and_accept() end
--     end,
--     'snippet_forward',
--     'fallback'
--   },
--   ['<S-Tab>'] = { 'snippet_backward', 'fallback' },

local is_copilot_suggestion_visible = function() --
	local copilot_ok, suggestion = pcall(require, 'copilot.suggestion')
	return copilot_ok and suggestion.is_visible()
end

local accept_copilot_sugestion = function() --
	local copilot_ok, suggestion = pcall(require, 'copilot.suggestion')
	if copilot_ok then
		suggestion.accept()
		return true
	end
end

return { ---@type table<string, blink.cmp.KeymapCommand[]>
	['<C-space>'] = { 'show', 'hide' },
	['<CR>'] = {
		function(cmp)
			if is_copilot_suggestion_visible() then return accept_copilot_sugestion() end
			if cmp.snippet_active() then
				return cmp.accept()
			else
				return cmp.select_and_accept()
			end
		end,
		'accept',
		'fallback',
	},

	['<Tab>'] = { 'snippet_forward', 'fallback' },
	['<S-Tab>'] = { 'snippet_backward', 'fallback' },

	['<Up>'] = { 'select_prev', 'fallback' },
	['<C-l>'] = { 'select_prev', 'fallback' },
	['<Down>'] = { 'select_next', 'fallback' },
	['<C-k>'] = { 'select_next', 'fallback' },

	['<C-d>'] = { 'scroll_documentation_up', 'fallback' },
	['<C-u>'] = { 'scroll_documentation_down', 'fallback' },
	cmdline = {
		preset = 'super-tab',
		['<C-l>'] = { 'select_prev', 'fallback' },
		['<C-k>'] = { 'select_next', 'fallback' },
	},
}

-- return {
-- 	preset = 'default',
-- 	['<Up>'] = { 'select_prev', 'fallback' },
-- 	['<Down>'] = { 'select_next', 'fallback' },
--
-- 	-- disable a keymap from the preset
-- 	['<C-e>'] = {},
--
-- 	-- show with a list of providers
-- 	['<C-space>'] = { function(cmp) cmp.show({ providers = { 'snippets' } }) end },
--
-- 	-- note that your function will often be run in a "fast event" where most vim.api functions will throw an error
-- 	-- you may want to wrap your function in `vim.schedule` or use `vim.schedule_wrap`
-- 	-- ['<C-space>'] = { function(cmp) vim.schedule(function() your_behavior end) },
--
-- 	-- optionally, define different keymaps for cmdline
-- 	cmdline = {
-- 		preset = 'super-tab',
-- 	},
-- }
-- --  ╾───────────────────────────────────────────────────────────────────────────────────╼
-- return function()
-- 	local cmp = require('cmp')
-- 	local luasnip = require('luasnip')
-- 	local types = require('cmp.types.cmp')
-- 	local neogen = require('neogen')
--
-- 	---@param direction "forward"|"backward"
-- 	local function tabout_or_fallback(direction, fallback)
-- 		local direction_flag = direction == 'forward' and 0 or 1
--
-- 		local col_before = vim.api.nvim_win_get_cursor(0)[2]
-- 		vim.cmd(string.format('lua tabhula_handler(%s)', direction_flag))
-- 		local col_after = vim.api.nvim_win_get_cursor(0)[2]
--
-- 		local has_cursor_moved = col_before ~= col_after
-- 		if not has_cursor_moved then fallback() end
-- 	end
--
-- 	local function shift_tab(fallback)
-- 		if luasnip.jumpable(-1) then
-- 			luasnip.jump(-1)
-- 		elseif neogen.jumpable(-1) then
-- 			neogen.jump_prev()
-- 		else
-- 			tabout_or_fallback('backward', fallback)
-- 		end
-- 	end
--
-- 	local function tab(fallback)
-- 		if luasnip.jumpable() then
-- 			luasnip.jump(1)
-- 		elseif neogen.jumpable() then
-- 			neogen.jump_next()
-- 		else
-- 			tabout_or_fallback('forward', fallback)
-- 		end
-- 	end
--
--
-- 	return cmp.mapping.preset.insert({
-- 		['<C-l>'] = cmp.mapping.select_prev_item({ behavior = types.SelectBehavior.Select }),
-- 		['<C-p>'] = cmp.mapping.select_prev_item({ behavior = types.SelectBehavior.Select }),
-- 		--
-- 		['<C-k>'] = cmp.mapping.select_next_item({ behavior = types.SelectBehavior.Select }),
-- 		['<C-n>'] = cmp.mapping.select_next_item({ behavior = types.SelectBehavior.Select }),
-- 		--
-- 		['<C-u>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
-- 		['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
-- 		--
-- 		['<C-Space>'] = cmp.mapping(function()
-- 			if cmp.visible() then
-- 				cmp.abort()
-- 			else
-- 				cmp.complete()
-- 			end
-- 		end, { 'i', 'c' }),
-- 		['<Tab>'] = cmp.mapping(tab, { 'i', 's' }),
-- 		['<S-Tab>'] = cmp.mapping(shift_tab, { 'i', 's' }),
-- 		['<CR>'] = cmp.mapping(function(fallback)
-- 			if is_copilot_suggestion_visible() then
-- 				accept_copilot_sugestion()
-- 				return
-- 			end
--
-- 			if cmp.visible() then
-- 				cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }, function()
-- 					cmp.complete()
-- 					-- if luasnip.expandable() then expand() end
-- 				end)
--
-- 				return
-- 			end
--
-- 			fallback()
-- 		end, { 'i', 's' }),
--
-- 		['<ESC>'] = cmp.mapping({
-- 			i = function(_)
-- 				cmp.abort()
-- 				vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<ESC>', true, true, true), 'n', true)
-- 			end,
-- 			c = cmp.mapping.close(),
-- 		}),
-- 	})
-- end
