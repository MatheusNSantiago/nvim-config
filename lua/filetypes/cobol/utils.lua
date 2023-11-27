local M = {}

function M.is_comment(line) return (#line > 6) and (string.sub(line, 7, 7) == '*') end

function M.comment_lines(row_start, row_end, buf)
  local lines = vim.api.nvim_buf_get_lines(0, row_start - 1, row_end, false)
  for i, line in ipairs(lines) do
    local is_populated = #line > 6
    if is_populated then
      local replacement_char = M.is_comment(line) and ' ' or '*'

      -- coloca o replacement_char na posição 7
      lines[i] = string.sub(line, 0, 6) .. replacement_char .. string.sub(line, 8, #line)
    else
      lines[i] = line .. M.spaces(6 - #line) .. '*'
    end
  end

  vim.api.nvim_buf_set_lines(buf or 0, row_start - 1, row_end, false, lines)
end

---@param word_pattern? string: default: 'A-Za-z0-9-_'
---@return string | nil
function M.get_word_under_cursor(word_pattern)
  word_pattern = word_pattern or 'A-Za-z0-9-_'
  local cur_line = utils.get_current_line_with_cursor()
  local pattern = '%W' .. ('([%s]+█[%s]+)'):format(word_pattern, word_pattern) .. '%W'
  local word_under_cursor = cur_line:match(pattern)

  if word_under_cursor then
    word_under_cursor = word_under_cursor:gsub('█', '')
    return word_under_cursor
  end
end

M.rep = function(s, n) return string.rep(s, n) end
M.spaces = function(n) return string.rep(' ', n) end
return M
