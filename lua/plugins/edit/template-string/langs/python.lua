local utils = require('plugins.edit.template-string.utils')
local cfg = require('plugins.edit.template-string.config')

local M = {}

---@param text string
---@return boolean
function M.is_quote_string(text) return text:match('^f') == nil end

---@param text string
---@return boolean
function M.has_interpolations(text)
  -- remove scaped brackets and ignore nested interpolations
  return text:gsub('{{', ''):gsub('}}', ''):match('{[^{}][^{}]-}') ~= nil
end

---know if the given node is part of a "format" method
---e.g: "some text".format()
---@param node TSNode tsnode
---@param buf number bufnr
---@return boolean
function M.has_format_method(node, buf)
  local parent = node:parent()

  if parent:type() ~= 'attribute' then return false end

  local sibling_node = node:next_named_sibling()
  local sibling_text = vim.treesitter.get_node_text(sibling_node, buf)

  return sibling_text:match('format') ~= nil
end

---convert a single multiline string to a table of strings
---@param text string
---@return string[]
function M.get_text_lines(text) return vim.split(text, '\n', {}) end

---know if the cursor row is the same as the first row of a multiline node
---@param node TSNode tsnode
function M.is_cursor_in_first_row(node)
  local cursor_row = vim.api.nvim_win_get_cursor(0)[1] - 1
  local node_row = node:range()

  return cursor_row == node_row
end

---know if the cursor column is before at first string quote
---@param node TSNode tsnode
---@param text string
---@return boolean
function M.before_quotes(node, text)
  local _, node_col = node:range()
  local cursor_col = vim.api.nvim_win_get_cursor(0)[2]
  local first_quote_col = text:find('[\'"]') + node_col

  return cursor_col < first_quote_col
end

---@param node TSNode tsnode
---@param buf number bufnr
---@param text string
function M.handle_quote_string(node, buf, text)
  -- ignore cases
  if
      utils.is_undo_or_redo()
      or M.has_format_method(node, buf)
      or not M.has_interpolations(text)
      or M.before_quotes(node, text)
  then
    return
  end

  -- convert to f-string
  local new_text = 'f' .. text
  local lines = utils.is_multiline(text) and M.get_text_lines(new_text) or { new_text }

  utils.replace_node_text(node, buf, lines)

  if not utils.is_multiline(text) or M.is_cursor_in_first_row(node) then utils.move_cursor({ 0, 1 }) end
end

---@param node TSNode tsnode
---@param buf number bufnr
---@param text string
function M.handle_f_string(node, buf, text)
  -- ignore cases
  if
      utils.is_undo_or_redo()
      or M.has_interpolations(text)
      or M.before_quotes(node, text)
      or not utils.has_child_nodes(node) -- is a manual f-string
  then
    return
  end

  -- convert to quote string
  local new_text = text:sub(2)
  local lines = utils.is_multiline(text) and M.get_text_lines(new_text) or { new_text }

  if not utils.is_multiline(text) or M.is_cursor_in_first_row(node) then utils.move_cursor({ 0, -1 }) end

  utils.replace_node_text(node, buf, lines)
end

function M.on_type()
  local node = utils.get_string_node({ 'string' })
  if not node then return end

  local buf = vim.api.nvim_win_get_buf(0)
  local text = vim.treesitter.get_node_text(node, buf)

  if M.is_quote_string(text) then
    M.handle_quote_string(node, buf, text)
  elseif cfg.options.remove_template_string then
    M.handle_f_string(node, buf, text)
  end
end

return M
