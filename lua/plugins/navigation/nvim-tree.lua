local M = {}

M.setup = function()
  return {
    'nvim-tree/nvim-tree.lua',
    config = M.config,
    dependencies = { 'nvim-tree/nvim-web-devicons' },
  }
end

M.config = function()
  local api = require('nvim-tree.api')
  local view = require('nvim-tree.view')

  utils.api.keymap('n', '<A-e>', M.focusOrToggle, { desc = 'nvim-tree: open explorer' })

  -- disable netrw at the very start of your init.lua
  vim.g.loaded_netrw = 1
  vim.g.loaded_netrwPlugin = 1

  utils.api.augroup('nvim-tree', {
    desc = 'Abre nvim-tree ao entrar no neovim',
    event = 'VimEnter',
    command = M._open_on_startup,
  }, {
    desc = 'Fecha nvim tree se ele for o último buffer',
    event = { 'WinClosed' },
    command = M._auto_close,
    nested = true,
  }, {
    desc = 'salva a width do nvim-tree para poder restaurar depois',
    event = 'WinResized',
    command = function()
      local filetree_winnr = view.get_winnr()
      if filetree_winnr ~= nil and vim.tbl_contains(vim.v.event['windows'], filetree_winnr) then
        vim.t['filetree_width'] = vim.api.nvim_win_get_width(filetree_winnr)
      end
    end,
  })

  -- Automatically open file upon creation
  api.events.subscribe(api.events.Event.FileCreated, function(file) vim.cmd('edit ' .. file.fname) end)

  -- restaura o último tamanho da janela ao abrir o nvim-tree
  api.events.subscribe(api.events.Event.TreeOpen, function()
    if vim.t['filetree_width'] ~= nil then
      view.resize(vim.t['filetree_width']) --
    end
  end)

  local is_java = vim.fn.glob(vim.fn.getcwd() .. '/pom.xml') ~= ''
  require('nvim-tree').setup({
    tab = {
      sync = { open = true, close = true, ignore = { 'gitcommit' } },
    },
    disable_netrw = false,                    -- disables netrw completely
    hijack_netrw = true,                      -- hijack netrw window on startup
    hijack_cursor = false,                    -- hijack the cursor in the tree to put it at the start of the filename
    hijack_unnamed_buffer_when_opening = false, -- opens in place of the unnamed buffer if it's empty
    open_on_tab = false,                      -- opens the tree when changing/opening a new tab if the tree wasn't previously opened
    update_cwd = true,                        -- updates the root directory of the tree on `DirChanged` (when your run `:cd` usually)
    reload_on_bufenter = false,
    --false by default, will change cwd of nvim-tree to that of new buffer's when opening nvim-tree
    respect_buf_cwd = false,
    -- show lsp diagnostics in the signcolumn
    notify = {
      threshold = vim.log.levels.WARN,
      absolute_path = true,
    },
    diagnostics = {
      enable = false,
      show_on_dirs = false,
      show_on_open_dirs = true,
      debounce_delay = 50,
      severity = { min = vim.diagnostic.severity.HINT, max = vim.diagnostic.severity.ERROR },
      icons = {
        hint = utils.icons.diagnostics.Hint,
        info = utils.icons.diagnostics.Information,
        warning = utils.icons.diagnostics.Warning,
        error = utils.icons.diagnostics.Error,
      },
    },
    on_attach = function(bufnr)
      local keymap = function(key, action, desc)
        utils.api.keymap('n', key, action, { desc = 'nvim-tree: ' .. desc, buffer = bufnr, nowait = true })
      end

      local CUSTOM_CMD = M._custom_commands()

      keymap('o', api.node.open.no_window_picker, 'Open')
      keymap('t', CUSTOM_CMD.swap_then_open_tab, 'swap_then_open_tab')
      keymap('ç', CUSTOM_CMD.expand, 'expand')
      keymap('j', api.node.navigate.parent_close, 'Close Directory')
      keymap('J', CUSTOM_CMD.collapse_all, 'Collapse')
      keymap('ga', CUSTOM_CMD.git_add, 'git_add')
      keymap('T', CUSTOM_CMD.open_tab_silent, 'open_tab_silent')
      keymap('<C-v>', api.node.open.vertical, 'Open Vertical Split')
      keymap('<C-x>', api.node.open.horizontal, 'Open Horizontal Split')
      keymap('P', api.node.navigate.parent, 'Parent Directory')
      keymap('<Tab>', api.node.open.preview, 'Open Preview')
      keymap('L', api.node.navigate.sibling.first, 'First Sibling')
      keymap('K', api.node.navigate.sibling.last, 'Last Sibling')
      keymap('H', api.tree.toggle_hidden_filter, 'Toggle Dotfiles')
      keymap('R', api.tree.reload, 'Refresh')
      keymap('a', api.fs.create, 'Create')
      keymap('d', api.fs.remove, 'Delete')
      keymap('r', api.fs.rename, 'Rename')
      keymap('x', api.fs.cut, 'Cut')
      keymap('c', api.fs.copy.node, 'Copy')
      keymap('p', api.fs.paste, 'Paste')
      keymap('y', api.fs.copy.filename, 'Copy Name')
      keymap('Y', api.fs.copy.relative_path, 'Copy Relative Path')
      keymap('gy', api.fs.copy.absolute_path, 'Copy Absolute Path')
      keymap('[c', api.node.navigate.git.prev, 'Prev Git')
      keymap(']c', api.node.navigate.git.next, 'Next Git')
      keymap('q', api.tree.close, 'Close')
      keymap('?', api.tree.toggle_help, 'Help')
      keymap('v', function()
        api.node.open.vertical()
        vim.cmd('wincmd L') -- move o buffer pra extrema esquerda
      end, 'Open: Vertical Split')
    end,
    renderer = {
      add_trailing = false,
      group_empty = is_java, -- folders that only contain a single folder into one node in the file tree
      highlight_git = true,
      highlight_opened_files = 'none',
      root_folder_modifier = ':~',
      indent_markers = { enable = false },
      root_folder_label = ':~:s?$?/..?',
      full_name = false,
      indent_width = 2,
      special_files = { 'Cargo.toml', 'Makefile', 'README.md', 'readme.md' },
      symlink_destination = true,
      highlight_diagnostics = 'none',
      highlight_modified = 'none',
      highlight_hidden = 'none',
      highlight_bookmarks = 'none',
      highlight_clipboard = 'name',
      icons = {
        web_devicons = {
          file = { enable = true, color = true },
          folder = { enable = false, color = true },
        },
        git_placement = 'before',
        modified_placement = 'after',
        hidden_placement = 'after',
        diagnostics_placement = 'signcolumn',
        bookmarks_placement = 'signcolumn',
        padding = ' ',
        symlink_arrow = ' ➛ ',
        show = {
          file = true,
          folder = true,
          folder_arrow = true,
          git = true,
          modified = true,
          hidden = false,
          diagnostics = true,
          bookmarks = true,
        },
        glyphs = {
          default = utils.icons.ui.Text,
          symlink = utils.icons.ui.FileSymlink,
          bookmark = utils.icons.ui.BookMark,
          modified = '●',
          hidden = '󰜌',
          folder = {
            arrow_closed = utils.icons.ui.TriangleShortArrowRight,
            arrow_open = utils.icons.ui.TriangleShortArrowDown,
            default = utils.icons.ui.Folder,
            open = utils.icons.ui.FolderOpen,
            empty = utils.icons.ui.EmptyFolder,
            empty_open = utils.icons.ui.EmptyFolderOpen,
            symlink = utils.icons.ui.FolderSymlink,
            symlink_open = utils.icons.ui.FolderOpen,
          },
          git = {
            unstaged = utils.icons.git.Unstaged, --"",
            staged = utils.icons.git.Staged, --"",
            unmerged = utils.icons.git.Unmerged, --"",
            renamed = utils.icons.git.Rename, --"➜",
            untracked = utils.icons.git.Untracked, --"",
            deleted = utils.icons.git.Remove, --"",
            ignored = utils.icons.git.Ignore, --"◌",
          },
        },
      },
    },
    -- update the focused file on `BufEnter`, un-collapses the folders recursively until it finds the file
    hijack_directories = { enable = false, auto_open = true },
    update_focused_file = {
      enable = true,
      update_root = {
        enable = true, -- update the root directory of the tree to the one of the folder containing the file if the file is not under the current root directory
        ignore_list = {},
      },
      exclude = false,
    },
    -- configuration options for the system open command (`s` in the tree by default)
    system_open = {
      cmd = nil, -- the command to run this, leaving nil should work in most cases
      args = {}, -- the command arguments as a list
    },
    filters = {
      enable = true,
      git_ignored = false,
      dotfiles = false,
      git_clean = false,
      no_buffer = false,
      custom = { 'node_modules', "__pycache__" },
      exclude = {},
    },
    -- git = { enable = true, ignore = false, timeout = 500 },
    git = {
      enable = true,
      show_on_dirs = true,
      show_on_open_dirs = true,
      disable_for_dirs = {},
      timeout = 400,
      cygwin_support = false,
    },
    filesystem_watchers = {
      enable = true,
      debounce_delay = 50,
      ignore_dirs = {},
    },
    actions = {
      use_system_clipboard = true,
      change_dir = { enable = true, global = false, restrict_above_cwd = false },
      expand_all = { max_folder_discovery = 300, exclude = {} },
      file_popup = {
        open_win_config = { col = 1, row = 1, relative = 'cursor', border = 'shadow', style = 'minimal' },
      },
      open_file = {
        quit_on_open = false,
        eject = true,
        resize_window = false, -- Esse resize não lembra de resizes anteriores. Ver augroup com event [WinResized]
        window_picker = {
          enable = true,
          picker = 'default',
          chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890',
          exclude = {
            filetype = { 'notify', 'packer', 'qf', 'diff', 'fugitive', 'fugitiveblame' },
            buftype = { 'nofile', 'terminal', 'help' },
          },
        },
      },
      remove_file = {
        close_window = true,
      },
    },

    view = {
      adaptive_size = false, -- Ajusta o seu tamanho automaticamente com base no tamanho do nome dos arquivos do projeto.
      width = 30,         -- width of the window, can be either a number (columns) or a string in `%`
      side = 'left',      -- side of the tree, can be one of 'left' | 'right' | 'top' | 'bottom'
      number = false,
      relativenumber = false,
    },
    trash = { cmd = 'trash', require_confirm = true },
    ui = {
      confirm = { remove = true, trash = true, default_yes = false },
    },
    experimental = {
      actions = { open_file = { relative_path = false } },
    },
  })
