---@diagnostic disable: undefined-doc-name
local M = {}

function M.setup()
  return {
    'folke/noice.nvim', -- messages, cmdline and popupmenu
    event = 'VeryLazy',
    dependencies = { 'MunifTanjim/nui.nvim', 'rcarriga/nvim-notify' },
    config = M.config,
  }
end
function M.config()
  require('noice').setup({
    cmdline = {
      enabled = true, -- enables the Noice cmdline UI
      view = 'cmdline', -- view for rendering the cmdline. Change to `cmdline` to get a classic cmdline at the bottom
      opts = {},     -- global options for the cmdline. See section on views
      ---@type table<string, CmdlineFormat>
      format = {
        -- conceal: (default=true) This will hide the text in the cmdline that matches the pattern.
        -- view: (default is cmdline view)
        -- opts: any options passed to the view
        -- icon_hl_group: optional hl_group for the icon
        -- title: set to anything or empty string to hide
        cmdline = { pattern = '^:', icon = '', lang = 'vim' },
        search_down = { kind = 'search', pattern = '^/', icon = '  ', lang = 'regex' },
        search_up = { kind = 'search', pattern = '^%?', icon = '  ', lang = 'regex' },
        filter = { pattern = '^:%s*!', icon = '', lang = 'bash' },
        lua = { pattern = { '^:%s*lua%s+', '^:%s*lua%s*=%s*', '^:%s*=%s*' }, icon = '', lang = 'lua' },
        help = { pattern = '^:%s*he?l?p?%s+', icon = '' },
        input = { view = 'cmdline_input', icon = '󰥻 ' }, -- Used by input()
        -- lua = false, -- to disable a format, set to `false`
      },
    },
    messages = {
      -- NOTE- If you enable messages, then the cmdline is enabled automatically.
      -- This is a current Neovim limitation.
      enabled = true,         -- enables the Noice messages UI
      view = 'notify',        -- default view for messages
      view_error = 'notify',  -- view for errors
      view_warn = 'notify',   -- view for warnings
      view_history = 'messages', -- view for :messages
      view_search = false,    -- 'virtualtext' -- view for search count messages. Set to `false` to disable
    },
    popupmenu = {
      enabled = true, -- enables the Noice popupmenu UI
      ---@type 'nui'|'cmp'
      backend = 'nui', -- backend to use to show regular cmdline completions
      ---@type NoicePopupmenuItemKind|false
      -- Icons for completion item kinds (see defaults at noice.config.icons.kinds)
      kind_icons = {}, -- set to `false` to disable icons
    },
    -- default options for require('noice').redirect
    -- see the section on Command Redirection
    ---@type NoiceRouteConfig
    redirect = {
      view = 'popup',
      filter = { event = 'msg_show' },
    },
    -- You can add any custom commands below that will be available with `:Noice command`
    ---@type table<string, NoiceCommand>
    commands = {
      history = {
        -- options for the message history that you get with `:Noice`
        view = 'split',
        opts = { enter = true, format = 'details' },
        filter = {
          any = {
            { event = 'notify' },
            { error = true },
            { warning = true },
            { event = 'msg_show', kind = { '' } },
            { event = 'lsp',      kind = 'message' },
          },
        },
      },
      -- :Noice last
      last = {
        view = 'popup',
        opts = { enter = true, format = 'details' },
        filter = {
          any = {
            { event = 'notify' },
            { error = true },
            { warning = true },
            { event = 'msg_show', kind = { '' } },
            { event = 'lsp',      kind = 'message' },
          },
        },
        filter_opts = { count = 1 },
      },
      -- :Noice errors
      errors = {
        -- options for the message history that you get with `:Noice`
        view = 'popup',
        opts = { enter = true, format = 'details' },
        filter = { error = true },
        filter_opts = { reverse = true },
      },
      all = {
        -- options for the message history that you get with `:Noice`
        view = 'split',
        opts = { enter = true, format = 'details' },
        filter = {},
      },
    },
    notify = {
      -- Noice can be used as `vim.notify` so you can route any notification like other messages
      -- Notification messages have their level and other properties set.
      -- event is always "notify" and kind can be any log level as a string
      -- The default routes will forward notifications to nvim-notify
      -- Benefit of using Noice for this is the routing and consistent history view
      enabled = true,
      view = 'notify',
    },
    lsp = {
      progress = {
        enabled = false,
        -- Lsp Progress is formatted using the builtins for lsp_progress. See config.format.builtin
        -- See the section on formatting for more details on how to customize.
        --- @type NoiceFormat|string
        format = 'lsp_progress',
        --- @type NoiceFormat|string
        format_done = 'lsp_progress_done',
        throttle = 1000 / 30, -- frequency to update lsp progress message
        view = 'mini',
      },

      -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
      override = {
        -- override the default lsp markdown formatter with Noice
        ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
        -- override the lsp markdown formatter with Noice
        ['vim.lsp.util.stylize_markdown'] = true,
        -- override cmp documentation with Noice (needs the other options to work)
        ['cmp.entry.get_documentation'] = true,
      },
      hover = {
        enabled = false,
        silent = false, -- set to true to not show a message if hover is not available
        view = nil, -- when nil, use defaults from documentation
        ---@type NoiceViewOptions
        opts = {},  -- merged with defaults from documentation
      },
      signature = {
        enabled = false,
        auto_open = {
          enabled = true,
          trigger = true, -- Automatically show signature help when typing a trigger character from the LSP
          luasnip = true, -- Will open signature help when jumping to Luasnip insert nodes
          throttle = 50, -- Debounce lsp signature help request by 50ms
        },
        view = nil,  -- when nil, use defaults from documentation
        ---@type NoiceViewOptions
        opts = {},   -- merged with defaults from documentation
      },
      message = {
        -- Messages shown by lsp servers
        enabled = true,
        view = 'notify',
        opts = {},
      },
      -- defaults for hover and signature help
      documentation = {
        view = 'hover',
        ---@type NoiceViewOptions
        opts = {
          lang = 'markdown',
          replace = true,
          render = 'plain',
          format = { '{message}' },
          win_options = { concealcursor = 'n', conceallevel = 3 },
        },
      },
    },
    markdown = {
      hover = {
        ['|(%S-)|'] = vim.cmd.help,                   -- vim help links
        ['%[.-%]%((%S-)%)'] = require('noice.util').open, -- markdown links
      },
      highlights = {
        ['|%S-|'] = '@text.reference',
        ['@%S+'] = '@parameter',
        ['^%s*(Parameters:)'] = '@text.title',
        ['^%s*(Return:)'] = '@text.title',
        ['^%s*(See also:)'] = '@text.title',
        ['{%S-}'] = '@parameter',
      },
    },
    health = { checker = true }, -- Disable if you don't want health checks to run
    ---@type NoicePresets
    presets = {
      -- you can enable a preset by setting it to true, or a table that will override the preset config
      -- you can also add custom presets that you can enable/disable with enabled=true
      bottom_search = true,       -- use a classic bottom cmdline for search
      command_palette = false,    -- position the cmdline and popupmenu together
      long_message_to_split = false, -- long messages will be sent to a split
      inc_rename = false,         -- enables an input dialog for inc-rename.nvim
      lsp_doc_border = true,      -- add a border to hover docs and signature help
    },
    throttle = 1000 / 30,         -- how frequently does Noice need to check for ui updates? This has no effect when in blocking mode.
    ---@type NoiceConfigViews
    views = {}, ---@see section on views
    ---@type NoiceRouteConfig[]
    routes = {
      -- Skip Messages
      {
        opts = { skip = true },
        filter = {
          any = {
            -- ao salvar mudança
            { event = 'msg_show', find = '%d+L, %d+B written' },
            -- { event = 'msg_show',               find = '%d+ lines, %d+ bytes' },
            -- { event = 'msg_show',               kind = 'search_count' },
            -- { event = 'msg_show',               find = '^Hunk %d+ of %d' },
            -- { event = 'msg_show',               find = '%d+ change' },
            -- { event = 'msg_show',               find = '%d+ line' },
            -- { event = 'msg_show',               find = '%d+ more line' },
            -- Ao dar hover em algo que não tem informação suficiente
            { event = 'notify',   find = 'No information available' },
            { event = 'msg_show',   find = 'press letter mark to preview, or press <esc> to quit' }, -- mensagem do marks.nvim para preview
            -- { event = 'msg_show',               find = 'textDocument/foldingRange' },                            -- erro no yaml
            -- { event = { 'msg_show', 'notify' }, find = 'No delegateCommandHandler for vscode.java.resolveMainClass' }, -- erro no yaml
          },
        },
      },
      -- Warnings
      -- {
      --   view = 'notify',
      --   filter = {
      --     any = {
      --       { warning = true },
      --       { event = 'msg_show', find = '^Warn' },
      --       { event = 'msg_show', find = '^W%d+:' },
      --       { event = 'msg_show', find = '^No hunks$' },
      --     },
      --   },
      --   opts = { title = 'Warning', level = vim.log.levels.WARN, merge = false, replace = false },
      -- },
      -- Erros
      -- {
      --   view = 'notify',
      --   opts = { title = 'Error', level = vim.log.levels.ERROR, merge = true, replace = false },
      --   filter = {
      --     any = {
      --       { error = true },
      --       { event = 'msg_show', find = '^Error' },
      --       { event = 'msg_show', find = '^E%d+:' },
      --     },
      --   },
      -- },
      -- minimise pattern not found messages
      -- {
      --   view = 'mini',
      --   filter = {
      --     any = {
      --       { event = 'msg_show', find = '^E486:' },
      --       { event = 'notify',   max_height = 1 },
      --     },
      --   },
      -- },
    },         --- @see section on routes
    ---@type table<string, NoiceFilter>
    status = {}, --- @see section on statusline components
    ---@type NoiceFormatOptions
    format = {}, --- @see section on formatting
  })
