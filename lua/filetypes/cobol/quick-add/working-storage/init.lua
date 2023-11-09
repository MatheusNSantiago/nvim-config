local U = require('filetypes.cobol.quick-add.working-storage.utils')
local add_indicator = require('filetypes.cobol.quick-add.working-storage.indicador')
local add_guarda = require('filetypes.cobol.quick-add.working-storage.guarda')
local add_contador = require('filetypes.cobol.quick-add.working-storage.contador')

local M = {}

function M.quick_add_to_WS()
  local word = U.get_word_under_cursor()
  if not word then return end
  word = word:upper()

  if word:match('^GDA%-') then return add_guarda(word) end
  if word:match('^CNT%-') then return add_contador(word) end
  if word:match('^IND%-') then return add_indicator(word) end
  if word:match('^CND%-') then
    local indicator = word:gsub('CND%-', 'IND%-'):gsub('%-NAO', ''):gsub('%-SIM', '')
    add_indicator(indicator)
  end
end

return M
