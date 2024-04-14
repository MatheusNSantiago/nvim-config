local M = {}
local keymap = utils.api.keymap

function M.setup()
  return {
    'akinsho/toggleterm.nvim',
    cmd = { 'ToggleTerm', 'TermExec', 'TermOpen' },
    config = M.config,
    keys = M.keys,
  }
end

function M.keys()
  local is_first_time_opening = true

  utils.api.augroup('ToggleTerm', {
    event = 'TermOpen',
    pattern = 'term://*',
    command = function(args)
      keymap('t', '<ESC>', [[<C-\><C-n>]], { buffer = args.buf })
      keymap('t', '<A-e>', [[<ESC><Cmd>NvimTreeToggle<CR>]], { buffer = args.buf })

      -- Nover o cursor entre janelas
      keymap('t', '<C-j>', [[<Cmd>wincmd h<CR>]], { buffer = args.buf })
      keymap('t', '<C-k>', [[<Cmd>wincmd j<CR>]], { buffer = args.buf })
      keymap('t', '<C-l>', [[<C-\><C-n>:wincmd k<CR>]], { buffer = args.buf })
      keymap('t', '<C-ç>', [[<ESC><Cmd>wincmd l<CR>]], { buffer = args.buf })

      -- Tira aquele highlight que fica na linha inteira quando vc deixa o cursor em cima
      vim.wo.cursorline = M.should_show_cursorline(args.buf)

      -- Problema: o breadcrumbs (barbecue) aparecia quando eu abria o terminal pela primeira vez
      -- Observação: Quando eu mudava pro normal mode, o barbecue sumia
      -- Solução: Começar no normal mode (start_in_insert = false), esperar o breadcumbs processar (100 milisegundos) e voltar pro insert mode
      vim.defer_fn(function() vim.cmd('startinsert') end, 100)
      is_first_time_opening = false
    end,
  }, {
    event = 'Filetype',
    pattern = 'toggleterm',
    command = function(_)
      if is_first_time_opening then return end

      -- Ao entrar no toggleterm, ele já começa no insert mode
      -- Esse autocmd é diferente do outro, pois esse proca toda vez que eu entro no toggleterm (além de não ter delay)
      vim.schedule(function() vim.cmd('startinsert') end)
    end,
  })

  local function open(direction) return "<CMD>execute v:count . 'ToggleTerm direction=" .. direction .. "'<CR>" end
  -- Por algum motivo, o 't' não funciona se eu colocar no keymapper do lazy, então eu coloquei aqui
  keymap('t', '<A-f>', open('float'))
  keymap('t', '<A-i>', open('horizontal'))
  keymap('t', '<A-v>', open('vertical'))
  return {
    { '<leader>lg', M.toggle_lazygit,   desc = 'toggleterm: toggle lazygit' },
    { '<leader>ld', M.toggle_lazydocker,   desc = 'toggleterm: toggle lazydocker' },
    { '<A-f>',      open('float'),      mode = { 'i', 'n', 'x' },           desc = 'toggleterm: floating terminal' },
    { '<A-i>',      open('horizontal'), mode = { 'i', 'n', 'x' },           desc = 'toggleterm: horizontal terminal' },
    { '<A-v>',      open('vertical'),   mode = { 'i', 'n', 'x' },           desc = 'toggleterm: vertical terminal' },
  }
end

