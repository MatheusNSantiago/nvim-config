local M = {}

function M.setup()
  return {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-neotest/nvim-nio',
      'nvim-lua/plenary.nvim',
      'antoinemadec/FixCursorHold.nvim',
      'nvim-treesitter/nvim-treesitter',
      --  ─────────────────────────────
      'rcasia/neotest-java',
    },
    config = M.config,
  }
end

function M.config()
  require('neotest').setup({
    adapters = {
      require('neotest-java')({
        ignore_wrapper = true, -- whether to ignore maven/gradle wrapper
        -- junit_jar = 'path/to/junit-standalone.jar',
        -- default: .local/share/nvim/neotest-java/junit-platform-console-standalone-[version].jar
      }),
    },
    benchmark = {
      enabled = true,
    },
    consumers = {},
    default_strategy = 'integrated',
    diagnostic = {
      enabled = true,
      severity = 1,
    },
    discovery = {
      concurrent = 0,
      enabled = true,
    },
    floating = {
      border = 'rounded',
      max_height = 0.6,
      max_width = 0.6,
      options = {},
    },
    highlights = {
      adapter_name = 'NeotestAdapterName',
      border = 'NeotestBorder',
      dir = 'NeotestDir',
      expand_marker = 'NeotestExpandMarker',
      failed = 'NeotestFailed',
      file = 'NeotestFile',
      focused = 'NeotestFocused',
      indent = 'NeotestIndent',
      marked = 'NeotestMarked',
      namespace = 'NeotestNamespace',
      passed = 'NeotestPassed',
      running = 'NeotestRunning',
      select_win = 'NeotestWinSelect',
      skipped = 'NeotestSkipped',
      target = 'NeotestTarget',
      test = 'NeotestTest',
      unknown = 'NeotestUnknown',
      watching = 'NeotestWatching',
    },
    icons = {
      child_indent = '│',
      child_prefix = '├',
      collapsed = '─',
      expanded = '╮',
      failed = '',
      final_child_indent = ' ',
      final_child_prefix = '╰',
      non_collapsible = '─',
      notify = '',
      passed = '',
      running = '',
      running_animated = { '/', '|', '\\', '-', '/', '|', '\\', '-' },
      skipped = '',
      unknown = '',
      watching = '',
    },
    jump = {
      enabled = true,
    },
    log_level = 3,
    output = {
      enabled = true,
      open_on_run = 'short',
    },
    output_panel = {
      enabled = true,
      open = 'botright split | resize 15',
    },
    projects = {},
    quickfix = {
      enabled = true,
      open = false,
    },
    run = {
      enabled = true,
    },
    running = {
      concurrent = true,
    },
    state = {
      enabled = true,
    },
    status = {
      enabled = true,
      signs = true,
      virtual_text = false,
    },
    strategies = {
      integrated = {
        height = 40,
        width = 120,
      },
    },
    summary = {
      animated = true,
      enabled = true,
      expand_errors = true,
      follow = true,
      mappings = {
        attach = 'a',
        clear_marked = 'M',
        clear_target = 'T',
        debug = 'd',
        debug_marked = 'D',
        expand = { '<CR>', '<2-LeftMouse>' },
        expand_all = 'e',
        help = '?',
        jumpto = 'i',
        mark = 'm',
        next_failed = 'J',
        output = 'o',
        prev_failed = 'K',
        run = 'r',
        run_marked = 'R',
        short = 'O',
        stop = 'u',
        target = 't',
        watch = 'w',
      },
      open = 'botright vsplit | vertical resize 50',
    },
    watch = {
      enabled = true,
      symbol_queries = {
        -- elixir = <function 1>,
        go =
        '        ;query\n        ;Captures imported types\n        (qualified_type name: (type_identifier) @symbol)\n        ;Captures package-local and built-in types\n        (type_identifier)@symbol\n        ;Captures imported function calls and variables/constants\n        (selector_expression field: (field_identifier) @symbol)\n        ;Captures package-local functions calls\n        (call_expression function: (identifier) @symbol)\n      ',
        haskell =
        '        ;query\n        ;explicit import\n        ((import_item [(variable)]) @symbol)\n        ;symbols that may be imported implicitly\n        ((type) @symbol)\n        (qualified_variable (variable) @symbol)\n        (exp_apply (exp_name (variable) @symbol))\n        ((constructor) @symbol)\n        ((operator) @symbol)\n      ',
        javascript =
        '  ;query\n  ;Captures named imports\n  (import_specifier name: (identifier) @symbol)\n  ;Captures default import\n  (import_clause (identifier) @symbol)\n  ;Capture require statements\n  (variable_declarator \n  name: (identifier) @symbol\n  value: (call_expression (identifier) @function  (#eq? @function "require")))\n  ;Capture namespace imports\n  (namespace_import (identifier) @symbol)\n',
        lua =
        '        ;query\n        ;Captures module names in require calls\n        (function_call\n          name: ((identifier) @function (#eq? @function "require"))\n          arguments: (arguments (string) @symbol))\n      ',
        python =
        "        ;query\n        ;Captures imports and modules they're imported from\n        (import_from_statement (_ (identifier) @symbol))\n        (import_statement (_ (identifier) @symbol))\n      ",
        ruby =
        '        ;query\n        ;rspec - class name\n        (call\n          method: (identifier) @_ (#match? @_ "^(describe|context)")\n          arguments: (argument_list (constant) @symbol )\n        )\n\n        ;rspec - namespaced class name\n        (call\n          method: (identifier)\n          arguments: (argument_list\n            (scope_resolution\n              name: (constant) @symbol))\n        )\n      ',
        rust =
        '        ;query\n        ;submodule import\n        (mod_item\n          name: (identifier) @symbol)\n        ;single import\n        (use_declaration\n          argument: (scoped_identifier\n            name: (identifier) @symbol))\n        ;import list\n        (use_declaration\n          argument: (scoped_use_list\n            list: (use_list\n                [(scoped_identifier\n                   path: (identifier)\n                   name: (identifier) @symbol)\n                 ((identifier) @symbol)])))\n        ;wildcard import\n        (use_declaration\n          argument: (scoped_use_list\n            path: (identifier)\n            [(use_list\n              [(scoped_identifier\n                path: (identifier)\n                name: (identifier) @symbol)\n                ((identifier) @symbol)\n              ])]))\n      ',
        tsx =
        '  ;query\n  ;Captures named imports\n  (import_specifier name: (identifier) @symbol)\n  ;Captures default import\n  (import_clause (identifier) @symbol)\n  ;Capture require statements\n  (variable_declarator \n  name: (identifier) @symbol\n  value: (call_expression (identifier) @function  (#eq? @function "require")))\n  ;Capture namespace imports\n  (namespace_import (identifier) @symbol)\n',
        typescript =
        '  ;query\n  ;Captures named imports\n  (import_specifier name: (identifier) @symbol)\n  ;Captures default import\n  (import_clause (identifier) @symbol)\n  ;Capture require statements\n  (variable_declarator \n  name: (identifier) @symbol\n  value: (call_expression (identifier) @function  (#eq? @function "require")))\n  ;Capture namespace imports\n  (namespace_import (identifier) @symbol)\n',
      },
    },
  })
end

return M
