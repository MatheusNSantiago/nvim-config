-- Modifiquei o source code do rename do lspsaga pra fazer o rename manualmente pelo client msm
-- REF: https://github.com/nvimdev/lspsaga.nvim/blob/main/lua/lspsaga/rename/init.lua

local api = vim.api
local lsp = require('filetypes.cobol.lsp')
local ns = api.nvim_create_namespace('LspsagaRename')
local win = require('lspsaga.window')
local util = require('lspsaga.util')
local context = {}

---@class Rename
local Rename = {}

Rename.__index = Rename
Rename.__newindex = function(t, k, v) rawset(t, k, v) end

local function clean_context()
  for k, _ in pairs(context) do
    context[k] = nil
  end
end

function Rename:close_rename_win()
  if api.nvim_get_mode().mode == 'i' then vim.cmd([[stopinsert]]) end
  if self.winid and api.nvim_win_is_valid(self.winid) then api.nvim_win_close(self.winid, true) end

  api.nvim_buf_clear_namespace(0, ns, 0, -1)
end

function Rename:lsp_rename()
  local bufnr = api.nvim_get_current_buf()
  local current_word = vim.fn.expand('<cWORD>')
  self.references = {}
  lsp.references_provider(function(refs)
    self:highlight_references(refs, bufnr)

    self.references = refs
  end, bufnr)

  self.bufnr, self.winid = win
      :new_float({
        height = 1,
        width = 30,
        title = { { 'Renomear', 'SagaTitle' } },
      }, true)
      :setlines({ current_word })
      :bufopt({
        ['bufhidden'] = 'wipe',
        ['buftype'] = 'nofile',
        ['filetype'] = 'sagarename',
      })
      :winopt('scrolloff', 0)
      :winhl('RenameNormal', 'RenameBorder')
      :wininfo()

  self:select_name(current_word)
  self:_apply_autocommands()
  self:apply_mappings()
end

function Rename:do_rename()
  local new_name = vim.trim(api.nvim_get_current_line())
  self:close_rename_win()
  local current_name = vim.fn.expand('<cWORD>')
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

-- Selectiona tudo como se fosse um editor vanilla, ou seja, se eu digitar qualquer coisa,
-- o conteúdo é substituído e se apertar <esc> o conteúdo é mantido.
---Também lida com seções e parágrafos, movendo o cursor para o nome (deixando a numeração de fora).
function Rename:select_name(current_word)
  local _, last_number_idx = current_word:find('^%d+-')

  print(last_number_idx)

  -- Se for uma seção/paragrafo, move o cursor pra onde o nome está
  local found_sec_or_para = last_number_idx and last_number_idx > 0
  if found_sec_or_para then -- selectiona o nome pra frente
    vim.cmd([[normal! $v]])
    utils.api.feedkeys(string.format('%d|', last_number_idx + 1))
  else -- selectiona tudo
    vim.cmd([[normal! V]])
  end

  -- Isso aqui que faz o conteúdo ser substituído igual um editor vanilla
  utils.api.feedkeys('<C-g>', 'n')
end

function Rename:highlight_references(refs, bufnr)
  for _, ref in ipairs(refs) do
    local line = ref.line
    local start_char = ref.start_char
    local end_char = ref.end_char

    vim.api.nvim_buf_add_highlight(bufnr, ns, 'RenameMatch', line, start_char, end_char)
  end
end

function Rename:_apply_autocommands()
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
end

function Rename:apply_mappings()
  util.map_keys(self.bufnr, '<C-c>', function() self:close_rename_win() end, 'i')
  util.map_keys(self.bufnr, 'q', function() self:close_rename_win() end, 'n')

  util.map_keys(self.bufnr, '<CR>', function() self:do_rename() end, 'i')
  util.map_keys(self.bufnr, '<CR>', function() self:do_rename() end, 'n')
end

return {
  rename = function() Rename:lsp_rename() end,
}
