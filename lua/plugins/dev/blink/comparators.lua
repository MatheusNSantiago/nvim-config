local M = {}

local kinds = require('blink.cmp.types').CompletionItemKind

local function pattern_score(text, pattern)
	local _, _end = text:find(pattern)
	return _end or 0
end

local function is_kind(item, kind)
	return item.kind == kinds[kind] or item.kind_name == kind
end

local function prefer_kind(kind, item1, item2)
	local item1_is_kind = is_kind(item1, kind)
	local item2_is_kind = is_kind(item2, kind)

	if item1_is_kind ~= item2_is_kind then return item1_is_kind end
end

function M.variables_first(item1, item2)
	return prefer_kind('Variable', item1, item2)
end

function M.fields_first(item1, item2)
	return prefer_kind('Field', item1, item2)
end

function M.nerf_dunder_python(item1, item2)
	if vim.bo.ft ~= 'python' then return end

	local dunder1_score = pattern_score(item1.label, '^__.+__$')
	local dunder2_score = pattern_score(item2.label, '^__.+__$')

	if dunder1_score > dunder2_score then
		return false
	elseif dunder1_score < dunder2_score then
		return true
	end
end

return M
