local M = {}

function M.is_comment(line) return line:match('^      %*') ~= nil end

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

return M