end

M.highlights = {
  -- NoiceMini = { inherit = 'MsgArea', bg = { from = 'Normal' } },
  -- NoicePopupBaseGroup = { inherit = 'NormalFloat', fg = { from = 'DiagnosticSignInfo' } },
  -- NoicePopupWarnBaseGroup = { inherit = 'NormalFloat', fg = { from = 'Float' } },
  -- NoicePopupInfoBaseGroup = { inherit = 'NormalFloat', fg = { from = 'Conditional' } },
  -- NoiceCmdlinePopup = { bg = { from = 'NormalFloat' } },
  -- NoiceCmdlinePopupBorder = { link = 'FloatBorder' },
  -- NoiceCmdlinePopupBorderCmdline = { link = 'NoicePopupBaseGroup' },
  -- NoiceCmdlinePopupBorderSearch = { link = 'NoicePopupWarnBaseGroup' },
  -- NoiceCmdlinePopupBorderFilter = { link = 'NoicePopupWarnBaseGroup' },
  -- NoiceCmdlinePopupBorderHelp = { link = 'NoicePopupInfoBaseGroup' },
  -- NoiceCmdlinePopupBorderSubstitute = { link = 'NoicePopupWarnBaseGroup' },
  -- NoiceCmdlinePopupBorderIncRename = { link = 'NoicePopupWarnBaseGroup' },
  -- NoiceCmdlinePopupBorderInput = { link = 'NoicePopupBaseGroup' },
  -- NoiceCmdlinePopupBorderLua = { link = 'NoicePopupBaseGroup' },
  -- NoiceCmdlineIconCmdline = { link = 'NoicePopupBaseGroup' },
  -- NoiceCmdlineIconSearch = { link = 'NoicePopupWarnBaseGroup' },
  -- NoiceCmdlineIconFilter = { link = 'NoicePopupWarnBaseGroup' },
  -- NoiceCmdlineIconHelp = { link = 'NoicePopupInfoBaseGroup' },
  -- NoiceCmdlineIconIncRename = { link = 'NoicePopupWarnBaseGroup' },
  -- NoiceCmdlineIconSubstitute = { link = 'NoicePopupWarnBaseGroup' },
  -- NoiceCmdlineIconInput = { link = 'NoicePopupBaseGroup' },
  -- NoiceCmdlineIconLua = { link = 'NoicePopupBaseGroup' },
  -- NoiceConfirm = { bg = { from = 'NormalFloat' } },
  -- NoiceConfirmBorder = { link = 'NoicePopupBaseGroup' },
}

return M
