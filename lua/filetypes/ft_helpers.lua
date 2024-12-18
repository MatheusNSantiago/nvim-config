local M = {}

M.lazy_require = function(package, ...)
	local keys = { ... }
	return function()
		local ok, pkg = pcall(require, package)
		if not ok then return {} end

		local result = pkg
		for _, key in ipairs(keys) do
			result = result[key]
			if result == nil then return {} end
		end

		return result
	end
end

---Abre um terminal e executa um comando
---@param cmd string
---@param term_number? number numero do terminal
M.exec = function(cmd, term_number) --
	vim.cmd(("%sTermExec cmd='%s'"):format(term_number or '', cmd))
end

return M
