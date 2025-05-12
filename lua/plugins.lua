local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
---@diagnostic disable-next-line: undefined-field
if not vim.uv.fs_stat(lazypath) then
	local repo = 'https://github.com/folke/lazy.nvim.git'
	vim.fn.system({ 'git', 'clone', '--filter=blob:none', repo, '--branch=stable', lazypath })
end
vim.opt.rtp:prepend(lazypath)

local function setup(file, dependencies)
	local plugin = file:match('([^.]*)$')
	local setup_ok, _setup = utils.pcall('Erro no setup do plugin: ' .. plugin, require('plugins.' .. file).setup)
	if setup_ok then
		if dependencies ~= nil then _setup.dependencies = dependencies end -- adiciona dependências
		return _setup or {}
	end
end

local plugins = Array({

	--  ╭──────────────────────────────────────────────────────────╮
	--  │                          Base                            │
	--  ╰──────────────────────────────────────────────────────────╯

	{ 'nvim-lua/plenary.nvim' },
	{ 'kevinhwang91/promise-async' },

	--  ╭──────────────────────────────────────────────────────────╮
	--  │                        Interface                         │
	--  ╰──────────────────────────────────────────────────────────╯

	setup('ui.tokyonight'), -- Tema

	setup('ui.web-devicons'), -- icones
	setup('ui.lualine'), -- Status Line
	setup('ui.hlchunk'), -- indentação/context
	setup('ui.toggleterm'), -- Terminal
	setup('ui.bufferline'), -- Tabs/buffers
	setup('ui.dressing'), -- selection e input
	setup('ui.noice'), -- messages, cmdline and popupmenu
	setup('ui.barbecue'), -- breadcrumbs
	setup('ui.highlight-colors'), -- highlighter #FFF
	setup('ui.vim-scrollbar'), -- scrollbar
	setup('ui.todo-comments'), -- highlight TODO, FIXME, etc...
	-- setup('ui.nvim-treesitter-context'), -- mostra qual a função/classe tu tá

	'sitiom/nvim-numbertoggle', -- automatic relative/absolute line numbers

	--  ╭──────────────────────────────────────────────────────────╮
	--  │                        Navigation                        │
	--  ╰──────────────────────────────────────────────────────────╯

	setup('navigation.telescope'),
	setup('navigation.nvim-tree'), -- File Explorer
	setup('navigation.smart-splits'), -- split pane management
	setup('navigation.hop'), -- tipo o easymotion
	setup('navigation.tabout'), -- tabout
	setup('navigation.marks'), -- marks
	setup('navigation.nvim-navbuddy'), -- outline
	setup('navigation.leap'), -- sneap + easymotion
	setup('navigation.flit'), -- Repeat jump by pressing f, F, t, T again
	setup('navigation.arrow'),

	{ 'itchyny/vim-highlighturl' }, -- highlight URLs

	--  ╭──────────────────────────────────────────────────────────╮
	--  │                          Edição                          │
	--  ╰──────────────────────────────────────────────────────────╯

	setup('edit.vim-autopairs'), -- Completar (), [], {}
	setup('edit.stay-in-place'), -- mantém a posição do mouse ao indentar
	setup('edit.comment'), -- "gcc" to comment visual regions/lines
	setup('edit.comment-box'), -- comment box
	setup('edit.prettier'),
	setup('edit.nvim-ufo'), -- folding
	-- setup('edit.template-string'), -- muda pra template-string automaticamente

	setup('edit.vim-visual-multi'), -- multicursor
	setup('edit.neogen'), -- documentation generation
	setup('edit.vim-textobj-comment'), -- comment text objects
	setup('edit.mini-move'), -- Move lines and selections
	setup('edit.nvim-neoclip'), -- clipboard manager
	setup('edit.refactoring'),
	setup('edit.mini-ai'), -- text objects novos
	setup('edit.nvim-surround'), -- cs"'
	setup('edit.treesj'), -- slipt/join em blocks
	setup('edit.grug-far'), -- [F]ind [A]nd [R]eplace global igual vscode
	setup('edit.rip-substitute'), -- find and replace no buffer

	{ 'tpope/vim-repeat', event = 'VeryLazy' }, -- deixa o vim-surrond usar o '.'
	{ 'AndrewRadev/undoquit.vim', event = 'BufLeave' }, -- restaurar tabs fechadas

	--  ╭──────────────────────────────────────────────────────────╮
	--  │                           LSP                            │
	--  ╰──────────────────────────────────────────────────────────╯

	setup('lsp.conform'), -- Formatter
	setup('lsp.nvim-lint'), -- Linter

	setup('lsp.mason'),
	setup('lsp.mason-lspconfig'), -- integrar mason com lspconfig
	{ 'neovim/nvim-lspconfig' }, -- LSP

	setup('lsp.lsp_signature'), -- mostra a function signature enquanto digita
	setup('lsp.lspsaga'), -- LSP UIs
	setup('lsp.goto-preview'), -- gp

	setup('lsp.illuminate'), -- higlight a palavra em cima do cursor
	setup('lsp.symbol-usage'), -- mostra quantas referências e definições a função tem
	setup('lsp.lazydev'), -- Faster LuaLS setup for Neovim

	{ 'b0o/schemastore.nvim', lazy = true }, -- schemas para json

	--  ╭──────────────────────────────────────────────────────────╮
	--  │                        Treesitter                        │
	--  ╰──────────────────────────────────────────────────────────╯

	setup('treesitter', {
		{ 'windwp/nvim-ts-autotag', config = true }, -- tag completion
		{ 'nvim-treesitter/nvim-treesitter-textobjects' }, -- Additional text objects via treesitter. Se der ruim, commit = '8673926'
		{ 'RRethy/nvim-treesitter-textsubjects', lazy = true },
		{ 'JoosepAlviste/nvim-ts-context-commentstring', lazy = true }, -- conserta comments para jsx,
		{ 'fladson/vim-kitty', ft = { 'kitty', 'conf' } }, -- syntax highlighting for kitty
		{ 'delphinus/vim-firestore' }, -- syntax highlighting firestore rules
		{ 'davidmh/mdx.nvim', config = true }, -- syntax highlighting mdx

		{ 'RRethy/nvim-treesitter-endwise' }, -- Coloca o end no final de func e if
	}),

	--  ╭──────────────────────────────────────────────────────────╮
	--  │                       Development                        │
	--  ╰──────────────────────────────────────────────────────────╯

	setup('dev.codecompanion'), -- IA
	setup('dev.copilot'), -- Copilot
	setup('dev.timber'), -- Insert log statements and capture log results inline

	setup('dev.blink'), -- autocomplete
	setup('dev.luasnip'), -- snippets

	-- testes
	setup('dev.neotest'),
	setup('dev.kulala'), -- REST-Client

	-- Git
	setup('dev.gitsigns'), -- gutter signs
	setup('dev.diffview'),
	{ 'tpope/vim-fugitive', event = 'VeryLazy' },

	-- Flutter
	setup('dev.flutter-tools'),
	{ 'Nash0x7E2/awesome-flutter-snippets', ft = 'dart' }, -- snippets
	{ 'akinsho/pubspec-assist.nvim', ft = 'yaml', config = true }, -- add/update dart dependencies

	-- Javascript/Typescript
	setup('dev.package-info'), -- Mostra quais são as versões atuais dos packages
	{ -- Live server. Igual do vscode
		'barrett-ruth/live-server.nvim',
		cmd = { 'LiveServerStart', 'LiveServerStop' },
		opts = { args = { '--port=7000', '--browser=google-chrome-stable' } },
		build = 'sudo npm add -g live-server',
	},

	-- Java
	setup('dev.java'),

	-- Python
	setup('dev.venv-selector'),
	{ 'vimjas/vim-python-pep8-indent', ft = 'python' }, -- Conserta o indent

	-- Markdown
	{ 'bullets-vim/bullets.vim', ft = 'markdown' }, -- bullet list automático
	setup('dev.render-markdown'),
	{
		'iamcco/markdown-preview.nvim',
		cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
		init = function() vim.g.mkdp_filetypes = { 'markdown' } end,
		ft = { 'markdown' },
		build = function() vim.fn['mkdp#util#install']() end,
	},

	-- Rust
	setup('dev.rust'),

	--  ╭──────────────────────────────────────────────────────────╮
	--  │                          Debug                           │
	--  ╰──────────────────────────────────────────────────────────╯

	setup('debug'),
	setup('debug.dap-ui'),
	setup('debug.dap-python'),
	setup('debug.dap-virtual-text'),

	--  ╭──────────────────────────────────────────────────────────╮
	--  │                         Other                            │
	--  ╰──────────────────────────────────────────────────────────╯

	setup('other.snacks'), -- bundle de coisas uteis
	setup('other.image'), -- bundle de coisas uteis
})

if utils.is_wsl() then
	plugins:extend({
		{
			dir = '~/dev/cobol/cobol-bundle/',
			ft = { 'cobol', 'copybook' },
			lazy = false,
			config = true,
		},
	})
else
	plugins:extend({
		{ dir = '~/dev/cobol/cobol-bundle/', config = true, lazy = true },
		{ dir = '~/dev/foo/foo-nvim/', ft = { 'foo' }, lazy = true },
	})
end

require('lazy').setup(plugins)
