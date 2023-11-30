local U = require('filetypes.cobol.utils')
local add_indicator = require('filetypes.cobol.quick-add.working-storage.indicador')
local add_guarda = require('filetypes.cobol.quick-add.working-storage.guarda')
local add_contador = require('filetypes.cobol.quick-add.working-storage.contador')

local M = {}

function M.add_pic_under_cursor()
  local word = U.get_word_under_cursor()
  if not word then return end
  word = word:upper()

  if word:match('^GDA%-') then
    add_guarda(word)
  elseif word:match('^CNT%-') then
    add_contador(word)
  elseif word:match('^IND%-') then
    add_indicator(word)
  elseif word:match('^CND%-') then
    local indicator = word:gsub('CND%-', 'IND%-'):gsub('%-NAO', ''):gsub('%-SIM', '')
    add_indicator(indicator)
  else
    return print(word .. ' não se encaixa em nenhuma categoria')
  end

  -- centraliza a tela
  vim.cmd('normal! zz')
end

M.add_indicator = add_indicator
M.add_guarda = add_guarda
M.add_contador = add_contador

return M
