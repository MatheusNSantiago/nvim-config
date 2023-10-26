local M = {}

function M.setup()
  return {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    cmd = { 'TSUpdateSync' },
    event = { 'BufReadPost', 'BufNewFile' },
    config = M.config,
    keys = {
      { '<c-space>', desc = 'Increment selection' },
      { '<bs>', desc = 'Decrement selection', mode = 'x' },
      -- Text Objects
      { 'af', desc = 'Around Function', mode = 'x' },
      { 'if', desc = 'Inner Function', mode = 'x' },
      { 'ac', desc = 'Around Class', mode = 'x' },
      { 'ic', desc = 'Inner Class', mode = 'x' },
      { 'aB', desc = 'Around Block', mode = 'x' },
      { 'iB', desc = 'Inner Block', mode = 'x' },
      -- Moving between Text Objects
      { ']f', desc = 'Mover para o início da próxima função', mode = { 'n', 'x' } },
      { ']c', desc = 'Mover para o início da próxima classe', mode = { 'n', 'x' } },
      { '[f', desc = 'Mover para o início da função anterior', mode = { 'n', 'x' } },
      { '[c', desc = 'Mover para o início da classe anterior', mode = { 'n', 'x' } },
      { ']F', desc = 'Mover para o final da próxima função', mode = { 'n', 'x' } },
      { ']C', desc = 'Mover para o final da próxima classe', mode = { 'n', 'x' } },
      { '[F', desc = 'Mover para o final da função anterior', mode = { 'n', 'x' } },
      { '[C', desc = 'Mover para o final da classe anterior', mode = { 'n', 'x' } },
    },
  }
end

function M.config()
  local ts = require('nvim-treesitter.configs')

  local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
  parser_config.cobol = {
    install_info = {
      url = '~/Documents/Programming/cobol/tree-sitter-cobol/', -- local path or git repo
      files = {
        'src/parser.c',
        'src/scanner.c',
      }, -- note that some parsers also require src/scanner.c or src/scanner.cc
    },
    filetype = 'cobol',
  }

  ts.setup({
    ensure_installed = {
      'vim',
      'vimdoc',
      'markdown',
      'markdown_inline',
      'bash',
      'regex',
      'javascript',
      'typescript',
      'prisma',
      'ruby',
      'tsx',
      'python',
      'dart',
      'json',
      'html',
      'lua',
      'css',
      'scss',
      'toml',
      'fish',
      'jsdoc',
      'yaml',
    },
    auto_install = true,
    autotag = { enable = true },
    refactor = {
      highlight_definitions = { enable = true },
      highlight_current_scope = { enable = false },
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = '<C-space>',
        node_incremental = '<C-space>',
        scope_incremental = false,
        node_decremental = '<BS>',
      },
    },
    highlight = { enable = true, additional_vim_regex_highlighting = false },
    context_commentstring = {
      enable = true,
      enable_autocmd = false,
      config = {
        -- Languages that have a single comment style
        typescript = '// %s',
        css = '/* %s */',
        scss = '/* %s */',
        html = '<!-- %s -->',
        svelte = '<!-- %s -->',
        vue = '<!-- %s -->',
        json = '',
      },
    },
    textobjects = {
      select = {
        enable = true,
        -- Automatically jump forward to textobj, similar to targets.vim
        lookahead = true,
        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ['af'] = '@function.outer',
          ['if'] = '@function.inner',
          ['ac'] = '@class.outer',
          ['ic'] = '@class.inner',
          ['iB'] = '@block.inner',
          ['aB'] = '@block.outer',
        },
        include_surrounding_whitespace = false,
      },
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
          [']f'] = '@function.outer',
          [']c'] = '@class.outer',
        },
        goto_previous_start = {
          ['[f'] = '@function.outer',
          ['[c'] = '@class.outer',
        },
        goto_next_end = {
          [']F'] = '@function.outer',
          [']C'] = '@class.outer',
        },
        goto_previous_end = {
          ['[F'] = '@function.outer',
          ['[C'] = '@class.outer',
        },
      },
      swap = { enable = false, swap_next = {} },
    },
    matchup = { enable = true, disable_virtual_text = true, disable = { 'python' } },
    endwise = { enable = true }, -- Automatically add end to blocks
  })
end

return M
