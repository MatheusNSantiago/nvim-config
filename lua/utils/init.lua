local fn = vim.fn
local M = {}

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

function M.set_hls(highlights, ns)
	for group, hl in pairs(highlights) do
		vim.api.nvim_set_hl(ns or 0, group, hl)
	end
end

function M.error(msg, name) vim.notify(msg, vim.log.levels.ERROR, { title = name }) end

function M.warn(msg, name) vim.notify(msg, vim.log.levels.WARN, { title = name }) end

function M.falsy(item)
	if not item then return true end
	local item_type = type(item)
	if item_type == 'boolean' then return not item end
	if item_type == 'string' then return item == '' end
	if item_type == 'number' then return item <= 0 end
	if item_type == 'table' then return vim.tbl_isempty(item) end
	return item ~= nil
end

---Convert a list or map of items into a value by iterating all it's fields and transforming
---them with a callback
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

---@generic T
---@param list T[]
---@param callback fun(item: T, key: string | number, list: T[]): T
---@return T[]
function M.map(list, callback)
	return M.fold(function(accum, v, k)
		accum[#accum + 1] = callback(v, k, accum)
		return accum
	end, list, {})
end

---Call the given function and use `vim.notify` to notify of any errors
---this function is a wrapper around `xpcall` which allows having a single
---error handler for all errors
---@param msg string
---@param func function
---@param ... any
---@return boolean, any
---@overload fun(func: function, ...): boolean, any
function M.pcall(msg, func, ...)
	local args = { ... }
	if type(msg) == 'function' then
		local arg = func --[[@as any]]
		---@diagnostic disable-next-line: cast-local-type
		args, func, msg = { arg, unpack(args) }, msg, nil
	end
	return xpcall(func, function(err)
		msg = debug.traceback(msg and string.format('%s\n\n%s', msg, err) or err)
		vim.schedule(function() vim.notify(msg, vim.log.levels.ERROR, { title = 'ERROR' }) end)
	end, unpack(args))
end

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
function M.exec_cmd(cmd, term_number) --
	vim.cmd(("%sTermExec cmd='%s'"):format(term_number or '', cmd))
end

---Checks if the operating system is running on Windows Subsystem for Linux (WSL).
---@return boolean: True if running on WSL, false otherwise.
function M.is_wsl() return fn.system('grep microsoft /proc/version'):len() > 0 end

function M.is_linux() return not M.is_wsl() end

---Verifica se o Neovim foi aberto com um diretório como argumento (ex: nvim . ou nvim ~/projeto)
---ao invés de um arquivo específico (ex: nvim file.txt)
---@return boolean: True se foi aberto com diretório, false caso contrário
function M.was_nvim_opened_to_directory() return vim.fn.isdirectory(vim.v.argv[3]) == 1 end

function M.get_visual_selection()
	local ESC_FEEDKEY = vim.api.nvim_replace_termcodes('<ESC>', true, false, true)

	vim.api.nvim_feedkeys(ESC_FEEDKEY, 'n', true)
	vim.api.nvim_feedkeys('gv', 'x', false)
	vim.api.nvim_feedkeys(ESC_FEEDKEY, 'n', true)

	local _, start_line, start_col = unpack(fn.getpos("'<"))
	local _, end_line, end_col = unpack(fn.getpos("'>"))

	local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)

	-- Reduz a primeira/última linha de acordo com start_col/end_col.
	lines[#lines] = lines[#lines]:sub(1, end_col)
	lines[1] = lines[1]:sub(start_col)
	local content = table.concat(lines, '\n')

	return content
end

---@example:
---switch(a, {
---    ["meu nome"] = "MATHEUS",
---	   [2] = function()	print("Case 2") end,
---	   [{3, 'foo'}] = function()	print("Case 3 or foo") end,
---	   default = function()	print("default") end, <- pode ser omitido
---})
---@param param any
---@param case_table table
function M.switch(param, case_table)
	local expanded_table = {}
	for key, value in pairs(case_table) do
		if type(key) == 'table' then
			for _, v in ipairs(key) do
				expanded_table[v] = value
			end
		else
			expanded_table[key] = value
		end
	end

	return expanded_table[param]
end

function M.log(content)
	if Array.is_array(content) then content = content:to_table() end
	local txt = ''
	local function recursive_log(obj, cnt)
		cnt = cnt or 0
		if type(obj) == 'table' then
			txt = txt .. '\n' .. string.rep('\t', cnt) .. '{\n'
			cnt = cnt + 1

			for k, v in pairs(obj) do
				if type(k) == 'string' then txt = txt .. string.rep('\t', cnt) .. '["' .. k .. '"]' .. ' = ' end
				if type(k) == 'number' then txt = txt .. string.rep('\t', cnt) .. '[' .. k .. ']' .. ' = ' end

				recursive_log(v, cnt)
				txt = txt .. ',\n'
			end

			cnt = cnt - 1
			txt = txt .. string.rep('\t', cnt) .. '}'
		elseif type(obj) == 'string' then
			txt = txt .. string.format('%q', obj)
		else
			txt = txt .. tostring(obj)
		end
	end
	recursive_log(content)

	vim.notify(txt)
end

M.api = require('utils.api-wrappers')
M.icons = require('utils.icons')
M.fs = require('utils.fs')
M.directory_watcher = require('utils.directory-watcher')

_G.c = require('utils.colors')

_G.Class = require('utils.class')
_G.Array = require('utils.array')
_G.create_picker = require('plugins.navigation.telescope.picker')
_G.utils = M
_G.U = M

return M
