require("utils")

local status, tree = pcall(require, "nvim-tree")
if (not status) then return end


local lib = require("nvim-tree.lib")
-- local view = require("nvim-tree.view")
local api = require("nvim-tree.api")


local swap_then_open_tab = function()
  local node = lib.get_node_at_cursor()
  if node == nil then return end
  vim.cmd("wincmd l")
  api.node.open.tab(node)
end

local function collapse_all()
  require("nvim-tree.actions.tree-modifiers.collapse-all").fn()
end

local function expand()
  -- open as vsplit on current node
  local node = lib.get_node_at_cursor()
  if node == nil then return end

  if node.nodes ~= nil then
    lib.expand_or_collapse(node)
  end

end

local function vsplit_preview()
  -- open as vsplit on current node
  local action = "vsplit"
  local node = lib.get_node_at_cursor()
  if node == nil then return end

  -- Just copy what's done normally with vsplit
  if node.link_to and not node.nodes then
    require('nvim-tree.actions.node.open-file').fn(action, node.link_to)

  elseif node.nodes ~= nil then
    lib.expand_or_collapse(node)

  else
    require('nvim-tree.actions.node.open-file').fn(action, node.absolute_path)

  end

  -- Finally refocus on tree if it was lost
  -- view.focus()
end

-- |──────────────────────────────────────────────────────────────────────────────────────────────|

-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local config = {
  view = {
    adaptive_size = false, -- Ajusta o seu tamanho automaticamente com base no tamanho do nome dos arquivos do projeto.
    mappings = {
      list = {
        { key = "o", action = "edit_no_picker" },
        { key = "t", action = "swap_then_open_tab", action_cb = swap_then_open_tab },

        { key = "ç", action = "expand", action_cb = expand },
        { key = "Ç", action = "vsplit_preview", action_cb = vsplit_preview },
        { key = "j", action = "close_node" },
        { key = "J", action = "collapse_all", action_cb = collapse_all }
      },
    },
  },
  renderer = {
  },
  update_focused_file = {
    enable = true,
    update_cwd = false,
    ignore_list = {},
  },
  diagnostics = {
    enable = true,
    show_on_dirs = false,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    },
  },
  tab = {
    sync = {
      open = true,
      close = true,
      ignore = {},
    },
  },
  filters = {
    -- dotfiles = true,
  },
}


map("n", "<Leader>e", ":NvimTreeToggle<CR>", { silent = true })

tree.setup(config)


local function tab_win_closed(winnr)
  local tabnr = vim.api.nvim_win_get_tabpage(winnr)
  local bufnr = vim.api.nvim_win_get_buf(winnr)
  local buf_info = vim.fn.getbufinfo(bufnr)[1]
  local tab_wins = vim.tbl_filter(function(w) return w ~= winnr end, vim.api.nvim_tabpage_list_wins(tabnr))
  local tab_bufs = vim.tbl_map(vim.api.nvim_win_get_buf, tab_wins)
  if buf_info.name:match(".*NvimTree_%d*$") then -- close buffer was nvim tree
    -- Close all nvim tree on :q
    if not vim.tbl_isempty(tab_bufs) then -- and was not the last window (not closed automatically by code below)
      api.tree.close()
    end
  else -- else closed buffer was normal buffer
    if #tab_bufs == 1 then -- if there is only 1 buffer left in the tab
      local last_buf_info = vim.fn.getbufinfo(tab_bufs[1])[1]
      if last_buf_info.name:match(".*NvimTree_%d*$") then -- and that buffer is nvim tree
        vim.schedule(function()
          if #vim.api.nvim_list_wins() == 1 then -- if its the last buffer in vim
            -- vim.cmd "quit" -- then close all of vim
          else -- else there are more tabs open
            vim.cmd("NvimTreeOpen")
            vim.api.nvim_win_close(tab_wins[1], true) -- then close only the tab
          end
        end)
      end
    end
  end

end

vim.api.nvim_create_autocmd("WinClosed", {
  callback = function()
    local winnr = tonumber(vim.fn.expand("<amatch>"))
    vim.schedule_wrap(tab_win_closed(winnr))
  end,
  nested = true
})
