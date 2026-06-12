local M = {}

local kinds = require('blink.cmp.types').CompletionItemKind

local function pattern_score(text, pattern)
	local _, _end = text:find(pattern)
	return _end or 0
end

local function is_kind(item, kind)
	return item.kind == kinds[kind] or item.kind_name == kind
end

local function is_any_kind(item, expected_kinds)
	for _, kind in ipairs(expected_kinds) do
		if is_kind(item, kind) then return true end
	end
	return false
end

local function prefer_kind(kind, item1, item2)
	local item1_is_kind = is_kind(item1, kind)
	local item2_is_kind = is_kind(item2, kind)

	if item1_is_kind ~= item2_is_kind then return item1_is_kind end
end

local function is_dunder_python(item)
	return pattern_score(item.label, '^__.+__$') > 0
end

local function is_private_python(item)
	return item.label:find('^_') ~= nil
end

local function python_member_priority(item)
	local callable = is_any_kind(item, { 'Method', 'Function', 'Constructor' })
	local data = is_any_kind(item, { 'Field', 'Property', 'Variable' })

	if is_dunder_python(item) then return 50 end
	if callable and not is_private_python(item) then return 0 end
	if data and not is_private_python(item) then return 10 end
	if callable then return 20 end
	if data then return 30 end
	if is_private_python(item) then return 40 end
	return 10
end

function M.python_public_members_first(item1, item2)
	if vim.bo.ft ~= 'python' then return end

	local priority1 = python_member_priority(item1)
	local priority2 = python_member_priority(item2)

	if priority1 ~= priority2 then return priority1 < priority2 end
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
