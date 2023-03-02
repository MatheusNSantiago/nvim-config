local status, packer = pcall(require, "packer")
if not status then
    print("Packer is not installed")
    return
end

vim.cmd([[packadd packer.nvim]])

packer.startup(function(use)
    use("wbthomason/packer.nvim") -- Package Manager

    -- Temas
    use("nanotech/jellybeans.vim")
    use("folke/tokyonight.nvim")

    -- Interface
    use("nvim-lualine/lualine.nvim")        -- Statusline
    use("lukas-reineke/indent-blankline.nvim") -- Add indentation guides even on blank lines
    use("tpope/vim-sleuth")                 -- Detect tabstop and shiftwidth automatically
    use("onsails/lspkind.nvim")             -- Auto completions gui tipo do vscode
    use("kyazdani42/nvim-web-devicons")     -- File icons
    use("j-hui/fidget.nvim")                -- Status updates do LSP
    use("nvim-tree/nvim-tree.lua")          -- File Explorer
    use("akinsho/toggleterm.nvim")          -- Terminal

    -- Movimentação
    use("nvim-telescope/telescope.nvim")
    use("easymotion/vim-easymotion")

    -- Outros
    use("AndrewRadev/undoquit.vim") -- restaurar tabs fechadas
    use("nvim-lua/plenary.nvim") -- Common utilities

    -- Edição
    use("windwp/nvim-autopairs")                                           -- Completar (), [], {}
    use("windwp/nvim-ts-autotag")                                          -- Completar tags
    use("gbprod/stay-in-place.nvim")                                       -- mantém a posição do mouse ao indentar
    use("numToStr/Comment.nvim")                                           -- "gcc" to comment visual regions/lines
    use("JoosepAlviste/nvim-ts-context-commentstring")                     -- conserta comments para jsx
    use("norcalli/nvim-colorizer.lua")                                     -- #FFF ficar com o background branco
    use("folke/lsp-colors.nvim")                                           -- agrupa os erros do LSP por cor
    use("tpope/vim-surround")
    use("tpope/vim-repeat")                                                -- deixa o vim-surrond usar o '.'
    use({ "kevinhwang91/nvim-ufo", requires = "kevinhwang91/promise-async" }) -- folding
    use("axelvc/template-string.nvim")                                     -- muda pra template-string automaticamente

    -- LSP Base
    use("neovim/nvim-lspconfig")          -- LSP
    use("williamboman/mason.nvim")        -- Baixar outros Language Servers dinamicamente
    use("williamboman/mason-lspconfig.nvim") -- configs pro mason funfar
    use("jose-elias-alvarez/null-ls.nvim") -- necessário para Diagnostics/Formating/Code Actions
    use("jose-elias-alvarez/nvim-lsp-ts-utils")

    -- LSP Addons
    use("glepnir/lspsaga.nvim")      -- LSP UIs
    use("lvimuser/lsp-inlayhints.nvim") -- inlay hints

    -- LSP cmp
    use("hrsh7th/nvim-cmp")  -- auto completion
    use("hrsh7th/cmp-buffer") -- nvim-cmp source for buffer words
    use("hrsh7th/cmp-path")  -- nvim-cmp source for filesystem paths.
    use("hrsh7th/cmp-nvim-lsp") -- nvim-cmp source for neovim's built-in LSP
    use("hrsh7th/cmp-nvim-lua") -- nvim-cmp source for Neovim Lua API.
    use("folke/neodev.nvim") -- docs + autocompletion for nvim Lua API

    use("L3MON4D3/LuaSnip")
    use("rafamadriz/friendly-snippets")
    use("saadparwaiz1/cmp_luasnip")

    -- Treesitter
    use({
        "nvim-treesitter/nvim-treesitter",
        run = function()
            require("nvim-treesitter.install").update({ with_sync = true })
        end,
        requires = {
            "nvim-treesitter/nvim-treesitter-refactor",
            "m-demare/hlargs.nvim",               -- highlight argumentos
            "nvim-treesitter/nvim-treesitter-textobjects", -- Additional text objects via treesitter
        },
    })

    -- Languages
    use("jose-elias-alvarez/typescript.nvim")
end)
