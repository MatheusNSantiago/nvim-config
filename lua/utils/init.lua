local M = {}

-- return all tables flattened into one
function M.flatten(tbl)
	local result = {}
	for _, sub_table in pairs(tbl) do
		if type(sub_table) == "table" then
			for k, v in pairs(sub_table) do
				result[k] = v
			end
		end
	end
	return result
end

---@diagnostic disable-next-line: lowercase-global
function M.map(mode, remap, command, opts)
	local options = { noremap = true }

	if opts then
		options = vim.tbl_extend("force", options, opts)
	end

	if type(mode) == "table" and vim.tbl_contains(mode, "i") then
		vim.keymap.set(mode, remap, "<ESC>" .. tostring(command), options)
	else
		vim.keymap.set(mode, remap, command, options)
	end
end

function M.set_hls(highlights)
	for group, hl in pairs(highlights) do
		vim.api.nvim_set_hl(0, group, hl)
	end
end


return M
