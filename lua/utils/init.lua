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

function M.map(mode, remap, command, opts)
	local options = { noremap = true, silent = true }

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

function M.get_repo_name()
	local full_path = vim.fn.trim(vim.fn.system("git rev-parse --show-toplevel"))
	local repo_name = vim.fn.fnamemodify(full_path, ":t")
	return repo_name
end

function M.log(msg, hl, name)
	name = name or "Neovim"
	hl = hl or "Todo"
	vim.api.nvim_echo({ { name .. ": ", hl }, { msg } }, true, {})
end

function M.warn(msg, name)
	vim.notify(msg, vim.log.levels.WARN, { title = name })
end

function M.error(msg, name)
	vim.notify(msg, vim.log.levels.ERROR, { title = name })
end

function M.info(msg, name)
	vim.notify(msg, vim.log.levels.INFO, { title = name })
end

function M.isempty(s)
	return s == nil or s == ""
end

function M.get_buf_option(opt)
	local status_ok, buf_option = pcall(vim.api.nvim_buf_get_option, 0, opt)
	if not status_ok then
		return nil
	else
		return buf_option
	end
end

return M
