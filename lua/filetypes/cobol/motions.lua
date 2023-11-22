local fn = vim.fn
local M = {}

function M.to_end_of_word(current_col)
  local line, start_col = fn.getline('.'), current_col or fn.col('.')

  local is_on_last_char = #line == 0 or start_col == #line
  if is_on_last_char then return utils.api.feedkeys('e') end

  local is_delimiter = function(char) return char:match('%W') end

  -- Encontra a coluna do próximo delimitador
  local end_col = start_col
  while end_col <= #line do
    local char = line:sub(end_col, end_col)

    if is_delimiter(char) then break end
    end_col = end_col + 1
  end

  local is_on_top_of_delimiter = end_col == start_col
  if is_on_top_of_delimiter then return M.to_end_of_word(end_col + 1) end

  local is_next_char_delimiter = (end_col - start_col) == 1
  if is_next_char_delimiter then
    -- se o próximo char for um espaço, move o cursor pra frente e tentar de novo
    local is_next_char_space = line:sub(end_col, end_col):match('%s')
    if is_next_char_space then return M.to_end_of_word(end_col + 1) end

    -- move o cursor para a posição do delimitador
    return fn.cursor({ 0, end_col })
  end

  -- move o cursor pra posição anterior ao delimitador
  fn.cursor({ 0, end_col - 1 })
end

function M.to_start_of_next_word(current_col)
  local line, start_col = fn.getline('.'), current_col or fn.col('.')

  local is_on_last_char = #line == 0 or start_col == #line
  if is_on_last_char then return utils.api.feedkeys('w') end

  local is_before_a_valid_word = function(chars) return chars:match('%W%w') end

  -- Encontra a coluna do próximo delimitador
  local chars
  local end_col = start_col
  while end_col < #line do
    chars = line:sub(end_col, end_col + 1)

    if is_before_a_valid_word(chars) then break end
    end_col = end_col + 1
  end

  -- se o char anterior for um espaço, move o cursor pra frente e tentar de novo
  local is_previous_char_space = chars:match('%s%w')
  if is_previous_char_space then return fn.cursor({ 0, end_col + 1 }) end

  local is_on_top_of_delimiter = end_col == start_col
  if is_on_top_of_delimiter then return fn.cursor({ 0, end_col + 1 }) end

  fn.cursor({ 0, end_col })
end

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

return M
