-- local M = {}
--
-- function M.setup()
-- Indicate first time installation
local is_boostrap = false

local function plugins(use)
	local function setup(file, requires)
		local cfg = require("config.plugins." .. file).setup()
		cfg.requires = requires
		local success, _ = pcall(use, cfg)
		if not success then
			vim.notify("Error loading plugin: " .. file, vim.log.levels.WARN)
		end
	end

	--  ╭──────────────────────────────────────────────────────────╮
	--  │                          Base                            │
	--  ╰──────────────────────────────────────────────────────────╯

	use("wbthomason/packer.nvim") -- Package Manager
	use("lewis6991/impatient.nvim") -- performance
	use("nvim-lua/plenary.nvim") -- Common utilities

	--  ╭──────────────────────────────────────────────────────────╮
	--  │                        Interface                         │
	--  ╰──────────────────────────────────────────────────────────╯

	setup("ui.tokyonight") -- Tema
	use({ "catppuccin/nvim", as = "catppuccin" })

	setup("ui.nvim-tree") -- File Explorer
	setup("ui.lualine") -- Status Line
	setup("ui.indent-blankline")
	setup("ui.web-devicons")
	setup("ui.toggleterm") -- Terminal
	setup("ui.bufferline") -- Tabs/buffers
	setup("ui.dressing") -- selection e input
	setup("ui.noice", { -- messages, cmdline and popupmenu
		"MunifTanjim/nui.nvim",
	})
	setup("ui.nvim-notify") -- messages, cmdline and popupmenu
	setup("ui.nvim-colorizer") -- #FFF ficar com o background branco

	use("tpope/vim-sleuth") -- Detect tabstop and shiftwidth automatically

	--  ╭──────────────────────────────────────────────────────────╮
	--  │                       Movimentação                       │
	--  ╰──────────────────────────────────────────────────────────╯

	setup("moviment.telescope", {
		{ "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
	})
	setup("moviment.hop") -- tipo o easymotion
	setup("moviment.tabout") -- tabout

	--  ╭──────────────────────────────────────────────────────────╮
	--  │                          Edição                          │
	--  ╰──────────────────────────────────────────────────────────╯

	setup("edit.vim-autopairs") -- Completar (), [], {}
	setup("edit.stay-in-place") -- mantém a posição do mouse ao indentar
	setup("edit.comment")    -- "gcc" to comment visual regions/lines
	setup("edit.comment-box") -- comment box
	setup("edit.prettier")
	setup("edit.nvim-ufo", { -- folding
		"kevinhwang91/promise-async",
	})
	setup("edit.template-string") -- muda pra template-string automaticamente

	use("tpope/vim-surround")    -- (cs"'
	use("tpope/vim-repeat")      -- deixa o vim-surrond usar o '.'
	-- -- use("mg979/vim-visual-multi")
	use("wellle/targets.vim")    -- adiciona novos textobjects
	use("AndrewRadev/undoquit.vim") -- restaurar tabs fechadas

	--  ╭──────────────────────────────────────────────────────────╮
	--  │                           LSP                            │
	--  ╰──────────────────────────────────────────────────────────╯

	setup("lsp.mason", {
		"neovim/nvim-lspconfig",       -- LSP
		"jay-babu/mason-null-ls.nvim", -- deixa mais fácil usar mason + null-ls
		"williamboman/mason-lspconfig.nvim", -- configs pro mason funfar
		"jose-elias-alvarez/nvim-lsp-ts-utils",
	})
	setup("lsp.null-ls")     -- Diagnostics/Formating/Code Actions
	setup("lsp.lspsaga")     -- LSP UIs
	setup("lsp.illuminate")  -- higlight a palavra em cima do cursor
	setup("lsp.lsp-colors")  -- agrupa os erros do LSP por cor
	setup("lsp.hlargs")      -- highlight argumentos

	use("b0o/schemastore.nvim") -- schemas para json
	use("folke/neodev.nvim") -- docs for nvim Lua API

	--  ╭──────────────────────────────────────────────────────────╮
	--  │                         Snippets                         │
	--  ╰──────────────────────────────────────────────────────────╯

	use("L3MON4D3/LuaSnip")
	use("rafamadriz/friendly-snippets")

	--  ╭──────────────────────────────────────────────────────────╮
	--  │                       Completions                        │
	--  ╰──────────────────────────────────────────────────────────╯

	setup("copilot")      -- copilot
	setup("cmp", {
		"hrsh7th/cmp-buffer", -- nvim-cmp source for buffer words
		"hrsh7th/cmp-path", -- nvim-cmp source for filesystem paths.
		"hrsh7th/cmp-cmdline", -- nvim-cmp source for vim's cmdline.
		"hrsh7th/cmp-nvim-lsp", -- nvim-cmp source for neovim's built-in LSP
		"hrsh7th/cmp-nvim-lua", -- nvim-cmp source for Neovim Lua API.
		"David-Kunz/cmp-npm", -- autocomplete npm packages and its versions
		"saadparwaiz1/cmp_luasnip",
		"onsails/lspkind.nvim", -- Auto completions gui tipo do vscode
		"zbirenbaum/copilot-cmp",
	})

	--  ╭──────────────────────────────────────────────────────────╮
	--  │                        Treesitter                        │
	--  ╰──────────────────────────────────────────────────────────╯

	setup("treesitter", {
		"nvim-treesitter/nvim-treesitter-refactor", -- Refactorings via treesitter
		"nvim-treesitter/nvim-treesitter-textobjects", -- Additional text objects via treesitter
		"RRethy/nvim-treesitter-textsubjects",
		"p00f/nvim-ts-rainbow",                  -- rainbow parentheses
		"windwp/nvim-ts-autotag",                -- tag completion
		"JoosepAlviste/nvim-ts-context-commentstring", -- conserta comments para jsx
	})

	--  ╭──────────────────────────────────────────────────────────╮
	--  │                        Languages                         │
	--  ╰──────────────────────────────────────────────────────────╯

	setup("language.flutter-tools")
	use("jose-elias-alvarez/typescript.nvim")

	-- Bootstrap Neovim
	if is_boostrap then
		require("packer").sync()
	end
end

-- packer.nvim configuration
local conf = {
	profile = {
		enable = false,
		threshold = 0, -- the amount in ms that a plugins load time must be over for it to be included in the profile
	},
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
}

-- Check if packer.nvim is installed
-- Run PackerCompile if there are changes in this file
local function packer_init()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({
			"git",
			"clone",
			"--depth",
			"1",
			"https://github.com/wbthomason/packer.nvim",
			install_path,
		})
		is_boostrap = true
		vim.cmd([[packadd packer.nvim]])
	end
end

-- Init and start packer
packer_init()
local packer = require("packer")

-- Performance
pcall(require, "impatient")
-- pcall(require, "packer_compiled")

packer.init(conf)
packer.startup(plugins)
-- end
--
-- return M
-- return M
