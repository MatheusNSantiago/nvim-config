local M = {}

function M.setup()
  return {
    'kevinhwang91/nvim-ufo',
    config = M.config,
    event = 'LspAttach',
    keys = M.keys,
    dependencies = { 'kevinhwang91/promise-async' },
  }
end

function M.keys()
  local is_installed, ufo = pcall(require, 'ufo')
  if not is_installed then return end

  return {
    { 'zR', ufo.openAllFolds,                      desc = 'Open all folds' },
    { 'zM', ufo.closeAllFolds,                     desc = 'Close all folds' },
    { 'zc', desc = 'Close fold under cursor' },
    { 'zC', desc = 'Close all folds under cursor' },
    { 'zo', desc = 'Open fold under cursor' },
    { 'zO', desc = 'Open all folds under cursor' },
    { 'za', desc = 'Toggle fold under cursor' },
    { 'zA', desc = 'Toggle all folds under cursor' },
    { 'zr', ufo.openFoldsExceptKinds,              desc = 'Open Folds Except Kinds' },
    { 'zR', ufo.openAllFolds,                      desc = 'Open All Folds' },
    { 'zM', ufo.closeAllFolds,                     desc = 'Close All Folds' },
    { 'zm', ufo.closeFoldsWith,                    desc = 'Close Folds With' },
  }
end

function M.config()
  local ufo = require('ufo')
  -- ╭──────────────────────────────────────────────────────────╮
  -- │ Custom handler function                                  │
  -- ╰──────────────────────────────────────────────────────────╯

  local handler = function(virt_text, start_line, end_line, width, truncate)
    local new_virt_text = {}
    local suffix = ('  %d '):format(end_line - start_line)
    local suf_width = vim.fn.strdisplaywidth(suffix)
    local target_width = width - suf_width
    local cur_width = 0

    for _, chunk in ipairs(virt_text) do
      local chunk_text = chunk[1]
      local chunk_width = vim.fn.strdisplaywidth(chunk_text)
      if target_width > cur_width + chunk_width then
        table.insert(new_virt_text, chunk)
      else
        chunk_text = truncate(chunk_text, target_width - cur_width)
        local hl_group = chunk[2]
        table.insert(new_virt_text, { chunk_text, hl_group })
        chunk_width = vim.fn.strdisplaywidth(chunk_text)
        -- str width returned from truncate() may less than 2nd argument, need padding
        if cur_width + chunk_width < target_width then
          suffix = suffix .. (' '):rep(target_width - cur_width - chunk_width)
        end
        break
      end
      cur_width = cur_width + chunk_width
    end

    table.insert(new_virt_text, { suffix, 'MoreMsg' })

    return new_virt_text
  end

  -- vim.o.foldcolumn = '1' -- '0' is not bad
  vim.o.foldlevel = 99  -- Using ufo provider need a large value, feel free to decrease the value
  vim.o.foldlevelstart = 99
  vim.o.foldenable = true

  ufo.setup({
    fold_virt_text_handler = handler,
    provider_selector = function(_, filetype, buftype)
      -- return a table with string elements: 1st is name of main provider, 2nd is fallback
      -- return a string type: use ufo inner providers
      -- return a string in a table: like a string type above
      -- return empty string '': disable any providers
      -- return `nil`: use default value {'lsp', 'indent'}
      -- return a function: it will be involved and expected return `UfoFoldingRange[]|Promise`
      --  ╾───────────────────────────────────────────────────────────────────────────────────╼
      local function handleFallbackException(bufnr, err, providerName)
        if type(err) == 'string' and err:match('UfoFallbackException') then
          return ufo.getFolds(bufnr, providerName)
        else
          return require('promise').reject(err)
        end
      end

      local is_file_opened = filetype == '' or buftype == 'nofile'
      if is_file_opened then return 'indent' end -- only use indent until a file is opened

      return function(bufnr)
        return ufo
            .getFolds(bufnr, 'lsp')
            :catch(function(err) return handleFallbackException(bufnr, err, 'treesitter') end)
            :catch(function(err) return handleFallbackException(bufnr, err, 'indent') end)
      end
    end,
  })
end

return M
