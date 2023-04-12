local function ensure_packer()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end
local is_boostrap = ensure_packer()


pcall(require, "impatient") -- performance
return require("packer").startup(function(use)

	local function setup(file, requires)
		local cfg = require("plugins." .. file).setup()
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
	setup("moviment.marks") -- marks

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

	use("tpope/vim-surround")    -- cs"'
	use("tpope/vim-repeat")      -- deixa o vim-surrond usar o '.'
	-- -- -- use("mg979/vim-visual-multi")
	use("wellle/targets.vim")    -- adiciona novos textobjects
	use("AndrewRadev/undoquit.vim") -- restaurar tabs fechadas
	use("inkarkat/vim-ReplaceWithRegister") -- ["x]gr{motion}

	--  ╭──────────────────────────────────────────────────────────╮
	--  │                           LSP                            │
	--  ╰──────────────────────────────────────────────────────────╯

	setup("lsp.mason", {
		"neovim/nvim-lspconfig",          -- LSP
		"williamboman/mason-lspconfig.nvim", -- integrar mason com lspconfig
		"jay-babu/mason-null-ls.nvim",    -- deixa mais fácil usar mason + null-ls
		"jose-elias-alvarez/nvim-lsp-ts-utils", -- utils pra typescript
	})

	setup("lsp.lsp_signature") -- mostra a function signature enquanto digita
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

	setup("cmp", {
		"hrsh7th/cmp-nvim-lsp", -- nvim-cmp source for neovim's built-in LSP
		"hrsh7th/cmp-path", -- nvim-cmp source for filesystem paths.
		"hrsh7th/cmp-cmdline", -- nvim-cmp source for vim's cmdline.
		"hrsh7th/cmp-buffer", -- nvim-cmp source for buffer words
		"hrsh7th/cmp-nvim-lua", -- nvim-cmp source for Neovim Lua API.
		"davidsierradz/cmp-conventionalcommits",
		"David-Kunz/cmp-npm", -- autocomplete npm packages and its versions
		"saadparwaiz1/cmp_luasnip",
		"onsails/lspkind.nvim", -- Auto completions gui tipo do vscode
		"zbirenbaum/copilot.lua", -- Copilot
		"zbirenbaum/copilot-cmp",
		-- { "tzachar/cmp-tabnine", run = "./install.sh" },
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
		"JoosepAlviste/nvim-ts-context-commentstring", -- conserta comments para jsx,
		"RRethy/nvim-treesitter-endwise",        -- Coloca o end no final de func e if
	})

	--  ╭──────────────────────────────────────────────────────────╮
	--  │                        Languages                         │
	--  ╰──────────────────────────────────────────────────────────╯

	setup("language.flutter-tools")
	use("jose-elias-alvarez/typescript.nvim") -- + funcionalidades pro ts_server (e.g. rename file & update imports)


	--  ╭──────────────────────────────────────────────────────────╮
	--  │                           Git                            │
	--  ╰──────────────────────────────────────────────────────────╯

	setup("git.vim-fugitive") -- base git plugin
	setup("git.gitsigns")  -- gutter signs

	-- |───────────────────────────────────────────────────────────|
	if is_boostrap then -- Bootstrap Neovim
		require("packer").sync()
	end
end)
