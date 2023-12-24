-- Modifiquei o source code do rename do lspsaga pra fazer o rename manualmente pelo client msm
-- REF: https://github.com/nvimdev/lspsaga.nvim/blob/main/lua/lspsaga/rename/init.lua

local api, fn = vim.api, vim.fn
local lsp = require('filetypes.cobol.lsp')
local ns = api.nvim_create_namespace('LspsagaRename')
local win = require('lspsaga.window')
local util = require('lspsaga.util')
local context = {}
local rename = {}

rename.__index = rename
rename.__newindex = function(t, k, v) rawset(t, k, v) end

local function clean_context()
  for k, _ in pairs(context) do
    context[k] = nil
  end
end

function rename:close_rename_win()
  if api.nvim_get_mode().mode == 'i' then vim.cmd([[stopinsert]]) end
  if self.winid and api.nvim_win_is_valid(self.winid) then api.nvim_win_close(self.winid, true) end

  api.nvim_buf_clear_namespace(0, ns, 0, -1)
end

function rename:apply_action_keys()
  util.map_keys(self.bufnr, '<C-c>', function() self:close_rename_win() end, 'i')
  util.map_keys(self.bufnr, 'q', function() self:close_rename_win() end, 'n')

  util.map_keys(self.bufnr, '<CR>', function() self:do_rename() end, 'i')
  util.map_keys(self.bufnr, '<CR>', function() self:do_rename() end, 'n')
end

function rename:lsp_rename()
  local bufnr = api.nvim_get_current_buf()
  local cword = fn.expand('<cword>')

  self.references = {}
  lsp.references_provider(function(refs)
    for _, ref in ipairs(refs) do
      local line = ref.line
      local start_char = ref.start_char
      local end_char = ref.end_char

      -- Da um highlight nas palavras encontradas
      vim.api.nvim_buf_add_highlight(bufnr, ns, 'RenameMatch', line, start_char, end_char)
    end

    self.references = refs
  end, bufnr)

  self.bufnr, self.winid = win
      :new_float({
        height = 1,
        width = 30,
        title = { { 'Renomear', 'SagaTitle' } },
      }, true)
      :setlines({ cword })
      :bufopt({
        ['bufhidden'] = 'wipe',
        ['buftype'] = 'nofile',
        ['filetype'] = 'sagarename',
      })
      :winopt('scrolloff', 0)
      :winhl('RenameNormal', 'RenameBorder')
      :wininfo()

  local mode = api.nvim_get_mode().mode
  if mode == 'i' then
    vim.cmd.startinsert()
  elseif mode == 's' then
    vim.cmd([[normal! V]])
    utils.api.feedkeys('<C-g>', 'n')
  end

  local quit_id, close_unfocus
  local group = require('lspsaga').saga_augroup
  quit_id = api.nvim_create_autocmd('QuitPre', {
    group = group,
    buffer = self.bufnr,
    once = true,
    nested = true,
    callback = function()
      self:close_rename_win()
      if not quit_id then
        api.nvim_del_autocmd(quit_id)
        quit_id = nil
      end
    end,
  })

  close_unfocus = api.nvim_create_autocmd('WinLeave', {
    group = group,
    buffer = self.bufnr,
    callback = function()
      api.nvim_win_close(0, true)
      if close_unfocus then
        api.nvim_del_autocmd(close_unfocus)
        close_unfocus = nil
      end
    end,
  })

  self:apply_action_keys()
end

function rename:do_rename()
  local new_name = vim.trim(api.nvim_get_current_line())
  self:close_rename_win()
  local current_name = vim.fn.expand('<cword>')
  if not (new_name and #new_name > 0) or new_name == current_name then return end

  -- Normaliza o nome (- é um char especial )
  current_name = current_name:gsub('%-', '%%-')

  for _, ref in ipairs(self.references) do
    local line_idx = ref.line
    local line_content = api.nvim_buf_get_lines(0, line_idx, line_idx + 1, false)[1]

    local new_line_content = line_content:gsub(current_name, new_name)

    api.nvim_buf_set_lines(0, line_idx, line_idx + 1, false, { new_line_content })
  end

  clean_context()
end

return {
  rename = function() rename:lsp_rename() end,
}
