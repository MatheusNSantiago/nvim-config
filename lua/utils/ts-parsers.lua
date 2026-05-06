local MODNAME = 'nvim-treesitter.parsers'
_G.__custom_ts_parsers = _G.__custom_ts_parsers or {}

local _base_parsers = nil
local _base_captured = false

local function capture_base()
	if _base_captured then return end
	_base_captured = true

	-- Preferência: módulo já carregado
	local current = package.loaded[MODNAME]
	if type(current) == 'table' then
		_base_parsers = current
		return
	end

	-- Carrega o arquivo diretamente, sem passar pelo require
	-- (evita problemas com cache_loader e require circular)
	local paths = vim.api.nvim_get_runtime_file('lua/nvim-treesitter/parsers.lua', false)
	local path = paths and paths[1]
	if not path then return end

	local fn = loadfile(path)
	if not fn then return end

	local ok, result = pcall(fn)
	if ok and type(result) == 'table' then
		_base_parsers = result
	end
end

local function loader(modname)
	capture_base()

	local result = {}
	if _base_parsers then
		for k, v in pairs(_base_parsers) do result[k] = v end
	end
	for k, v in pairs(_G.__custom_ts_parsers) do result[k] = v end
	package.loaded[modname] = result
	return result
end

local M = {}

function M.register(name, install_info)
	local entry = { install_info = install_info }
	_G.__custom_ts_parsers[name] = entry

	if package.preload[MODNAME] ~= loader then
		capture_base()
		package.preload[MODNAME] = loader
	end

	local parsers = package.loaded[MODNAME]
	if type(parsers) == 'table' then parsers[name] = entry end
end

return M
