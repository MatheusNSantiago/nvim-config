local function ensure_packer()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
        vim.cmd([[packadd packer.nvim]])
        return true
    end
    return false
end
local is_bootstrap = ensure_packer()

pcall(require, 'impatient') -- performance
return require('packer').startup(function(use)
    local function setup(file, requires)
        local plugin = file:match('([^.]*)$')
        local setup_ok, _setup = utils.pcall('Erro no setup do plugin: ' .. plugin, require('plugins.' .. file).setup)
        if setup_ok and type(_setup) == 'table' then
            if requires ~= nil then _setup.requires = requires end -- adiciona dependências
            utils.pcall('Erro na config do plugin: ' .. plugin, use, _setup)
        end
    end

    --  ╭──────────────────────────────────────────────────────────╮
    --  │                          Base                            │
    --  ╰──────────────────────────────────────────────────────────╯

    use('wbthomason/packer.nvim') -- Package Manager
    use('lewis6991/impatient.nvim') -- performance
    use('nvim-lua/plenary.nvim') -- Common utilities

    --  ╭──────────────────────────────────────────────────────────╮
    --  │                        Interface                         │
    --  ╰──────────────────────────────────────────────────────────╯

    setup('ui.tokyonight') -- Tema
    setup('ui.nvim-tree') -- File Explorer
    setup('ui.lualine') -- Status Line
    setup('ui.indent-blankline')
    setup('ui.web-devicons')
    setup('ui.toggleterm') -- Terminal
    setup('ui.bufferline') -- Tabs/buffers
    setup('ui.dressing') -- selection e input
    setup('ui.noice', { -- messages, cmdline and popupmenu
        'MunifTanjim/nui.nvim',
    })
    setup('ui.nvim-navic')       -- 	breadcrumbs
    setup('ui.nvim-notify')      -- messages, cmdline and popupmenu
    setup('ui.nvim-colorizer')   -- #FFF ficar com o background branco
    setup('ui.smart-splits')     -- split pane management
    setup('ui.vim-scrollbar')    -- scrollbar
    setup('ui.todo-comments')    -- highlight TODO, FIXME, etc...
    setup('ui.hlsearch')         -- auto remove search highlight and rehighlight

    use('sitiom/nvim-numbertoggle') -- automatic relative/absolute line numbers

    --  ╭──────────────────────────────────────────────────────────╮
    --  │                        Navigation                        │
    --  ╰──────────────────────────────────────────────────────────╯

    setup('navigation.telescope', {
        'nvim-telescope/telescope-media-files.nvim',            -- mostra arquivos de mídia
        'danielfalk/smart-open.nvim',                           --  melhora o ranking do find files
        'kkharji/sqlite.lua',                                   -- dependencia do smart-open
        { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }, -- melhora a performance
    })
    setup('navigation.hop')                                     -- tipo o easymotion
    setup('navigation.tabout')                                  -- tabout
    setup('navigation.marks')                                   -- marks
    setup('navigation.nvim-navbuddy')                           -- outline
    setup('navigation.readline')                                -- Readline motions and deletions (igual do terminal)
    setup('navigation.leap')                                    -- sneap + easymotion
    setup('navigation.flit')                                    -- Repeat jump by pressing f, F, t, T again
    setup('navigation.vim-matchup')                             -- highlight, navigate, and operate on %

    use('itchyny/vim-highlighturl')                             -- highlight URLs

    --  ╭──────────────────────────────────────────────────────────╮
    --  │                          Edição                          │
    --  ╰──────────────────────────────────────────────────────────╯

    setup('edit.vim-autopairs') -- Completar (), [], {}
    setup('edit.stay-in-place') -- mantém a posição do mouse ao indentar
    setup('edit.comment')    -- "gcc" to comment visual regions/lines
    setup('edit.comment-box') -- comment box
    setup('edit.prettier')
    setup('edit.nvim-ufo', { -- folding
        'kevinhwang91/promise-async',
    })
    setup('edit.template-string')  -- muda pra template-string automaticamente
    setup('edit.vim-visual-multi') -- multicursor
    setup('edit.neogen')           -- documentation generation
    setup('edit.undotree')         -- undo tree
    setup('edit.vim-textobj-comment') -- comment text objects
    setup('edit.mini-move')        -- Move lines and selections
    setup('edit.nvim-neoclip')     -- clipboard manager
    setup('edit.leap-spooky')      -- operar em text objects a distância

    use('tpope/vim-surround')      -- cs"'
    use('tpope/vim-repeat')        -- deixa o vim-surrond usar o '.'
    use('wellle/targets.vim')      -- adiciona novos textobjects
    use('AndrewRadev/undoquit.vim') -- restaurar tabs fechadas

    --  ╭──────────────────────────────────────────────────────────╮
    --  │                           LSP                            │
    --  ╰──────────────────────────────────────────────────────────╯

    setup('lsp.mason', {
        'neovim/nvim-lspconfig',       -- LSP
        'williamboman/mason-lspconfig.nvim', -- integrar mason com lspconfig
        'jay-babu/mason-null-ls.nvim', -- deixa mais fácil usar mason + null-ls
    })

    setup('lsp.lsp_signature') -- mostra a function signature enquanto digita
    setup('lsp.null-ls')     -- Diagnostics/Formating/Code Actions
    setup('lsp.lspsaga')     -- LSP UIs
    setup('lsp.illuminate')  -- higlight a palavra em cima do cursor
    setup('lsp.lsp-colors')  -- agrupa os erros do LSP por cor

    use('b0o/schemastore.nvim') -- schemas para json
    use('folke/neodev.nvim') -- docs for nvim Lua API

    --  ╭──────────────────────────────────────────────────────────╮
    --  │                         Snippets                         │
    --  ╰──────────────────────────────────────────────────────────╯

    setup('cmp.luasnip')
    use('rafamadriz/friendly-snippets')

    --  ╭──────────────────────────────────────────────────────────╮
    --  │                       Completions                        │
    --  ╰──────────────────────────────────────────────────────────╯

    setup('cmp', {
        'hrsh7th/cmp-nvim-lsp',            -- nvim-cmp source for neovim's built-in LSP
        'hrsh7th/cmp-path',                -- nvim-cmp source for filesystem paths.
        'hrsh7th/cmp-cmdline',             -- nvim-cmp source for vim's cmdline.
        'hrsh7th/cmp-buffer',              -- nvim-cmp source for buffer words
        'hrsh7th/cmp-nvim-lua',            -- nvim-cmp source for Neovim Lua API.
        'davidsierradz/cmp-conventionalcommits', -- autocomplete conventional commits
        'saadparwaiz1/cmp_luasnip',        -- completion engine
        'lukas-reineke/cmp-under-comparator', -- better sort completion items that start with one or more underlines
        'onsails/lspkind.nvim',            -- Auto completions gui tipo do vscode
        'zbirenbaum/copilot.lua',          -- Copilot
        'zbirenbaum/copilot-cmp',
    })

    --  ╭──────────────────────────────────────────────────────────╮
    --  │                        Treesitter                        │
    --  ╰──────────────────────────────────────────────────────────╯

    setup('treesitter', {
        'nvim-treesitter/nvim-treesitter-refactor',                      -- Refactorings via treesitter
        { 'nvim-treesitter/nvim-treesitter-textobjects', commit = '8673926' }, -- Additional text objects via treesitter
        'RRethy/nvim-treesitter-textsubjects',
        'p00f/nvim-ts-rainbow',                                          -- rainbow parentheses
        'windwp/nvim-ts-autotag',                                        -- tag completion
        'JoosepAlviste/nvim-ts-context-commentstring',                   -- conserta comments para jsx,
        'RRethy/nvim-treesitter-endwise',                                -- Coloca o end no final de func e if
    })

    --  ╭──────────────────────────────────────────────────────────╮
    --  │                       Development                        │
    --  ╰──────────────────────────────────────────────────────────╯

    setup('dev.flutter', {
        'Nash0x7E2/awesome-flutter-snippets', -- snippets
        'akinsho/pubspec-assist.nvim',  -- add/update dart dependencies
    })

    use('jose-elias-alvarez/typescript.nvim') -- + funcionalidades pro ts_server (e.g. rename file & update imports)
    use('Vimjas/vim-python-pep8-indent')   -- Conserta o indent do python

    --  ╭──────────────────────────────────────────────────────────╮
    --  │                           Git                            │
    --  ╰──────────────────────────────────────────────────────────╯

    setup('git.vim-fugitive') -- base git plugin
    setup('git.gitsigns')  -- gutter signs

    --  ╭──────────────────────────────────────────────────────────╮
    --  │                          Debug                           │
    --  ╰──────────────────────────────────────────────────────────╯

    setup('debug', {
        'rcarriga/nvim-dap-ui',
        'mfussenegger/nvim-dap-python',
        'theHamsta/nvim-dap-virtual-text',
    })
    -- |───────────────────────────────────────────────────────────|

    if is_bootstrap then -- Bootstrap Neovim
        require('packer').sync()
    end
end)
