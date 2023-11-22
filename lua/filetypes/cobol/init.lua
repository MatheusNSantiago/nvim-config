local chunk = require('filetypes.cobol.chunk')
local comment_box = require('comment-box')
local indent = require('filetypes.cobol.indent')
local quick_add = require('filetypes.cobol.quick-add')
local Outline = require('filetypes.cobol.outline')
local code_runner = require('filetypes.cobol.code-runner')
local U = require('filetypes.cobol.utils')
local motions = require('filetypes.cobol.motions')
local M = {}

M.filetype_config = {
  mappings = {
    -- {
    --   'n',
    --   '<leader>a',
    --   function()
    --     Outline()
    --     -- local function get_layout_params()
    --     --   local box = Layout.Box({
    --     --     Layout.Box(Outline({ title = 'FOO BAR' }), { grow = 1 }),
    --     --   }, { dir = 'col' })
    --     --
    --     --   local config = {
    --     --     relative = 'editor',
    --     --     position = '100%',
    --     --     size = { width = '30%', height = '100%' },
    --     --   }
    --     --   return config, box
    --     -- end
    --     --
    --     -- local Layout = require('nui.layout')
    --     -- Layout(get_layout_params()):mount()
    --   end,
    -- },
    { { 'n', 'x' }, 'w',          motions.to_start_of_next_word },
    { { 'n', 'x' }, 'e',          motions.to_end_of_word },
    { { 'n', 'x' }, 'b',          motions.start_of_previous_word },
    { 'n',          '<leader>ap', quick_add.add_pic },
    { 'n',          '<leader>as', quick_add.add_section },
    { 'n',          '<leader>r',  code_runner.run },
    { 'n',          '<leader>cl', function() comment_box.line(5) end },
    { { 'n', 'v' }, '<leader>cb', function() comment_box.lbox(4) end },
    -- { { 'n', 'v' }, '<leader>cb', function() comment_box.cbox() end },
    { 'i',          '<CR>',       indent.new_indentedline_below },
    { 'n',          'o',          indent.new_indentedline_below },
  },
  plugins = require('filetypes.cobol.plugins'),
  opt = {
    colorcolumn = '7,11,73,80',
    commentstring = '      *%s',
    iskeyword = '@,48-57,_,-',
  },
  commands = function()
    vim.cmd('silent! DisableHLIndent')
    create_picker('<leader><leader>o', 'Cobol Commands', {
      { name = 'add copybook', handler = function() M.add_copybook() end },
    })

    utils.api.augroup('cobol', {
      desc = 'kill cobol_ls when exiting nvim',
      pattern = '*.cbl',
      event = 'VimLeavePre',
      command = 'silent !killall server-linux',
    }, {
      desc = 'mostrar aqueles indicadores iguais ao do HLChunk',
      event = { 'CursorMovedI', 'CursorMoved' },
      pattern = '*.cbl',
      command = utils.throttle(chunk.refresh, 70),
    }, {
      desc = 'Capitalizar código depois de salvar',
      event = 'BufWritePost',
      pattern = '*.cbl',
      command = M.capitalize_code,
    })
  end,
}

M.add_copybook = function()
  local Input = require('nui.input')

  local input = Input({
    relative = 'editor',
    position = '50%',
    size = { width = 20, height = 1 },
    border = {
      style = 'rounded',
      text = { top = 'Novo book', top_align = 'center' },
    },
  }, {
    on_submit = function(value) print(value) end,
  })
  input:mount()

  input:on('BufLeave', function() input:unmount() end)

  input:map('n', 'q', function() input:unmount() end)
  input:map('i', '<C-c>', function() input:unmount() end)

  vim.schedule(function() vim.cmd('startinsert') end)
end

M.capitalize_code = function()
  local lines = vim.fn.getline(1, '$')
  local new_lines = {}
  for _, line in ipairs(lines) do
    local is_comment = U.is_comment(line)
    local is_copybook = line:match([[^%s*[cC][oO][pP][yY]%s+['"].+['"]%.]])

    local do_nothing = is_comment or is_copybook

    table.insert(new_lines, (do_nothing and line) or line:upper())
  end

  vim.api.nvim_buf_set_lines(0, 0, -1, false, new_lines)
end

return M.filetype_config
