local M = {}

function M.is_comment(line) return (#line > 6) and (string.sub(line, 7, 7) == '*') end

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

function M.comment_line(line)
  if M.is_comment(line) then return line end
  local is_populated = #line > 6
  if is_populated then --
    return string.sub(line, 0, 6) .. '*' .. string.sub(line, 8, #line)
  end
  return line .. M.spaces(6 - #line) .. '*'
end

function M.uncomment_line(line)
  if not M.is_comment(line) then return line end
  return string.sub(line, 0, 6) .. ' '.. string.sub(line, 8, #line)
end

return M
