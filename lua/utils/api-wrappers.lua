local api = vim.api
----------------------------------------------------------------------------------------------------
-- API Wrappers
----------------------------------------------------------------------------------------------------
-- Thin wrappers over API functions to make their usage easier/terser

local M = {}

--- Gera um keymapping
---@param mode string|table Uma string representando o modo para o qual o mapeamento deve ser criado (por exemplo, "n", "i", "v", "x", etc.). Alternativamente, pode ser passado uma tabela contendo várias strings de modo para criar o mapeamento para vários modos.
---@param remap string A sequência de teclas a ser mapeada.
---@param command string | fun() A sequência de comandos ou a função que será executada quando o mapeamento for acionado
---@param opts table? Uma tabela de opções adicionais a serem passadas para a função `vim.keymap.set`. defaults `{ noremap = true, silent = true }`
function M.keymap(mode, remap, command, opts)
	local options = { noremap = true, silent = true }

	if opts then options = vim.tbl_extend('force', options, opts) end

	if type(mode) == 'table' and vim.tbl_contains(mode, 'i') then
		vim.keymap.set(mode, remap, '<ESC>' .. tostring(command), options)
	else
		vim.keymap.set(mode, remap, command, options)
	end
end

local autocmd_keys = { 'event', 'buffer', 'pattern', 'desc', 'command', 'group', 'once', 'nested' }

--- Validate the keys passed to as.augroup are valid
---@param name string
---@param command Autocommand
local function validate_autocmd(name, command)
	local incorrect = utils.fold(function(accum, _, key)
		if not vim.tbl_contains(autocmd_keys, key) then table.insert(accum, key) end
		return accum
	end, command, {})

	if #incorrect > 0 then
		vim.schedule(function()
			local msg = 'Incorrect keys: ' .. table.concat(incorrect, ', ')
			vim.notify(msg, vim.log.levels.ERROR, { title = string.format('Autocmd: %s', name) })
		end)
	end
end

---@class AutocmdArgs
---@field id number autocmd ID
---@field event string
---@field group string?
---@field buf number
---@field file string
---@field match string | number
---@field data any

---@class Autocommand
---@field desc string?
---@field event  string | string[] list of autocommand events
---@field pattern string | string[] | nil list of autocommand patterns
---@field command string | fun(args: AutocmdArgs): boolean?
---@field nested  boolean?
---@field once    boolean?
---@field buffer  number?

---Create an autocommand
---returns the group ID so that it can be cleared or manipulated.
---@param name string The name of the autocommand group
---@param ... Autocommand A list of autocommands to create
---@return number
function M.augroup(name, ...)
	local commands = { ... }
	assert(name ~= 'User', 'The name of an augroup CANNOT be User')
	assert(#commands > 0, string.format('You must specify at least one autocommand for %s', name))

	local id = api.nvim_create_augroup(name, { clear = true })
	for _, autocmd in ipairs(commands) do
		validate_autocmd(name, autocmd)
		local is_callback = type(autocmd.command) == 'function'

		api.nvim_create_autocmd(autocmd.event, {
			group = name,
			pattern = autocmd.pattern,
			desc = autocmd.desc,
			callback = is_callback and autocmd.command or nil,
			command = not is_callback and autocmd.command or nil,
			once = autocmd.once,
			nested = autocmd.nested,
			buffer = autocmd.buffer,
		})
	end
	return id
end

--- @class CommandArgs
--- @field args string
--- @field fargs table
--- @field bang boolean,

---Create an nvim command
---@param name string
---@param rhs string | fun(args: CommandArgs)
---@param opts table?
function M.command(name, rhs, opts)
	opts = opts or {}
	api.nvim_create_user_command(name, rhs, opts)
end

---A terser proxy for `nvim_replace_termcodes`
---@param str string
---@return string
function M.replace_termcodes(str) return api.nvim_replace_termcodes(str, true, true, true) end

---@param keys string
---@param mode string? defaults to 'n'
function M.feedkeys(keys, mode)
	vim.schedule(function()
		mode = mode or 'n'
		api.nvim_feedkeys(M.replace_termcodes(keys), mode, false)
	end)
end

---A terser proxy for `nvim_get_hl_by_name`
function M.get_hl_by_name(name)
	local hl = api.nvim_get_hl(0, {
		name = name,
		link = false,
	})
	return hl
end

return M
