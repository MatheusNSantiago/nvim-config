return function()
	local cmp = require('cmp')
	local luasnip = require('luasnip')
	local types = require('cmp.types.cmp')
	local neogen = require('neogen')

	---@param direction "forward"|"backward"
	local function tabout_or_fallback(direction, fallback)
		local direction_flag = direction == 'forward' and 0 or 1

		local col_before = vim.api.nvim_win_get_cursor(0)[2]
		vim.cmd(string.format('lua tabhula_handler(%s)', direction_flag))
		local col_after = vim.api.nvim_win_get_cursor(0)[2]

		local has_cursor_moved = col_before ~= col_after
		if not has_cursor_moved then fallback() end
	end

	local function shift_tab(fallback)
		if luasnip.jumpable(-1) then
			luasnip.jump(-1)
		elseif neogen.jumpable(-1) then
			neogen.jump_prev()
		else
			tabout_or_fallback('backward', fallback)
		end
	end

	local function tab(fallback)
		if luasnip.jumpable() then
			luasnip.jump(1)
		elseif neogen.jumpable() then
			neogen.jump_next()
		else
			tabout_or_fallback('forward', fallback)
		end
	end

	--- Hack que deixa expandir o snippet em seleções incompletas sem perder acesso os jumps
	-- local function expand()
	-- 	local expand_params
	-- 	local snip
	-- 	local next_expand = luasnip.next_expand
	-- 	local next_expand_params = luasnip.next_expand_params
	-- 	local util = require('luasnip.util.util')
	-- 	local snippet_collection = require('luasnip.session.snippet_collection')
	--
	-- 	-- find snip via next_expand (set from previous expandable()) or manual matching.
	-- 	if next_expand ~= nil then
	-- 		snip = next_expand
	-- 		expand_params = next_expand_params
	--
	-- 		next_expand = nil
	-- 		next_expand_params = nil
	-- 	else
	-- 		snip, expand_params =
	-- 			snippet_collection.match_snippet(util.get_current_line_to_cursor(), util.get_snippet_filetypes(), 'snippets')
	-- 	end
	-- 	if snip then
	-- 		local cursor = util.get_cursor_0ind()
	-- 		-- override snip with expanded copy.
	-- 		snip = luasnip.snip_expand(snip, {
	-- 			expand_params = expand_params,
	-- 			-- clear trigger-text.
	-- 			clear_region = {
	-- 				from = {
	-- 					cursor[1],
	-- 					cursor[2] - #expand_params.trigger,
	-- 				},
	-- 				to = cursor,
	-- 			},
	-- 			jump_into_func = function(snippet)
	-- 				luasnip.session.jump_active = true
	-- 				return snippet.jump_into(snippet, 1)
	-- 			end,
	-- 		})
	-- 		return true
	-- 	end
	-- 	return false
	-- end

	local is_copilot_suggestion_visible = function() --
		return require('plugins.dev.supermaven').is_suggestion_visible()
	end

	local accept_copilot_sugestion = function() --
		return require('plugins.dev.supermaven').accept_sugestion()
	end

	return cmp.mapping.preset.insert({
		['<C-l>'] = cmp.mapping.select_prev_item({ behavior = types.SelectBehavior.Select }),
		['<C-p>'] = cmp.mapping.select_prev_item({ behavior = types.SelectBehavior.Select }),
		--
		['<C-k>'] = cmp.mapping.select_next_item({ behavior = types.SelectBehavior.Select }),
		['<C-n>'] = cmp.mapping.select_next_item({ behavior = types.SelectBehavior.Select }),
		--
		['<C-u>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
		['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
		--
		['<C-Space>'] = cmp.mapping(function()
			if cmp.visible() then
				cmp.abort()
			else
				cmp.complete()
			end
		end, { 'i', 'c' }),
		['<Tab>'] = cmp.mapping(tab, { 'i', 's' }),
		['<S-Tab>'] = cmp.mapping(shift_tab, { 'i', 's' }),
		['<CR>'] = cmp.mapping(function(fallback)
			if is_copilot_suggestion_visible() then
				accept_copilot_sugestion()
				return
			end

			if cmp.visible() then
				cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }, function()
					cmp.complete()
					-- if luasnip.expandable() then expand() end
				end)

				return
			end

			fallback()
		end, { 'i', 's' }),

		['<ESC>'] = cmp.mapping({
			i = function(_)
				cmp.abort()
				vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<ESC>', true, true, true), 'n', true)
			end,
			c = cmp.mapping.close(),
		}),
	})
end
