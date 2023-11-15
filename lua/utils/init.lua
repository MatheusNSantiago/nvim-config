local fn = vim.fn
local M = {}

--Return all tables flattened into one
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

function M.warn(msg, name) vim.notify(msg, vim.log.levels.WARN, { title = name }) end

function M.log(content)
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

    vim.api.nvim_echo({ { txt } }, false, {})
end

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

function M.get_current_line_with_cursor()
    local current_line = fn.getline('.')
    local col = fn.col('.')
    return current_line:sub(1, col) .. '█' .. current_line:sub(col + 1)
end

---@param pattern (string) The pattern to match against the current line.
---@return boolean: Returns true if the current line matches the pattern, false otherwise.
function M.current_line_matches(pattern)
    local cur_line = M.get_current_line_with_cursor()
    return cur_line:match(pattern)
end

---Checks if the operating system is running on Windows Subsystem for Linux (WSL).
---@return boolean: True if running on WSL, false otherwise.
function M.is_os_running_on_wsl() return fn.system('grep microsoft /proc/version'):len() > 0 end

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

---Restringe a execução de uma função a um intervalo de tempo definido.
---@param func function: A função a ser limitada.
---@param delay number: O tempo mínimo, em milissegundos, para esperar entre as execuções da função.
---@return function: Uma nova função que envolve a função original com lógica de limitação.
function M.throttle(func, delay)
    local lastExecuted = 0
    return function(...)
        local now = vim.loop.now()
        if (now - lastExecuted) >= delay then
            func(...)
            lastExecuted = now
        end
    end
end

M.api = require('utils.api-wrappers')
M.icons = require('utils.icons')
M.ft_helpers = require('utils.filetype-helpers')

_G.c = require('utils.colors')
_G.log = M.log
_G.create_picker = require('plugins.navigation.telescope.picker')
_G.utils = M

return M
