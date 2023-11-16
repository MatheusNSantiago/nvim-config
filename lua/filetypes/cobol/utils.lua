local M = {}

function M.is_comment(line) return line:match('^      %*') end

return M
