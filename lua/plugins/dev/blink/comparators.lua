local M = {}

local function get_kind(entry)
	local kinds = require('cmp.types').lsp.CompletionItemKind
	return kinds[entry:get_kind()]
end

local function pattern_score(text, pattern)
	local _, _end = text:find(pattern)
	return _end or 0
end

local function buff_kind(kind, entry1, entry2)
	local kind1, kind2 = get_kind(entry1), get_kind(entry2)
	if (kind1 == kind) and not (kind2 == kind) then return true end
	if (kind2 == kind) and not (kind1 == kind) then return false end
end

function M.buff_variables(entry1, entry2)
	local kind1, kind2 = get_kind(entry1), get_kind(entry2)

	if kind1 ~= kind2 then
		local is_in_the_file = entry2:get_offset() ~= 0

		if kind1 ~= 'Variable' and kind2 == 'Variable' and is_in_the_file then
			return false --
		end
	end
end

M.buff_properties = function(entry1, entry2)
	return buff_kind('Field', entry1, entry2) --
end

M.nerf_dunder_python = function(entry1, entry2)
	if vim.bo.ft ~= 'python' then return end

	local label1 = entry1.completion_item.label
	local label2 = entry2.completion_item.label

	local dunder1_score = pattern_score(label1, '^__.+__$')
	local dunder2_score = pattern_score(label2, '^__.+__$')

	if dunder1_score > dunder2_score then
		return false
	elseif dunder1_score < dunder2_score then
		return true
	end
end

return M
