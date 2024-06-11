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
      { '<bs>',      desc = 'Decrement selection',                    mode = 'x' },
      -- Text Objects
      { 'af',        desc = 'Around Function',                        mode = 'x' },
      { 'if',        desc = 'Inner Function',                         mode = 'x' },
      { 'ac',        desc = 'Around Class',                           mode = 'x' },
      { 'ic',        desc = 'Inner Class',                            mode = 'x' },
      { 'aB',        desc = 'Around Block',                           mode = 'x' },
      { 'iB',        desc = 'Inner Block',                            mode = 'x' },
      -- Moving between Text Objects
      { ']f',        desc = 'Mover para o início da próxima função',  mode = { 'n', 'x' } },
      { ']c',        desc = 'Mover para o início da próxima classe',  mode = { 'n', 'x' } },
      { '[f',        desc = 'Mover para o início da função anterior', mode = { 'n', 'x' } },
      { '[c',        desc = 'Mover para o início da classe anterior', mode = { 'n', 'x' } },
      { ']F',        desc = 'Mover para o final da próxima função',   mode = { 'n', 'x' } },
      { ']C',        desc = 'Mover para o final da próxima classe',   mode = { 'n', 'x' } },
      { '[F',        desc = 'Mover para o final da função anterior',  mode = { 'n', 'x' } },
      { '[C',        desc = 'Mover para o final da classe anterior',  mode = { 'n', 'x' } },
    },
  }
end

function M.config()
  local ts = require('nvim-treesitter.configs')

  local disable = { 'cobol', 'foo' }

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
      highlight_definitions = { enable = true, disable = disable },
      highlight_current_scope = { enable = true, disable = disable },
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
    highlight = {
      enable = true,
      -- these are the names of the parsers and not the filetype. (for example if you want to
      -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
      -- the name of the parser)
      -- list of language that will be disabled
      -- disable = { 'c', 'rust' },
      -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
      disable = function(lang, buf)
        local max_filesize = (1 * 1024) * 1024 -- 1 MB

        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then return true end
      end,
      -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
      -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
      -- Using this option may slow down your editor, and you may see some duplicate highlights.
      -- Instead of true it can also be a list of languages
      additional_vim_regex_highlighting = disable,
    },
    textobjects = {
      select = {
        enable = true,
        disable = { 'cobol', 'javascript' },
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
        disable = disable,
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
    matchup = { enable = true, disable_virtual_text = true, disable = { 'python', 'cobol', 'foo' } },
    endwise = { enable = true, disable = disable }, -- Automatically add end to blocks
  })

  require('ts_context_commentstring').setup({
    enable_autocmd = false,
    languages = { -- Languages that have a single comment style
      typescript = '// %s',
      css = '/* %s */',
      scss = '/* %s */',
      html = '<!-- %s -->',
      svelte = '<!-- %s -->',
      vue = '<!-- %s -->',
      json = '',
    },
  })

  require('nvim-ts-autotag').setup({
    opts = {
      -- Defaults
      enable_close = true,        -- Auto close tags
      enable_rename = true,       -- Auto rename pairs of tags
      enable_close_on_slash = false, -- Auto close on trailing </
    },
    -- Also override individual filetype configs, these take priority.
    -- Empty by default, useful if one of the "opts" global settings
    -- doesn't work well in a specific filetype
    per_filetype = {
      ['html'] = {
        enable_close = false,
      },
    },
  })
end

return M