end

-- Run :NvimTreeHiTest to show all the highlights that nvim-tree uses.
M.highlights = {
  --- Algum mongól fez um PR que fazia um lint na ortografia dos nomes dos arquivos
  ---@see https://github.com/nvim-tree/nvim-tree.lua/wiki/FAQ#why-do-i-see-spelling-highlights
  NvimTreeExecFile = {},
}

function M._open_on_startup(data)
  local api = require('nvim-tree.api')

  -- buffer is a real file on the disk
  local is_real_file = (vim.fn.filereadable(data.file) == 1)
  -- buffer is a [No Name]
  local no_name = data.file == '' and vim.bo[data.buf].buftype == ''

  -- Se for um arquivo normal, não abre (e.g. abre em diretórios e `nvim `)
  if is_real_file and not no_name then return end
  -- if not is_real_file and not no_name then return end

  local IGNORED_FT = { 'gitcommit' }
  -- skip ignored filetypes
  local filetype = vim.bo[data.buf].ft
  if vim.tbl_contains(IGNORED_FT, filetype) then return end

  local is_directory = (vim.fn.isdirectory(data.file) == 1)
  if is_directory then
    vim.cmd.enew()      -- create a new, empty buffer
    vim.cmd.bw(data.buf) -- wipe the directory buffer
    vim.cmd.cd(data.file) -- change to the directory
  end

  api.tree.toggle({ focus = true, find_file = true })
  utils.api.feedkeys('M')
