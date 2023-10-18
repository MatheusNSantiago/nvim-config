local M = {}

---@class Node
---@field name string
---@field kind string
---@field range { start: number, finish : number }
---@field parent Node|nil
---@field children Node[]

---@param name string The name of the node to search for.
---@param node Node The root node of the tree structure.
---@return table|nil The node with the specified name, or nil if not found.
M.search_node = function(name, node)
  if node.name == name then return node end

  for _, child in ipairs(node.children) do
    local child_node = M.search_node(name, child)
    if child_node then return child_node end
  end

  return nil
end

---@param callback fun(tree: Node): any
M.tree_provider = function(callback)
  local client = M._get_client()

    client.request(
      'textDocument/documentSymbol',
      { textDocument = vim.lsp.util.make_text_document_params() },
      function(_, symbols, _)
        local tree = symbols[1]
        tree = M._clean_tree(tree)
        callback(tree)
      end
    )
end



M._lsp_str_to_num = vim.tbl_add_reverse_lookup({
  File = 1,
  Module = 2,
  Namespace = 3,
  Package = 4,
  Class = 5,
  Method = 6,
  Property = 7,
  Field = 8,
  Constructor = 9,
  Enum = 10,
  Interface = 11,
  Function = 12,
  Variable = 13,
  Constant = 14,
  String = 15,
  Number = 16,
  Boolean = 17,
  Array = 18,
  Object = 19,
  Key = 20,
  Null = 21,
  EnumMember = 22,
  Struct = 23,
  Event = 24,
  Operator = 25,
  TypeParameter = 26,
})

function M._clean_tree(node, parent)
  local selection_range = node['selectionRange']
  local kind = node['kind']

  local cleanedNode = {
    name = node.name,
    kind = M._lsp_str_to_num[kind],
    parent = parent,
    children = {},
    range = {
      start = selection_range['start']['line'],
      finish = selection_range['end']['line'],
    },
  }

  for _, child in ipairs(node.children) do
    table.insert(cleanedNode.children, M._clean_tree(child))
  end

  return cleanedNode
end


M._get_client = function()
  local clients = vim.lsp.get_active_clients()
  local cobol_ls

  for _, client in ipairs(clients) do
    if client.name == 'cobol_ls' then
      cobol_ls = client
      break
    end
  end

  return cobol_ls
end

return M
