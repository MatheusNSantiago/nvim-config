-- Limits LSP results to specific types based on line context (FIelds, Methods, Variables)
return function(entry, ctx)
	local types = require("cmp.types")

	local kind = types.lsp.CompletionItemKind
	local entry_kind = entry:get_kind()
	local col = vim.api.nvim_win_get_cursor(0)[2]
	local line = vim.api.nvim_get_current_line()

	local char_before = line:sub(col, col)
	local char_after = line:sub(col + 1, col + 1)

	-- Evita que mostre autocomplete no final de funções do python
	if char_before == ":" and char_after == "" then
		return false
	end

	if char_before == ":" and char_after:match("[a-zA-Z]") then
		return entry_kind == kind.Function
	end

	if char_before == "." and char_after:match("[a-zA-Z]") then
		return (entry_kind == kind.Method) or (entry_kind == kind.Field) or (entry_kind == kind.Property)
	end

	if string.match(line, "^%s+%w+$") then
		return entry_kind == kind.Function or entry_kind == kind.Variable
	end

	return true
end
