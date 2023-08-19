local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local function setup(file, dependencies)
  local plugin = file:match('([^.]*)$')
  local setup_ok, _setup = utils.pcall('Erro no setup do plugin: ' .. plugin, require('plugins.' .. file).setup)
  if setup_ok and type(_setup) == 'table' then
    if dependencies ~= nil then _setup.dependencies = dependencies end -- adiciona dependências
    return _setup
  end
end

require('lazy').setup({
  {
    'dstein64/vim-startuptime',
    cmd = 'StartupTime',
    init = function() vim.g.startuptime_tries = 80 end,
    keys = { { '<leader><leader>s', ':StartupTime<CR>' } },
  },

  --  ╭──────────────────────────────────────────────────────────╮
  --  │                          Base                            │
  --  ╰──────────────────────────────────────────────────────────╯

  'nvim-lua/plenary.nvim', -- Common utilities

  --  ╭──────────────────────────────────────────────────────────╮
  --  │                        Interface                         │
  --  ╰──────────────────────────────────────────────────────────╯

  setup('ui.tokyonight'),             -- Tema
  setup('ui.web-devicons'),           -- icones
  setup('ui.nvim-tree'),              -- File Explorer
  setup('ui.lualine'),                -- Status Line
  setup('ui.hlchunk'),                -- indentação/context
  setup('ui.toggleterm'),             -- Terminal
  setup('ui.bufferline'),             -- Tabs/buffers
  setup('ui.dressing'),               -- selection e input
  setup('ui.noice'),                  -- messages, cmdline and popupmenu
  setup('ui.barbecue'),               -- 	breadcrumbs
  setup('ui.nvim-notify'),            -- messages, cmdline and popupmenu
  setup('ui.ccc'),                    -- Color picker and highlighter #FFF
  setup('ui.smart-splits'),           -- split pane management
  setup('ui.vim-scrollbar'),          -- scrollbar
  setup('ui.todo-comments'),          -- highlight TODO, FIXME, etc...
  setup('ui.hlsearch'),               -- auto remove search highlight and rehighlight
  setup('ui.rainbow-delimiters'),     -- rainbow parentheses
  setup('ui.trouble'),                -- pretty diagnostics, refs, quickfix
  -- setup('ui.pretty-hover'),
  setup('ui.nvim-treesitter-context'), -- mostra qual a função/classe tu tá

  'sitiom/nvim-numbertoggle',         -- automatic relative/absolute line numbers

  --  ╭──────────────────────────────────────────────────────────╮
  --  │                        Navigation                        │
  --  ╰──────────────────────────────────────────────────────────╯

  setup('navigation.telescope'),
  { 'nvim-telescope/telescope-fzf-native.nvim',  build = 'make',                          lazy = true }, -- melhora a performance
  { 'nvim-telescope/telescope-media-files.nvim', lazy = true },                          -- mostra arquivos de mídia
  { 'danielfalk/smart-open.nvim',                dependencies = { 'kkharji/sqlite.lua' }, lazy = true }, --  melhora o ranking do find files
  { 'debugloop/telescope-undo.nvim',             lazy = true },                          -- undo true

  setup('navigation.hop'),                                                               -- tipo o easymotion
  setup('navigation.tabout'),                                                            -- tabout
  setup('navigation.marks'),                                                             -- marks
  setup('navigation.nvim-navbuddy'),                                                     -- outline
  setup('navigation.readline'),                                                          -- Readline motions and deletions (igual do terminal)
  setup('navigation.leap'),                                                              -- sneap + easymotion
  setup('navigation.flit'),                                                              -- Repeat jump by pressing f, F, t, T again
  setup('navigation.vim-matchup'),                                                       -- highlight, navigate, and operate on %

  'itchyny/vim-highlighturl',                                                            -- highlight URLs

  --  ╭──────────────────────────────────────────────────────────╮
  --  │                          Edição                          │
  --  ╰──────────────────────────────────────────────────────────╯

  setup('edit.vim-autopairs'), -- Completar (), [], {}
  setup('edit.stay-in-place'), -- mantém a posição do mouse ao indentar
  setup('edit.comment'),      -- "gcc" to comment visual regions/lines
  setup('edit.comment-box'),  -- comment box
  setup('edit.prettier'),
  setup('edit.nvim-ufo'),     -- folding
  -- setup('edit.template-string')    -- muda pra template-string automaticamente

  setup('edit.vim-visual-multi'),   -- multicursor
  setup('edit.neogen'),             -- documentation generation
  setup('edit.vim-textobj-comment'), -- comment text objects
  setup('edit.mini-move'),          -- Move lines and selections
  setup('edit.nvim-neoclip'),       -- clipboard manager
  setup('edit.leap-spooky'),        -- operar em text objects a distância
  setup('edit.guess-indent'),       -- automatically detect the indentation settings
  setup('edit.refactoring'),
  setup('edit.icon-picker'),
  setup('edit.mini-ai'),

  setup('edit.nvim-surround'),                       -- cs"'
  { 'tpope/vim-repeat',         event = 'VeryLazy' }, -- deixa o vim-surrond usar o '.'
  { 'AndrewRadev/undoquit.vim', event = 'BufLeave' }, -- restaurar tabs fechadas

  --  ╭──────────────────────────────────────────────────────────╮
  --  │                           LSP                            │
  --  ╰──────────────────────────────────────────────────────────╯

  setup('lsp.null-ls'), -- Diagnostics/Formating/Code Actions

  setup('lsp.mason'),
  { 'neovim/nvim-lspconfig',             lazy = true }, -- LSP
  { 'williamboman/mason-lspconfig.nvim', lazy = true }, -- integrar mason com lspconfig
  { 'jay-babu/mason-null-ls.nvim',       lazy = true }, -- deixa mais fácil usar mason + null-ls

  setup('lsp.lsp_signature'),                          -- mostra a function signature enquanto digita
  setup('lsp.lspsaga'),                                -- LSP UIs
  setup('lsp.illuminate'),                             -- higlight a palavra em cima do cursor
  setup('lsp.lsp-colors'),                             -- agrupa os erros do LSP por cor

  { 'b0o/schemastore.nvim', lazy = true },             -- schemas para json
  { 'folke/neodev.nvim',    lazy = true },             -- docs for nvim Lua API

  --  ╭──────────────────────────────────────────────────────────╮
  --  │                         Snippets                         │
  --  ╰──────────────────────────────────────────────────────────╯

  setup('cmp.luasnip'),
  { 'rafamadriz/friendly-snippets',          lazy = true },

  --  ╭──────────────────────────────────────────────────────────╮
  --  │                       Completions                        │
  --  ╰──────────────────────────────────────────────────────────╯

  setup('cmp'),
  { 'hrsh7th/cmp-nvim-lsp',                  lazy = true },          -- nvim-cmp source for neovim's built-in LSP
  { 'hrsh7th/cmp-path',                      lazy = true },          -- nvim-cmp source for filesystem paths.
  { 'hrsh7th/cmp-cmdline',                   event = 'CmdlineEnter' }, -- nvim-cmp source for vim's cmdline.
  { 'hrsh7th/cmp-buffer',                    lazy = true },          -- nvim-cmp source for buffer words
  { 'hrsh7th/cmp-nvim-lua',                  lazy = true },          -- nvim-cmp source for Neovim Lua API.
  { 'davidsierradz/cmp-conventionalcommits', lazy = true },          -- autocomplete conventional commits
  { 'saadparwaiz1/cmp_luasnip',              lazy = true },          -- completion engine
  { 'lukas-reineke/cmp-under-comparator',    lazy = true },          -- better sort completion items that start with one or more underlines
  { 'onsails/lspkind.nvim',                  lazy = true },          -- Auto completions gui tipo do vscode
  { 'zbirenbaum/copilot.lua',                lazy = true },          -- Copilot
  { 'zbirenbaum/copilot-cmp',                build = ':Copilot auth', lazy = true }, -- completion do copilot

  --  ╭──────────────────────────────────────────────────────────╮
  --  │                        Treesitter                        │
  --  ╰──────────────────────────────────────────────────────────╯
  setup('treesitter'),
  { 'nvim-treesitter/nvim-treesitter-textobjects', commit = '8673926' }, -- Additional text objects via treesitter
  { 'RRethy/nvim-treesitter-textsubjects',         lazy = true },
  { 'JoosepAlviste/nvim-ts-context-commentstring', lazy = true },       -- conserta comments para jsx,
  { 'fladson/vim-kitty',                           ft = { 'kitty', 'conf' } }, -- syntax highlighting for kitty
  'windwp/nvim-ts-autotag',                                             -- tag completion
  'RRethy/nvim-treesitter-endwise',                                     -- Coloca o end no final de func e if

  --  ╭──────────────────────────────────────────────────────────╮
  --  │                       Development                        │
  --  ╰──────────────────────────────────────────────────────────╯

  setup('dev.flutter-tools'),
  { 'akinsho/pubspec-assist.nvim',                              config = true, ft = 'yaml' }, -- add/update dart dependencies

  { 'Nash0x7E2/awesome-flutter-snippets',                       ft = 'dart' }, -- snippets

  -- setup('dev.chatGPT'),
  { dir = '~/Documents/Programming/nvim-plugins/ChatGPT.nvim/', config = true, lazy = true },
  { 'jose-elias-alvarez/typescript.nvim',                       lazy = true }, -- typescript lsp
  { 'Vimjas/vim-python-pep8-indent',                            ft = 'python' }, -- Conserta o indent do python

  --  ╭──────────────────────────────────────────────────────────╮
  --  │                           Git                            │
  --  ╰──────────────────────────────────────────────────────────╯

  setup('git.vim-fugitive'), -- base git plugin
  setup('git.gitsigns'),    -- gutter signs
  setup('git.diffview'),

  --  ╭──────────────────────────────────────────────────────────╮
  --  │                          Debug                           │
  --  ╰──────────────────────────────────────────────────────────╯

  setup('debug'),
  { 'rcarriga/nvim-dap-ui',            lazy = true },
  { 'mfussenegger/nvim-dap-python',    lazy = true },
  { 'theHamsta/nvim-dap-virtual-text', lazy = true },
})
