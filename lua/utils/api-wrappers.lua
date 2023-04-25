----------------------------------------------------------------------------------------------------
-- API Wrappers
----------------------------------------------------------------------------------------------------
-- Thin wrappers over API functions to make their usage easier/terser

local M = {}

local autocmd_keys = { "event", "buffer", "pattern", "desc", "command", "group", "once", "nested" }
--- Validate the keys passed to as.augroup are valid
---@param name string
---@param command Autocommand
local function validate_autocmd(name, command)
	local incorrect = utils.fold(function(accum, _, key)
		if not vim.tbl_contains(autocmd_keys, key) then
			table.insert(accum, key)
		end
		return accum
	end, command, {})

	if #incorrect > 0 then
		vim.schedule(function()
			local msg = "Incorrect keys: " .. table.concat(incorrect, ", ")
			vim.notify(msg, "error", { title = string.format("Autocmd: %s", name) })
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
---@field desc string
---@field event  string | string[] list of autocommand events
---@field pattern string | string[] list of autocommand patterns
---@field command string | fun(args: AutocmdArgs): boolean?
---@field nested  boolean
---@field once    boolean
---@field buffer  number

---Create an autocommand
---returns the group ID so that it can be cleared or manipulated.
---@param name string The name of the autocommand group
---@param ... Autocommand A list of autocommands to create
---@return number
function M.augroup(name, ...)
	local commands = { ... }
	assert(name ~= "User", "The name of an augroup CANNOT be User")
	assert(#commands > 0, string.format("You must specify at least one autocommand for %s", name))
	local id = vim.api.nvim_create_augroup(name, { clear = true })
	for _, autocmd in ipairs(commands) do
		validate_autocmd(name, autocmd)
		local is_callback = type(autocmd.command) == "function"
		vim.api.nvim_create_autocmd(autocmd.event, {
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
	vim.api.nvim_create_user_command(name, rhs, opts)
end

---A terser proxy for `nvim_replace_termcodes`
---@param str string
---@return string
function M.replace_termcodes(str)
	return vim.api.nvim_replace_termcodes(str, true, true, true)
end

return M
