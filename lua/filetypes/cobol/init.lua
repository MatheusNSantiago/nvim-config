local chunk = require('filetypes.cobol.chunk')
local complete_statement = require('filetypes.cobol.complete-statement')
local indent = require('filetypes.cobol.indent')
local outline = require('cobol-outline')

---@type FiletypeSettings
---@diagnostic disable-next-line: missing-fields
local M = {}

M.picker = {
  keymap = '<leader><leader>o',
  title = 'Cobol Commands',
  actions = require('cobol-quick-add.picker-actions'),
}

M.on_buf_enter = function()
  chunk.setup_highlights()
  outline.setup()
  vim.cmd('silent! DisableHLIndent')
end

M.mappings = {
  { 'n',          'gr',         require('filetypes.cobol.rename').rename },
  { 'n',          '<leader>o',  outline.open },
  { 'n',          '<leader>ss', outline.search_section },
  -- { { 'n', 'x' }, 'w',          require('filetypes.cobol.motions').to_start_of_next_word },
  -- { { 'n', 'x' }, 'e',          require('filetypes.cobol.motions').to_end_of_word },
  -- { { 'n', 'x' }, 'b',          require('filetypes.cobol.motions').start_of_previous_word },
  { 'n',          '<leader>ap', require('cobol-quick-add').add_picture },
  { 'n',          '<leader>as', require('cobol-quick-add').add_section },
  { 'n',          '<leader>r',  require('filetypes.cobol.code-runner').run },
  { 'n',          '<leader>cl', function() require('comment-box').line(5) end },
  { { 'n', 'v' }, '<leader>cb', function() require('comment-box').lbox(4) end },
  { 'n',          'o',          indent.new_indentedline_below },
  {
    'i',
    '<CR>',
    function()
      indent.new_indentedline_below()
      -- if complete_statement.is_valid() then complete_statement.complete() end
    end,
  },
}

M.plugins = require('filetypes.cobol.plugins')

M.opt = {
  colorcolumn = '7,11,73,80',
  commentstring = '      *%s',
  iskeyword = '@,48-57,_,-',
}

M.autocommands = {
  {
    desc = 'kill cobol_ls when exiting nvim',
    pattern = '*.cbl',
    event = 'VimLeavePre',
    command = 'silent !killall server-linux',
  },
  {
    desc = 'mostrar aqueles indicadores iguais ao do HLChunk',
    event = { 'CursorMovedI', 'CursorMoved', 'BufEnter' },
    pattern = '*.cbl',
    command = utils.throttle(chunk.refresh, 70),
  },
  -- {
  --   desc = 'Capitalizar código depois de salvar',
  --   event = 'BufWritePost',
  --   pattern = '*.cbl',
  --   command = function()
  --     local lines = vim.fn.getline(1, '$')
  --     local new_lines = {}
  --     for _, line in ipairs(lines) do
  --       local is_comment = U.is_comment(line)
  --       local is_copybook = line:match([[^%s*[cC][oO][pP][yY]%s+['"].+['"]%.]])
  --
  --       local do_nothing = is_comment or is_copybook
  --
  --       table.insert(new_lines, (do_nothing and line) or line:upper())
  --     end
  --
  --     vim.api.nvim_buf_set_lines(0, 0, -1, false, new_lines)
  --   end,
  -- },
}

return M
