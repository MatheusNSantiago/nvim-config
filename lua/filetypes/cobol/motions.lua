local fn = vim.fn
local M = {}
local DELIMITER = '-'

function M.to_end_of_word()
  local actions = {
    normal = function() return M.feedkeys('e') end,
    move_till_delimiter = function() return M.feedkeys('t' .. DELIMITER) end,
    move_to_delimiter = function() return M.feedkeys('f' .. DELIMITER) end,
  }
  local col, line = fn.col('.'), fn.getline('.')
  local char = line:sub(col, col)

  local _, after = M.split_line_on_col(line, col)
  local words_after = M.get_all_words_on_line(after)

  -- MATHEUS NILO █ \nSANTIAGO -> MATHEUS NILO  \nSANTIAG█
  local has_valid_word_after = not words_after:is_empty()
  if not has_valid_word_after then return actions.normal() end

  -- MATHEUS-NIL█-SANTIAGO ... -> MATHEUS NILO█SANTIAGO ...
  local is_before_a_delimiter = line:sub(col + 1, col + 1) == DELIMITER
  if is_before_a_delimiter then return actions.move_to_delimiter() end

  -- MATHEUS-N█LO-SANTIAGO -> MATHEUS NIL█-SANTIAGO
  local hovered_word_after = words_after[1] -- o resto da word depois do cursor
  if M.has_delimiter(hovered_word_after) then return actions.move_till_delimiter() end

  -- MATHEU█ NILO-SANTIAGO -> MATHEUS NIL█-SANTIAGO
  local is_on_last_word = words_after:size() == 1
  if not is_on_last_word then
    local next_word = words_after[2]
    if M.has_delimiter(next_word) then return actions.move_till_delimiter() end
  end

  -- MATHEUS█NILO-SANTIAGO -> MATHEUS NIL█-SANTIAGO
  if char == ' ' then
    local next_word = words_after[2]
    if M.has_delimiter(next_word) then return actions.move_till_delimiter() end
  end

  return actions.normal()
end

function M.to_start_of_next_word()
  local actions = {
    normal = function() return M.feedkeys('w') end,
    move_till_delimiter = function() return M.feedkeys('t' .. DELIMITER) end,
    move_to_delimiter = function() return M.feedkeys('f' .. DELIMITER) end,
  }
  local col, line = fn.col('.'), fn.getline('.')
  local char = line:sub(col, col)

  local _, after = M.split_line_on_col(line, col)
  local words_after = M.get_all_words_on_line(after)

  -- MATHEUS NILO █ \nSANTIAGO -> MATHEUS NILO  \nSANTIAG█
  local has_valid_word_after = not words_after:is_empty()
  if not has_valid_word_after then return actions.normal() end

  -- MATHEU█ NILO-SANTIAGO -> MATHEUS █ILO-SANTIAGO
  local is_on_last_word = words_after:size() == 1
  if not is_on_last_word then
    local next_word = words_after[2]
    if M.has_delimiter(next_word) then return actions.move_till_delimiter() end
  end


--  ╾───────────────────────────────────────────────────────────────────────────────────╼
  -- MA█HEUS-NILO-SANTIAGO -> MATHEUS█NILO-SANTIAGO
  local curr_word = words_after[1]
  if M.has_delimiter(curr_word) then return actions.move_to_delimiter() end
end

-- function M.to_start_of_next_word(current_col)
--   local line, start_col = fn.getline('.'), current_col or fn.col('.')
--
--   local is_on_last_char = #line == 0 or start_col == #line
--   if is_on_last_char then return utils.api.feedkeys('w') end
--
--   local is_before_a_valid_word = function(chars) return chars:match('%W%w') end
--
--   -- Encontra a coluna do próximo delimitador
--   local chars
--   local end_col = start_col
--   while end_col < #line do
--     chars = line:sub(end_col, end_col + 1)
--
--     if is_before_a_valid_word(chars) then break end
--     end_col = end_col + 1
--   end
--
--   -- se o char anterior for um espaço, move o cursor pra frente e tentar de novo
--   local is_previous_char_space = chars:match('%s%w')
--   if is_previous_char_space then return fn.cursor({ 0, end_col + 1 }) end
--
--   local is_on_top_of_delimiter = end_col == start_col
--   if is_on_top_of_delimiter then return fn.cursor({ 0, end_col + 1 }) end
--
--   fn.cursor({ 0, end_col })
-- end

function M.start_of_previous_word(current_col)
  local line, start_col = fn.getline('.'), current_col or fn.col('.')

  local is_on_first_char = #line == 0 or start_col == 1
  if is_on_first_char then return utils.api.feedkeys('b') end

  -- Aqui eu represento o primeiro caractere como se fosse o anterior e o segundo como o atual
  local is_after_delimiter = function(chars) return chars:match('%W%w') end

  local chars
  local end_col = start_col
  while end_col > 0 do
    chars = line:sub(end_col, end_col + 1)

    if is_after_delimiter(chars) then break end
    end_col = end_col - 1
  end

  local is_delimiter_followed_by_word = (end_col - start_col) == -1
  if is_delimiter_followed_by_word then
    -- se o char anteriro for um espaço, move o cursor pra traz e tenta de novo
    local is_previous_char_space = line:sub(end_col, end_col):match('%s')
    if is_previous_char_space then return M.start_of_previous_word(end_col - 1) end

    -- move o cursor para a posição do delimitador
    return fn.cursor({ 0, end_col })
  end

  -- 77  SBDT-F8-AUX-DT-DMA          PIC  9(008).

  -- local is_previous_char_space = chars:match('%s%w')
  -- if is_previous_char_space then return fn.cursor({ 0, end_col + 1 }) end

  local is_on_top_of_delimiter = end_col == start_col
  if is_on_top_of_delimiter then return M.start_of_previous_word(end_col - 1) end
  --
  fn.cursor({ 0, end_col + 1 })
end

M.feedkeys = function(keys)
  if vim.fn.mode() == 'n' then
    -- vim visual multi só deixa controlar todos os cursores quando o modo é 'x'
    local is_on_multi_cursor = vim.b['VM_Selection']
    if is_on_multi_cursor then return utils.api.feedkeys(keys, 'x') end

    return utils.api.feedkeys(keys, 'n')
  end

  utils.api.feedkeys(keys, 'x')
end

---@return string | nil
M.split_line_on_col = function(line, col) return line:sub(1, col), line:sub(col + 1) end

M.get_all_words_on_line = function(line)
  local words = Array()
  local pattern = '[^%s]+'

  for word in line:gmatch(pattern) do
    words:push(word)
  end
  return words
end

M.has_delimiter = function(word) return word:match(DELIMITER) ~= nil end

return M
