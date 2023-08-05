local M = {}

function M.setup()
  return {
    'kevinhwang91/nvim-ufo',
    config = M.config,
    keys = M.keys,
    dependencies = { 'kevinhwang91/promise-async' },
  }
end

function M.keys()
  local is_installed, ufo = pcall(require, 'ufo')
  if not is_installed then return end

  return {
    { 'zR', ufo.openAllFolds,  desc = 'Open all folds' },
    { 'zM', ufo.closeAllFolds, desc = 'Close all folds' },
  }
end

function M.config()
  local ufo = require('ufo')

  -- ╭──────────────────────────────────────────────────────────╮
  -- │ Custom handler function                                  │
  -- ╰──────────────────────────────────────────────────────────╯

  local handler = function(virtText, lnum, endLnum, width, truncate)
    local newVirtText = {}
    local suffix = ('  %d '):format(endLnum - lnum)
    local sufWidth = vim.fn.strdisplaywidth(suffix)
    local targetWidth = width - sufWidth
    local curWidth = 0

    for _, chunk in ipairs(virtText) do
      local chunkText = chunk[1]
      local chunkWidth = vim.fn.strdisplaywidth(chunkText)
      if targetWidth > curWidth + chunkWidth then
        table.insert(newVirtText, chunk)
      else
        chunkText = truncate(chunkText, targetWidth - curWidth)
        local hlGroup = chunk[2]
        table.insert(newVirtText, { chunkText, hlGroup })
        chunkWidth = vim.fn.strdisplaywidth(chunkText)
        -- str width returned from truncate() may less than 2nd argument, need padding
        if curWidth + chunkWidth < targetWidth then
          suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
        end
        break
      end
      curWidth = curWidth + chunkWidth
    end

    table.insert(newVirtText, { suffix, 'MoreMsg' })

    return newVirtText
  end

  -- vim.o.foldcolumn = '1' -- '0' is not bad
  vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
  vim.o.foldlevelstart = 99
  vim.o.foldenable = true

  ufo.setup({
    fold_virt_text_handler = handler,
    provider_selector = function(_, filetype, buftype)
      local function handleFallbackException(bufnr, err, providerName)
        if type(err) == 'string' and err:match('UfoFallbackException') then
          return ufo.getFolds(bufnr, providerName)
        else
          return require('promise').reject(err)
        end
      end

      return (filetype == '' or buftype == 'nofile') and 'indent' -- only use indent until a file is opened
          or function(bufnr)
            return ufo
                .getFolds(bufnr, 'lsp')
                :catch(function(err) return handleFallbackException(bufnr, err, 'treesitter') end)
                :catch(function(err) return handleFallbackException(bufnr, err, 'indent') end)
          end
    end,
  })
end

return M
