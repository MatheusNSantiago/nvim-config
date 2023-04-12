local M = {}

function M.deprioritize_snippet(entry1, entry2)
	local types = require("cmp.types")

	if entry1:get_kind() == types.lsp.CompletionItemKind.Snippet then
		return false
	end
	if entry2:get_kind() == types.lsp.CompletionItemKind.Snippet then
		return true
	end
end

return M
