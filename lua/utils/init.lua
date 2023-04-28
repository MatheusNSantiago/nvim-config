local M = {}

-- return all tables flattened into one
function M.flatten(tbl)
	local result = {}
	for _, sub_table in pairs(tbl) do
		if type(sub_table) == 'table' then
			for k, v in pairs(sub_table) do
				result[k] = v
			end
		end
	end
	return result
end

function M.set_hls(highlights)
	for group, hl in pairs(highlights) do
		vim.api.nvim_set_hl(0, group, hl)
	end
end

function M.get_repo_name()
	local full_path = vim.fn.trim(vim.fn.system('git rev-parse --show-toplevel'))
	local repo_name = vim.fn.fnamemodify(full_path, ':t')
	return repo_name
end

function M.log(msg, hl, name)
	name = name or 'Neovim'
	hl = hl or 'Todo'
	vim.api.nvim_echo({ { name .. ': ', hl }, { msg } }, true, {})
end

function M.warn(msg, name) vim.notify(msg, vim.log.levels.WARN, { title = name }) end

function M.error(msg, name) vim.notify(msg, vim.log.levels.ERROR, { title = name }) end

function M.info(msg, name) vim.notify(msg, vim.log.levels.INFO, { title = name }) end

function M.isempty(s) return s == nil or s == '' end

---Determine if a value of any type is empty
---@param item any
---@return boolean?
function M.falsy(item)
	if not item then return true end
	local item_type = type(item)
	if item_type == 'boolean' then return not item end
	if item_type == 'string' then return item == '' end
	if item_type == 'number' then return item <= 0 end
	if item_type == 'table' then return vim.tbl_isempty(item) end
	return item ~= nil
end

function M.get_buf_option(opt)
	local status_ok, buf_option = pcall(vim.api.nvim_buf_get_option, 0, opt)
	if not status_ok then
		return nil
	else
		return buf_option
	end
end

--- Convert a list or map of items into a value by iterating all it's fields and transforming
--- them with a callback
---@generic T, S
---@param callback fun(acc: S, item: T, key: string | number): S
---@param list T[]
---@param accum S?
---@return S
function M.fold(callback, list, accum)
	accum = accum or {}
	for k, v in pairs(list) do
		accum = callback(accum, v, k)
		assert(accum ~= nil, 'The accumulator must be returned on each iteration')
	end
	return accum
end

---@generic T:table
---@param callback fun(item: T, key: any)
---@param list table<any, T>
function M.foreach(callback, list)
	for k, v in pairs(list) do
		callback(v, k)
	end
end

---@generic T
---@param callback fun(item: T, key: string | number, list: T[]): T
---@param list T[]
---@return T[]
function M.map(callback, list)
	return M.fold(function(accum, v, k)
		accum[#accum + 1] = callback(v, k, accum)
		return accum
	end, list, {})
end

--- Call the given function and use `vim.notify` to notify of any errors
--- this function is a wrapper around `xpcall` which allows having a single
--- error handler for all errors
---@param msg string
---@param func function
---@param ... any
---@return boolean, any
---@overload fun(func: function, ...): boolean, any
function M.pcall(msg, func, ...)
	local args = { ... }
	if type(msg) == 'function' then
		local arg = func --[[@as any]]
		args, func, msg = { arg, unpack(args) }, msg, nil
	end
	return xpcall(func, function(err)
		msg = debug.traceback(msg and string.format('%s:\n%s', msg, err) or err)
		vim.schedule(function() vim.notify(msg, vim.log.levels.ERROR, { title = 'ERROR' }) end)
	end, unpack(args))
end

_G.utils = M
_G.utils.api = require('utils.api-wrappers')
_G.utils.ft_helpers = require('utils.filetype-helpers')

return M
