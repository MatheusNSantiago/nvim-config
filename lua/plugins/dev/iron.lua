local M = {}

function M.setup()
  return { ---@type LazyPluginSpec
    "Vigemus/iron.nvim",
    config = M.config,
    keys = {
      { "<leader>rR", desc = 'Restart REPL' },
      { "<leader>rf", desc = 'Send file to REPL' },
      { "<leader>rb", desc = 'Send code block to REPL' },
      { "<leader>cl", desc = 'Clear REPL' },
    }

  }
end

function M.config()
  local iron = require("iron.core")
  local view = require("iron.view")
  local common = require("iron.fts.common")

  iron.setup {
    config = {
      scratch_repl = true,
      repl_definition = {
        sh = { command = { "zsh" } },
        python = {
          command = { "ipython", "--no-autoindent", "--no-banner", "--no-tip" },
          format = common.bracketed_paste_python,
          block_dividers = { "# %%", "#%%" },
        }
      },
      repl_filetype = function(_, ft) return ft end,
      repl_open_cmd = {
        view.split.vertical.rightbelow("%40"),
      }

    },
    keymaps = {
      restart_repl = "<leader>rR", -- calls `IronRestart` to restart the repl
      send_file = "<leader>rf",
      send_code_block = "<leader>rb",
      clear = "<leader>cl",
      -- toggle_repl = "<leader>rr",
      -- If repl_open_command is a table as above, then the following keymaps are
      -- available
      -- toggle_repl_with_cmd_1 = "<leader>rv",
      -- toggle_repl_with_cmd_2 = "<leader>rh",
      --   send_motion = "<leader>sc",
      --   visual_send = "<leader>sc",
      --   send_line = "<leader>sl",
      --   send_paragraph = "<leader>sp",
      --   send_until_cursor = "<leader>su",
      --   send_mark = "<leader>sm",
      --   send_code_block_and_move = "<leader>sn",
      --   mark_motion = "<leader>mc",
      --   mark_visual = "<leader>mc",
      --   remove_mark = "<leader>md",
      -- cr = "<leader>s<cr>",
      -- interrupt = "<leader>s<leader>",
      -- exit = "<leader>sq",
    },
    highlight = { italic = false },
    ignore_blank_lines = true, -- ignore blank lines when sending visual select lines
  }
end

return M
