local M = {}

function M.setup()
	return { ---@type LazyPluginSpec
		'sontungexpt/better-diagnostic-virtual-text',
		config = M.config,
	}
end


function M.config()
	require('better-diagnostic-virtual-text.api').format_line_chunks = M.format_line_chunks

	require('better-diagnostic-virtual-text').setup({
		ui = {
			wrap_line_after = false, -- wrap the line after this length to avoid the virtual text is too long
			left_kept_space = 3, --- the number of spaces kept on the left side of the virtual text, make sure it enough to custom for each line
			right_kept_space = 3, ------------------------------------ the number of spaces kept on the right side of the virtual text, make sure it enough to custom for each line
			arrow = '  ',
			up_arrow = '  ',
			down_arro = '  ',
			above = false, -- the virtual text will be displayed above the line
		},
		priority = 2003, -- the priority of virtual text
		inline = false,
	})
end

--- Format line chunks for virtual text display.
---
--- This function formats the line chunks for virtual text display, considering various options such as severity,
--- underline symbol, text offsets, and parts to be removed.
---
--- @param ui_opts table - The table of UI options. Should contain:
---     - arrow: The symbol used as the left arrow.
---     - up_arrow: The symbol used as the up arrow.
---     - down_arrow: The symbol used as the down arrow.
---     - left_kept_space: The space to keep on the left side.
---     - right_kept_space: The space to keep on the right side.
---     - wrap_line_after: The maximum line length to wrap after.
--- @param line_idx number - The index of the current line (1-based). It start from the cursor line to above or below depend on the above option.
--- @param line_msg string - The message to display on the line.
--- @param severity number - The severity level of the diagnostic (1 = Error, 2 = Warn, 3 = Info, 4 = Hint).
--- @param max_line_length number - The maximum length of the line.
--- @param lasted_line boolean - Whether this is the last line of the diagnostic message. Please check line_idx == 1 to know the first line before checking lasted_line because the first line can be the lasted line if the message has only one line.
--- @param virt_text_offset number - The offset for virtual text positioning.
--- @param should_display_below boolean - Whether to display the virtual text below the line. If above is true, this option will be whether the virtual text should be above
--- @param above_instead boolean - Display above or below
--- @param removed_parts table - A table indicating which parts should be deleted and make room for message (e.g., arrow, left_kept_space, right_kept_space).
--- @param diagnostic table - The diagnostic to display. see `:help vim.Diagnostic.` for more information.
--- @return table - A list of formatted chunks for virtual text display.
--- @see vim.api.nvim_buf_set_extmark
function M.format_line_chunks(
	ui_opts,
	line_idx,
	line_msg,
	severity,
	max_line_length,
	lasted_line,
	virt_text_offset,
	should_display_below,
	above_instead,
	removed_parts,
	diagnostic
)
	local SEVERITY_SUFFIXS = { 'Error', 'Warn', 'Info', 'Hint' }

	local chunks = {}
	local first_line = line_idx == 1
	local severity_suffix = SEVERITY_SUFFIXS[severity]

	local function hls(extend_hl_groups)
		local default_groups = {
			'DiagnosticVirtualText' .. severity_suffix,
			'BetterDiagnosticVirtualText' .. severity_suffix,
		}
		if extend_hl_groups then
			for i, hl in ipairs(extend_hl_groups) do
				default_groups[2 + i] = hl
			end
		end
		return default_groups
	end

	local message_highlight = hls()

	if should_display_below then
		local arrow_symbol = (above_instead and ui_opts.down_arrow or ui_opts.up_arrow):match('^%s*(.*)')
		local space_offset = M._space(virt_text_offset)
		if first_line then
			if not removed_parts.arrow then
				table.insert(chunks, {
					space_offset .. arrow_symbol,
					hls({ 'BetterDiagnosticVirtualTextArrow', 'BetterDiagnosticVirtualTextArrow' .. severity_suffix }),
				})
			end
		else
			table.insert(chunks, {
				space_offset .. M._space(vim.fn.strdisplaywidth(arrow_symbol)),
				message_highlight,
			})
		end
	else
		local arrow_symbol = ui_opts.arrow
		if first_line then
			if not removed_parts.arrow then
				table.insert(chunks, {
					arrow_symbol,
					hls({ 'BetterDiagnosticVirtualTextArrow', 'BetterDiagnosticVirtualTextArrow' .. severity_suffix }),
				})
			end
		else
			table.insert(chunks, {
				M._space(virt_text_offset + vim.fn.strdisplaywidth(arrow_symbol)),
				message_highlight,
			})
		end
	end

	if not removed_parts.left_kept_space then
		local tree_symbol = '   '
		if first_line then
			if not lasted_line then tree_symbol = above_instead and ' └ ' or ' ┌ ' end
		elseif lasted_line then
			tree_symbol = above_instead and ' ┌ ' or ' └ '
		else
			tree_symbol = ' │ '
		end
		table.insert(chunks, {
			tree_symbol,
			hls({ 'BetterDiagnosticVirtualTextTree', 'BetterDiagnosticVirtualTextTree' .. severity_suffix }),
		})
	end

	table.insert(chunks, {
		line_msg,
		message_highlight,
	})

	if not removed_parts.right_kept_space then
		local last_space = M._space(max_line_length - vim.fn.strdisplaywidth(line_msg) + ui_opts.right_kept_space)
		table.insert(chunks, { last_space, message_highlight })
	end

	return chunks
end


--- Generates a string of spaces of the specified length.
--- @param num integer The total number of spaces to generate.
--- @return string: A string consisting of `num` spaces.
M._space = function(num)
	if num < 1 then
		return ""
	elseif num < 160 then
		return string.rep(" ", num)
	end

	if num % 2 == 0 then
		-- 2, 4, 6, 8, 10, 12, 14, 16
		local presets =
			{ "  ", "    ", "      ", "        ", "          ", "            ", "              ", "                " }
		for i = 16, 4, -2 do
			if num % i == 0 then
				return string.rep(presets[i / 2], num / i)
			end
		end
		return string.rep(presets[1], num / 2)
	end

	-- 1, 3, 5, 7, 9, 11, 13, 15
	local presets = { " ", "   ", "     ", "       ", "         ", "           ", "             ", "               " }
	for i = 15, 3, -2 do
		if num % i == 0 then
			return string.rep(presets[(i + 1) / 2], num / i)
		end
	end
	return string.rep(presets[1], num)
end


return M
