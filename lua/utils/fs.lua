---@diagnostic disable: undefined-field
local M = {}

---Checa se o OS está rodando no WSL
---@return boolean: True if running on WSL, false otherwise.
M.is_wsl = function() return vim.fn.system('grep microsoft /proc/version'):len() > 0 end

---@type boolean
M.is_windows = vim.loop.os_uname().version:match('Windows')

---@param ... string
---@return boolean
M.any_exists = function(...)
	for _, name in ipairs({ ... }) do
		if M.exists(name) then return true end
	end
	return false
end

---@param filepath string
---@return boolean
M.exists = function(filepath)
	local stat = vim.loop.fs_stat(filepath)
	return stat ~= nil and stat.type ~= nil
end

---@return string
M.join = function(...)
	local sep = M.is_windows and '\\' or '/'
	local joined = table.concat({ ... }, sep)
	if M.is_windows then
		joined = joined:gsub('\\\\+', '\\')
	else
		joined = joined:gsub('//+', '/')
	end
	return joined
end

M.is_absolute = function(path)
	if M.is_windows then
		return path:lower():match('^%a:')
	else
		return vim.startswith(path, '/')
	end
end

M.abspath = function(path)
	if not M.is_absolute(path) then path = vim.fn.fnamemodify(path, ':p') end
	return path
end

--- Returns true if candidate is a subpath of root, or if they are the same path.
---@param root string
---@param candidate string
---@return boolean
M.is_subpath = function(root, candidate)
	if candidate == '' then return false end
	root = vim.fs.normalize(M.abspath(root))
	-- Trim trailing "/" from the root
	if root:find('/', -1) then root = root:sub(1, -2) end
	candidate = vim.fs.normalize(M.abspath(candidate))
	if M.is_windows then
		root = root:lower()
		candidate = candidate:lower()
	end
	if root == candidate then return true end
	local prefix = candidate:sub(1, root:len())
	if prefix ~= root then return false end

	local candidate_starts_with_sep = candidate:find('/', root:len() + 1, true) == root:len() + 1
	local root_ends_with_sep = root:find('/', root:len(), true) == root:len()

	return candidate_starts_with_sep or root_ends_with_sep
end

M.get_stdpath_filename = function(stdpath, ...)
	local ok, dir = pcall(vim.fn.stdpath, stdpath)
	if not ok then
		if stdpath == 'log' then
			return M.get_stdpath_filename('cache', ...)
		elseif stdpath == 'state' then
			return M.get_stdpath_filename('data', ...)
		else
			error(dir)
		end
	end
	return M.join(dir, ...)
end

---@param filepath string
---@return string?
M.read = function(filepath)
	if not M.exists(filepath) then return nil end
	local fd = assert(vim.loop.fs_open(filepath, 'r', 420)) -- 0644
	local stat = assert(vim.loop.fs_fstat(fd))
	local content = vim.loop.fs_read(fd, stat.size)
	vim.loop.fs_close(fd)
	return content
end

---@param filepath string
---@return table?
M.read_json = function(filepath)
	local content = M.read(filepath)
	if content then return vim.json.decode(content) end
end

---@param dir? string (opcional) diretório que será procurado os arguivos. Usa o cwd por padrão
---@return Array files Lista com os nomes dos arquivos
M.list_files = function(dir)
	dir = dir or vim.fn.getcwd()
	local fd = vim.loop.fs_opendir(dir, nil, 32)
	local entries = vim.loop.fs_readdir(fd)
	local ret = {}
	while entries do
		for _, entry in ipairs(entries) do
			if entry.type == 'file' then table.insert(ret, entry.name) end
		end
		entries = vim.loop.fs_readdir(fd)
	end
	vim.loop.fs_closedir(fd)
	return ret
end

---@param dirname string
---@param perms? number
M.mkdir = function(dirname, perms)
	if not perms then
		perms = 493 -- 0755
	end
	if not M.exists(dirname) then
		local parent = vim.fs.dirname(dirname)
		if not M.exists(parent) then M.mkdir(parent) end
		vim.loop.fs_mkdir(dirname, perms)
	end
end

---@param filename string
---@param contents string
M.write = function(filename, contents)
	M.mkdir(vim.fn.fnamemodify(filename, ':p:h'))
	local fd = assert(vim.loop.fs_open(filename, 'w', 420)) -- 0644
	vim.loop.fs_write(fd, contents)
	vim.loop.fs_close(fd)
end

---@param filename string
M.delete_file = function(filename)
	if M.exists(filename) then
		vim.loop.fs_unlink(filename)
		return true
	end
end

---@param filename string
---@param obj any
M.write_json = function(filename, obj)
	local serialized = vim.json.encode(obj)
	M.write(filename, serialized)
end

return M
