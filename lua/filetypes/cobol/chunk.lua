local M = {}

local NS = vim.api.nvim_create_namespace('chunk')

local function is_block(node_type)
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

local ts = vim.treesitter

local function get_chunk_range()
  local cursor_node = ts.get_node()
  -- return ts.node_to_lsp_range(cursor_node)
  while cursor_node do
    local node_type = cursor_node:type()
    local node_start, _, node_end, _ = cursor_node:range()

    if node_start ~= node_end and is_block(node_type) then
      return { node_start + 1, node_end + 1 }
      -- ---@diagnostic disable-next-line: undefined-field
      -- if cursor_node:has_error() then
      --   return -1
      -- else
      --   return 0, { node_start + 1, node_end + 1 }
      -- end
    end
    cursor_node = cursor_node:parent()
  end

  return nil
end

---@param col number the column number
---@return boolean
local function col_in_screen(col)
  local leftcol = vim.fn.winsaveview().leftcol
  return col >= leftcol
end

function M.clear() vim.api.nvim_buf_clear_namespace(0, NS, 0, -1) end

function M.render()
  local chunk_range = get_chunk_range()
  if not chunk_range then return end
  local text_hl = 'HLChunk1'

  local beg_row, end_row = unpack(chunk_range)
  local beg_blank_len = vim.fn.indent(beg_row)
  local end_blank_len = vim.fn.indent(end_row)
  local shiftwidth = vim.fn.shiftwidth()
  local start_col = math.max(math.min(beg_blank_len, end_blank_len) - shiftwidth, 0)
  local offset = vim.fn.winsaveview().leftcol
  -- local get_width = vim.api.nvim_strwidth
  local row_opts = {
    virt_text_pos = 'overlay',
    hl_mode = 'combine',
    priority = 100,
  }

  -- render beg_row
  if beg_blank_len > 0 then
    local virt_text_len = beg_blank_len - start_col
    local beg_virt_text = '╭' .. ('─'):rep(virt_text_len - 1)

    -- because the char is utf-8, so we need to get the utf-8 byte index
    -- if not col_in_screen(start_col) then
    --   local byte_idx = math.min(offset - start_col, virt_text_len)
    --   if byte_idx > get_width(beg_virt_text) then byte_idx = get_width(beg_virt_text) end
    --   local utfBeg = vim.str_byteindex(beg_virt_text, byte_idx)
    --   beg_virt_text = beg_virt_text:sub(utfBeg + 1)
    -- end

    row_opts.virt_text = { { beg_virt_text, text_hl } }
    row_opts.virt_text_win_col = math.max(start_col - offset, 0)
    vim.api.nvim_buf_set_extmark(0, NS, beg_row - 1, 0, row_opts)
  end

  -- render end_row
  if end_blank_len > 0 then
    -- local virt_text_len = end_blank_len - start_col
    local end_virt_text = '╰' .. ('─'):rep(end_blank_len - start_col - 2) .. '─'

    -- if not col_in_screen(start_col) then
    --   local byte_idx = math.min(offset - start_col, virt_text_len)
    --   if byte_idx > get_width(end_virt_text) then byte_idx = get_width(end_virt_text) end
    --   local utfBeg = vim.str_byteindex(end_virt_text, byte_idx)
    --   end_virt_text = end_virt_text:sub(utfBeg + 1)
    -- end
    row_opts.virt_text = { { end_virt_text, text_hl } }
    row_opts.virt_text_win_col = math.max(start_col - offset, 0)
    vim.api.nvim_buf_set_extmark(0, NS, end_row - 1, 0, row_opts)
  end

  -- render middle section
  for i = beg_row + 1, end_row - 1 do
    row_opts.virt_text = { { '│', text_hl } }
    row_opts.virt_text_win_col = start_col - offset
    local space_tab = (' '):rep(shiftwidth)
    local line_val = vim.fn.getline(i):gsub('\t', space_tab)
    if #line_val <= start_col or vim.fn.indent(i) > start_col then
      if col_in_screen(start_col) then vim.api.nvim_buf_set_extmark(0, NS, i - 1, 0, row_opts) end
    end
  end
end

return M
