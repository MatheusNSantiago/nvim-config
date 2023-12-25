local M = {}

function M.is_comment(line) return (#line > 6) and (string.sub(line, 7, 7) == '*') end

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
