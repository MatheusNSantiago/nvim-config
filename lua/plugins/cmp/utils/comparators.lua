local M = {}

---@param entry1 cmp.Entry
--@param entry2 cmp.Entry
function M.prioritizeVariables(entry1, entry2)
	local types = require('cmp.types')
	local kind1 = types.lsp.CompletionItemKind[entry1:get_kind()]
	local kind2 = types.lsp.CompletionItemKind[entry2:get_kind()]

	if kind1 ~= kind2 then
		local is_in_the_file = entry2:get_offset() ~= 0
		local validFiletypes = not (vim.tbl_contains({ 'css' }, vim.bo.filetype))
		if kind1 ~= 'Variable' and kind2 == 'Variable' and is_in_the_file then return false end
	end
end

return M