end

---@see https://github.com/nvim-tree/nvim-tree.lua/wiki/Auto-Close#rwblokzijl
function M._auto_close()
  local function tab_win_closed(winnr)
    local api = require('nvim-tree.api')
    local tabnr = vim.api.nvim_win_get_tabpage(winnr)
    local bufnr = vim.api.nvim_win_get_buf(winnr)
    local buf_info = vim.fn.getbufinfo(bufnr)[1]
    local tab_wins = vim.tbl_filter(function(w) return w ~= winnr end, vim.api.nvim_tabpage_list_wins(tabnr))
    local tab_bufs = vim.tbl_map(vim.api.nvim_win_get_buf, tab_wins)
    if buf_info.name:match('.*NvimTree_%d*$') then -- close buffer was nvim tree
      -- Close all nvim tree on :q
      if not vim.tbl_isempty(tab_bufs) then      -- and was not the last window (not closed automatically by code below)
        api.tree.close()
      end
    else                                                -- else closed buffer was normal buffer
      if #tab_bufs == 1 then                            -- if there is only 1 buffer left in the tab
        local last_buf_info = vim.fn.getbufinfo(tab_bufs[1])[1]
        if last_buf_info.name:match('.*NvimTree_%d*$') then -- and that buffer is nvim tree
          vim.schedule(function()
            if #vim.api.nvim_list_wins() == 1 then      -- if its the last buffer in vim
              vim.cmd('quit')                           -- then close all of vim
            else                                        -- else there are more tabs open
              vim.api.nvim_win_close(tab_wins[1], true) -- then close only the tab
            end
          end)
        end
      end
    end
  end

  local winnr = tonumber(vim.fn.expand('<amatch>'))
  ---@diagnostic disable-next-line: param-type-mismatch
  vim.schedule_wrap(tab_win_closed(winnr))
