-- Registra parsers customizados de forma que sobrevivam ao reload_parsers()
-- do nvim-treesitter. ts.install() chama reload_parsers() internamente, que
-- limpa package.loaded antes de validar a lista -- então parsers adicionados
-- via require('nvim-treesitter.parsers')[name] = ... somem antes da checagem.
-- A solução é interceptar o require via package.preload.

_G.__custom_ts_parsers = _G.__custom_ts_parsers or {}

local MODNAME = 'nvim-treesitter.parsers'

local function loader(modname)
	package.preload[modname] = nil
	local ok, result = pcall(require, modname)
	package.preload[modname] = loader
	if ok then
		for k, v in pairs(_G.__custom_ts_parsers) do result[k] = v end
		return result
	end
end

local M = {}

function M.register(name, install_info)
	local entry = { install_info = install_info }
	_G.__custom_ts_parsers[name] = entry

	if not _G.__custom_ts_parsers_interceptor then
		_G.__custom_ts_parsers_interceptor = true
		package.preload[MODNAME] = loader
	end

	local parsers = package.loaded[MODNAME]
	if parsers then parsers[name] = entry end
end

return M
