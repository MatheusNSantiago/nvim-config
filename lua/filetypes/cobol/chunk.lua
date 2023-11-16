local ts = vim.treesitter
local M = {
  NS = vim.api.nvim_create_namespace('chunk'),
  shiftwidth = 2,
  priority = 100,
}

function M.refresh()
  M.clear()
  M.render()
end

function M.render()
  local chunk_info = M.get_chunk_info()
  if not chunk_info then return end

  local text_hl = M._pick_hl(chunk_info.type)
  local beg_row, end_row = unpack(chunk_info.range)
  local beg_blank_len = vim.fn.indent(beg_row)
  local end_blank_len = vim.fn.indent(end_row)

  local is_end_invalid = end_blank_len == -1
  if is_end_invalid then
    end_blank_len = beg_blank_len - 1
    end_row = end_row - 1
  end

  local start_col = math.max(math.min(beg_blank_len, end_blank_len) - M.shiftwidth, 0)
  local offset = vim.fn.winsaveview().leftcol
  local get_width = vim.api.nvim_strwidth
  local row_opts = {
    virt_text_pos = 'overlay',
    hl_mode = 'combine',
    priority = M.priority,
  }

  -- render beg_row
  if beg_blank_len > 0 then
    local virt_text_len = beg_blank_len - start_col
    local beg_virt_text = '╭' .. ('─'):rep(virt_text_len - 1)

    -- because the char is utf-8, so we need to get the utf-8 byte index
    if not M._col_in_screen(start_col) then
      local byte_idx = math.min(offset - start_col, virt_text_len)
      if byte_idx > get_width(beg_virt_text) then byte_idx = get_width(beg_virt_text) end
      local utfBeg = vim.str_byteindex(beg_virt_text, byte_idx)
      beg_virt_text = beg_virt_text:sub(utfBeg + 1)
    end

    row_opts.virt_text = { { beg_virt_text, text_hl } }
    row_opts.virt_text_win_col = math.max(start_col - offset, 0)
    vim.api.nvim_buf_set_extmark(0, M.NS, beg_row - 1, 0, row_opts)
  end

  -- render end_row
  if end_blank_len > 0 then
    local virt_text_len = end_blank_len - start_col
    local end_virt_text = '╰' .. ('─'):rep(end_blank_len - start_col - 2) .. '─'

    if not M._col_in_screen(start_col) then
      local byte_idx = math.min(offset - start_col, virt_text_len)
      if byte_idx > get_width(end_virt_text) then byte_idx = get_width(end_virt_text) end
      local utfBeg = vim.str_byteindex(end_virt_text, byte_idx)
      end_virt_text = end_virt_text:sub(utfBeg + 1)
    end

    row_opts.virt_text = { { end_virt_text, text_hl } }
    row_opts.virt_text_win_col = math.max(start_col - offset, 0)
    vim.api.nvim_buf_set_extmark(0, M.NS, end_row - 1, 0, row_opts)
  end

  -- render middle section
  for i = beg_row + 1, end_row - 1 do
    row_opts.virt_text = { { '│', text_hl } }
    row_opts.virt_text_win_col = start_col - offset
    local space_tab = (' '):rep(M.shiftwidth)
    local line_val = vim.fn.getline(i):gsub('\t', space_tab)
    if #line_val <= start_col or vim.fn.indent(i) > start_col then
      if M._col_in_screen(start_col) then vim.api.nvim_buf_set_extmark(0, M.NS, i - 1, 0, row_opts) end
    end
  end
end

function M.clear() vim.api.nvim_buf_clear_namespace(0, M.NS, 0, -1) end

---@param col number the column number
---@return boolean
function M._col_in_screen(col)
  local leftcol = vim.fn.winsaveview().leftcol
  return col >= leftcol
end

function M.get_chunk_info()
  local cursor_node = ts.get_node()
  while cursor_node do
    local node_type = cursor_node:type()
    local node_start, _, node_end, _ = cursor_node:range()

    if (node_start ~= node_end) and M.is_chunk(node_type) then
      local chunk_type = node_type:match('_(%w+)$')
      local end_offset = M._calculate_node_end_offset(node_end)

      return {
        type = chunk_type,
        range = {
          node_start + 1,
          node_end + 1 + end_offset,
        },
      }
    end
    cursor_node = cursor_node:parent()
  end

  return nil
end

--- Por algum motivo, quando tem comentário no final do node, ele esquece de
--- contar com o offset do último comentário (=1).
function M._calculate_node_end_offset(node_end)
  local offset = 0
  -- se o próximo nó for um comentário, adiciona + 1 no offset
  local line = vim.fn.getline(node_end)
  if line:find('^      %*') then offset = 1 end

  return offset
end

function M.is_chunk(node_type)
  local patterns = {
    '%w+_division',
    '%w+_section',
    '%w+_paragraph',
  }
  for _, pattern in ipairs(patterns) do
    if node_type:match(pattern) then return true end
  end
  return false
end

function M._pick_hl(chunk_type)
  local hl_map = {
    division = 'Type',
    section = '@section.cobol',
    paragraph = '@paragraph.cobol',
  }

  return hl_map[chunk_type]
end

return M