end

function M._win_closed(args)
  local tree = require('nvim-tree.api').tree

  -- Nothing to do if tree is not opened
  if not tree.is_visible() then return end

  -- How many focusable windows do we have? (excluding e.g. incline status window)
  local winCount = 0
  for _, winId in ipairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_win_get_config(winId).focusable then winCount = winCount + 1 end
  end

  -- We want to quit and only one window besides tree is left
  if args.event == 'QuitPre' and winCount == 2 then vim.api.nvim_cmd({ cmd = 'qall' }, {}) end

  -- :bd was probably issued an only tree window is left
  -- Behave as if tree was closed (see `:h :bd`)
  if args.event == 'BufEnter' and winCount == 1 then
    -- Required to avoid "Vim:E444: Cannot close last window"
    vim.defer_fn(function()
      -- close nvim-tree: will go to the last buffer used before closing
      tree.toggle({ find_file = true, focus = true })
      -- re-open nivm-tree
      tree.toggle({ find_file = true, focus = false })
    end, 10)
  end
end

function M._custom_commands()
  local lib = require('nvim-tree.lib')
  local api = require('nvim-tree.api')

  return {
    swap_then_open_tab = function()
      local node = lib.get_node_at_cursor()
      if node == nil then return end
      vim.cmd('wincmd l')
      api.node.open.tab(node)
    end,

    collapse_all = function()
      require('nvim-tree.actions.tree-modifiers.collapse-all').fn() --
    end,

    expand = function() -- open as vsplit on current node
      local node = lib.get_node_at_cursor()
      if node == nil then return end

      if node.nodes ~= nil then lib.expand_or_collapse(node) end
    end,

    git_add = function()
      local node = lib.get_node_at_cursor()
      if not node then return end

      local gs = node.git_status.file

      -- If the file is untracked, unstaged or partially staged, we stage it
      if gs == '??' or gs == 'MM' or gs == 'AM' or gs == ' M' then
        vim.cmd('silent !git add ' .. node.absolute_path)

        -- If the file is staged, we unstage
      elseif gs == 'M ' or gs == 'A ' then
        vim.cmd('silent !git restore --staged ' .. node.absolute_path)
      end
    end,

    open_tab_silent = function(node)
      api.node.open.tab(node)
      vim.cmd.tabprev()
    end,
  }
end

function M.focusOrToggle()
  local nvimTree = require('nvim-tree.api')
  local currentBuf = vim.api.nvim_get_current_buf()
  local currentBufFt = vim.api.nvim_get_option_value('filetype', { buf = currentBuf })
  if currentBufFt == 'NvimTree' then
    nvimTree.tree.toggle()
  else
    nvimTree.tree.focus()
  end
end

return M
