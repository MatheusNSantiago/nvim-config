local api, fn = vim.api, vim.fn

local M = {
  NS = api.nvim_create_namespace('virtcolumn'),
}

function M.setup()
  utils.api.augroup('virtcolumn', {
    event = {
      'winscrolled',
      'textchanged',
      'textchangedi',
      'bufwinenter',
      'insertleave',
      'insertenter',
      'filechangedshellpost',
    },
    command = M.refresh,
  }, {
    event = 'OptionSet',
    pattern = 'colorcolumn',
    command = function()
      vim.b['virtcolumn_items'] = nil
      vim.w['virtcolumn_items'] = nil
      M._refresh()
    end,
  }, {
    event = 'ColorScheme',
    command = function() api.nvim_set_hl(0, 'VirtColumn', { fg = '#3b4261', default = true }) end,
  })
end

-- local ffi = require('ffi')
-- ffi.cdef('int curwin_col_off(void);')
-- function M.curwin_col_off() return ffi.C.curwin_col_off() end

function M.parse_items(cc)
  local textwidth = vim.o.textwidth

  local items = {}
  for _, c in ipairs(vim.split(cc, ',')) do
    local item
    local is_c_valid = c and c ~= ''
    if is_c_valid then
      if vim.startswith(c, '+') then
        if textwidth ~= 0 then item = textwidth + tonumber(c:sub(2)) end
      elseif vim.startswith(cc, '-') then
        if textwidth ~= 0 then item = textwidth - tonumber(c:sub(2)) end
      else
        item = tonumber(c)
      end
    end
    if item and item > 0 then table.insert(items, item) end
  end
  table.sort(items, function(a, b) return a > b end)
  return items
end

function M._refresh()
  local curbuf = api.nvim_get_current_buf()
  if not api.nvim_buf_is_loaded(curbuf) then return end

  local virt_column_items = vim.b.virtcolumn_items or vim.w.virtcolumn_items
  local local_cc = api.nvim_get_option_value('cc', { scope = 'local' })

  if (not virt_column_items) or (local_cc ~= '') then
    virt_column_items = M.parse_items(local_cc)
    api.nvim_set_option_value('cc', '', { scope = 'local' })
  end
  vim.b['virtcolumn_items'] = virt_column_items
  vim.w['virtcolumn_items'] = virt_column_items

  -- local win_width = api.nvim_win_get_width(0) - M.curwin_col_off()
  local win_width = api.nvim_win_get_width(0)
  virt_column_items = vim.tbl_filter(function(item) return win_width > item end, virt_column_items)

  if #virt_column_items == 0 then
    api.nvim_buf_clear_namespace(curbuf, M.NS, 0, -1)
    return
  end

  local debounce = math.floor(api.nvim_win_get_height(0) * 0.6)
  local visible_first, visible_last = fn.line('w0'), fn.line('w$')
  -- Avoid flickering caused by winscrolled_timer
  local offset = (visible_first <= debounce and 1 or visible_first - debounce) - 1 -- convert to 0-based

  --                                                Avoid flickering caused by timer
  --                                                                ↓↓↓↓↓↓↓↓↓↓↓
  local lines = api.nvim_buf_get_lines(curbuf, offset, visible_last + debounce, false)
  local rep = string.rep(' ', vim.opt.tabstop:get())
  local char = '┊'
  local priority = 10

  local line, lnum, strwidth
  for idx = 1, #lines do
    line = lines[idx]:gsub('\t', rep)
    lnum = idx - 1 + offset
    strwidth = api.nvim_strwidth(line)
    api.nvim_buf_clear_namespace(curbuf, M.NS, lnum, lnum + 1)
    for _, item in ipairs(virt_column_items) do
      if strwidth < item or fn.strpart(line, item - 1, 1) == ' ' then
        api.nvim_buf_set_extmark(curbuf, M.NS, lnum, 0, {
          virt_text = { { char, 'VirtColumn' } },
          hl_mode = 'combine',
          virt_text_win_col = item - 1,
          priority = priority,
        })
      end
    end
  end
end

function M.refresh(args)
  -- Avoid unnecessary refreshing as much as possible
  local winscrolled_timer
  local textchanged_timer
  local event = args.event or ''

  if event == 'WinScrolled' then
    if winscrolled_timer and winscrolled_timer:is_active() then
      winscrolled_timer:stop()
      winscrolled_timer:close()
    end
    winscrolled_timer = vim.defer_fn(M._refresh, 100)
    return
  end

  if event:match('TextChanged') then
    if textchanged_timer and textchanged_timer:is_active() then
      textchanged_timer:stop()
      textchanged_timer:close()
    end

    local lines_count = vim.fn.line('$')

    local has_lines_changed = lines_count ~= vim.b.virtcolumn_lines_count
    if has_lines_changed then vim.b['virtcolumn_lines_count'] = lines_count end

    local delay = has_lines_changed and 15 or 150
    textchanged_timer = vim.defer_fn(M._refresh, delay)
    return
  end

  M._refresh()
end

return M
