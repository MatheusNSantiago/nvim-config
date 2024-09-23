local M = {}

local schemas = require('schemastore').json.schemas() --

-- Desativar schemastore no trabalho
-- Download de schemas no pc do trabalho dá problema de certificado
if utils.is_wsl() then schemas = {} end

M.settings = {
	json = {
		schemas = schemas,
		validate = { enable = true },
	},
}

return M
