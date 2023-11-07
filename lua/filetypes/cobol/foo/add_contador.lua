local Input = require('filetypes.cobol.foo.input')
local ts = vim.treesitter
local M = {}

function M.add_contador()
  -- achar o node working_storage_section no tree-sitter
  M._get_working_storage_section_node()
end

-- 77  CNT-QT-GRAVADOS             PIC  9(009) VALUE ZERO.

function M._get_working_storage_section_node()
  local node = M._get_root_node()

  print(node:type())
  -- go up the tree until find working_storage_section
  -- while node do
    --   local node_type = node:type()
    --   if node_type == 'working_storage_section' then
    --     return node
    --   end
    --   node = node:parent()
    -- end
  -- end
end

function M._go_to_root(node)
  local has_parent = node:parent() ~= nil
  if true then
    
  end
end

return M.add_contador