function M.config()
  require('toggleterm').setup({
    -- size can be a number or function which is passed the current terminal
    size = function(term)
      if term.direction == 'horizontal' then
        return vim.o.lines * 0.30
      elseif term.direction == 'vertical' then
        return vim.o.columns * 0.25
      end
    end,
    hide_numbers = true, -- hide the number column in toggleterm buffers
    shade_filetypes = {},
    shade_terminals = false,
    shading_factor = '0',  -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
    start_in_insert = false,
    insert_mappings = false, -- whether or not the open mapping applies in insert mode
    persist_size = false,
    on_open = function(t)
      if t.direction == 'horizontal' then
        local nvim_tree_ok, api = pcall(require, 'nvim-tree.api')
        local tree = api.tree

        if nvim_tree_ok then
          if tree.is_visible() then
            tree.close()
            tree.toggle({ focus = false })
          end
        end
      end
    end, -- function to run when the terminal opens
    on_close = function(t)
      -- local lualine_ok, lualine = pcall(require, "lualine")
      -- lualine.hide({ unhide = true })
    end,                    -- function to run when the terminal closes
    direction = 'horizontal', --'horizontal', -- 'vertical' | 'horizontal' | 'window' | 'float',
    close_on_exit = true,   -- close the terminal window when the process exits
    shell = vim.o.shell,    -- change the default shell
    -- This field is only relevant if direction is set to 'float'
    float_opts = {
      -- The border key is *almost* the same as 'nvim_open_win'
      -- see :h nvim_open_win for details on borders however
      -- the 'curved' border is a custom border type
      -- not natively supported but implemented in this plugin.
      border = 'curved', --'single' | 'double' | 'shadow' | 'curved' | ... other options supported by win open
      width = math.floor(vim.o.columns * 0.65),
      height = 15,
      winblend = 0,
      highlights = {
        border = 'Normal',
        background = 'Normal',
      },
    },
    highlights = {
      -- highlights which map to a highlight group name and a table of it's values
      Normal = {
        -- guifg = "red",
      },
    },
    winbar = {
      enabled = false,
      name_formatter = function(term) --  term: Terminal
        return term.name
      end,
    },
  })
end

function M.toggle_lazygit()
  local Terminal = require('toggleterm.terminal').Terminal

  local lazygit = Terminal:new({
    cmd = 'lazygit',
    dir = 'git_dir',
    close_on_exit = true,
    hidden = true,
    direction = 'float',
    float_opts = {
      width = 10000, -- math.floor(vim.o.columns * 0.65),
      height = 10000, -- math.floor(vim.o.lines * 0.70),
      border = 'none', --'single' | 'double' | 'shadow' | 'curved' | ... other options supported by win open
      winblend = 0,
      highlights = { border = 'Normal', background = 'Normal' },
    },
    -- function to run on opening the terminal
    on_open = function(term) vim.cmd('startinsert!') end,
    -- function to run on closing the terminal
    on_close = function(_)
      vim.cmd('startinsert!')
      vim.schedule(function() vim.cmd('edit') end)
    end,
  })

  return lazygit:toggle()
end

function M.toggle_lazydocker()
  local Terminal = require('toggleterm.terminal').Terminal

  local lazygit = Terminal:new({
    cmd = 'lazydocker',
    dir = '.',
    close_on_exit = true,
    hidden = true,
    direction = 'float',
    float_opts = {
      width = 10000, -- math.floor(vim.o.columns * 0.65),
      height = 10000, -- math.floor(vim.o.lines * 0.70),
      border = 'none', --'single' | 'double' | 'shadow' | 'curved' | ... other options supported by win open
      winblend = 0,
      highlights = { border = 'Normal', background = 'Normal' },
    },
    -- function to run on opening the terminal
    on_open = function(term) vim.cmd('startinsert!') end,
    -- function to run on closing the terminal
    on_close = function(_)
      vim.cmd('startinsert!')
      vim.schedule(function() vim.cmd('edit') end)
    end,
  })

  return lazygit:toggle()
end

---@param buf number
---@return boolean
function M.should_show_cursorline(buf)
  local cursorline_exclude = { 'alpha', 'toggleterm' }

  return vim.bo[buf].buftype ~= 'terminal'
      and not vim.wo.previewwindow
      and vim.wo.winhighlight == ''
      and vim.bo[buf].filetype ~= ''
      and not vim.tbl_contains(cursorline_exclude, vim.bo[buf].filetype)
end

function M.get_terminal(name)
  local terminal
  local buffers = vim.api.nvim_list_bufs()
  for _, buf in ipairs(buffers) do
    local buf_name = vim.api.nvim_buf_get_name(buf)
    if buf_name:find('toggleterm#') then
      local _, t = require('toggleterm.terminal').identify(buf_name)
      terminal = t
    end
  end
  return assert(terminal, 'Não achou um terminal ativo')
end

return M
