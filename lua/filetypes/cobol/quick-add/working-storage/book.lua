local U = require('filetypes.cobol.quick-add.working-storage.utils')
local M = {}

---@param name string: seta o nome do book
function M.add_book(name)
  local first_empty_line_idx = U.get_last_line_for_category('BOOKS')

  local books_category_exists = first_empty_line_idx ~= nil
  if not books_category_exists then
    M.make_heading()
    return M.add_book(name) -- tentar de novo
  end
  if not first_empty_line_idx then return end

  local entry = M.make_entry(name)
  U.insert_lines(first_empty_line_idx, entry)
end

function M.make_entry(name) return { ('%sCOPY %s.'):format(U.spaces(7), name) } end

function M.make_heading()
  local constant_category_last_line = U.get_last_line_for_category('CONSTANTES')
  assert(
    constant_category_last_line,
    'Não foi possível criar BOOKS. Verifique se a categoria anterior, CONSTANTES, existe'
  )
  U.insert_lines(constant_category_last_line, {
    '      *',
    '      *-------------------------- B O O K S ---------------------------*',
    '      *',
  })
end

return M.add_book
