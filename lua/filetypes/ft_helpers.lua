local M = {}

M.lazy_require = function(package)
	return function()
		local ok, pkg = pcall(require, package)
		return ok and pkg or {}
	end
end

---Abre um terminal e executa um comando
---@param cmd string
---@param term_number? number numero do terminal
M.exec = function(cmd, term_number) --
	vim.cmd(("%sTermExec cmd='%s'"):format(term_number or '', cmd))
end

return M
