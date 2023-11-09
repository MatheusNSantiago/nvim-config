local M = {}
local comment_box = require('comment-box')
local indent = require('filetypes.cobol.indent')

M.mappings = {
  { 'n',          '<leader>r',  function() M.run_code() end },
  { 'n',          '<leader>cl', function() comment_box.line(5) end },
  { 'n',          '<leader>cd', function() M.add_division_comment() end },
  { { 'n', 'v' }, '<leader>cb', function() comment_box.cbox() end },
  { 'i',          '<CR>',       function() indent.new_indentedline_below() end },
  { 'n',          'o',       function() indent.new_indentedline_below() end },
}

M.run_code = function()
  local file_path = vim.fn.expand('%:p')
  local filename_without_extension = vim.fn.expand('%:t:r')

  local cmd_compile = 'cobc -xO ' .. '"' .. file_path .. '"'
  local cmd_run = './' .. filename_without_extension
  local cmd_remove_exec = 'rm ' .. filename_without_extension

  local cmd = cmd_compile .. ' && ' .. cmd_run .. ' && ' .. cmd_remove_exec

  vim.cmd('w')
  vim.cmd(("TermExec cmd='%s'"):format(cmd))
  vim.schedule(function() vim.cmd('wincmd j') end) -- Go to bottom terminal
end

--- Tira o espaço desse line comment
--- [antes -> '* ╞══...══╡'] => (depois -> '*╞══...══╡')
M.add_division_comment = function()
  require('comment-box').line(7) -- add line comment

  local line, line_number = vim.fn.getline('.'), vim.fn.line('.')

  local p1 = string.sub(line, 0, 7)        --  "      *"
  local p2 = string.sub(line, 9, 11)       -- "╞"
  local resto = string.sub(line, 15, #line) -- "══...══╡"

  vim.fn.setline(line_number, p1 .. p2 .. '══' .. resto)
end

return M.mappings
