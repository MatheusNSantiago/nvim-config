-- Registra parsers customizados de forma que sobrevivam ao reload_parsers()
-- do nvim-treesitter. ts.install() chama reload_parsers() internamente, que
-- limpa package.loaded antes de validar a lista.
--
-- O require circular é o problema central: chamar require(modname) de dentro
-- de um loader para o mesmo modname faz o LuaJIT retornar true (sentinel de
-- detecção de ciclo) em vez da tabela. A solução captura os parsers base uma
-- única vez (sem require circular) e reconstrói a tabela em todo reload.

local MODNAME = 'nvim-treesitter.parsers'
_G.__custom_ts_parsers = _G.__custom_ts_parsers or {}

local _base_parsers = nil
local _base_captured = false

local function loader(modname)
	if not _base_captured then
		_base_captured = true
		-- Remove temporariamente nosso preload para o require interno
		-- usar o file loader (sem criar require circular)
		package.preload[modname] = nil
		local ok, base = pcall(require, modname)
		package.preload[modname] = loader
		if ok and type(base) == 'table' then _base_parsers = base end
	end

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
		package.preload[MODNAME] = loader
	end

	local parsers = package.loaded[MODNAME]
	if parsers then parsers[name] = entry end
end

return M
