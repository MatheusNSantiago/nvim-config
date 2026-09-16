local M = {}

function M.setup()
  return { ---@type LazyPluginSpec
    "obsidian-nvim/obsidian.nvim",
    version = "*", -- use latest release, remove to use latest commit
    config = M.config,
  }
end

function M.config()
  vim.opt.conceallevel = 1

  require("obsidian").setup({
    legacy_commands = false,
    notes_subdir = nil,
    new_notes_location = "current_dir",
    link = { style = "wiki", format = "shortest", auto_update = false },
    workspaces = {
      { name = "personal", path = "~/Documents/obsidian" },

    },
    log_level = vim.log.levels.INFO,
    -- Default random zettel IDs. To use readable UTF-8 slug IDs, set:
    -- note_id_func = require("obsidian.builtin").title_id
    note_id_func = require("obsidian.builtin").title_id,
    note_path_func = function(spec)
      -- This is equivalent to the default behavior.
      local path = spec.dir / tostring(spec.id)
      return path:with_suffix(".md", true)
    end,
    open_notes_in = "current",
    note = {
      ---Default template to use, relative to template.folder or an absolute path.
      template = (function()
        local root
        for _, path in ipairs(vim.api.nvim_list_runtime_paths()) do
          if vim.endswith(path, "obsidian.nvim") then
            root = path
            break
          end
        end
        if not root then
          return nil
        end
        return vim.fs.joinpath(root, "data/default_template.md")
      end)(),
    },
    file = {
      --- A list of gitignore-style glob patterns to ignore files and directories.
      --- Users should use simple gitignore style globs without modifiers,
      --- and ripgrep compatibility is not guaranteed.
      ignore_filters = {},
    },
    frontmatter = {
      --- Whether to enable frontmatter, boolean for global on/off, or a function that takes filename and returns boolean.
      enabled = true,
      --- Function to turn Note attributes into frontmatter.
      func = require("obsidian.builtin").frontmatter,
      --- List of string that sorts frontmatter properties, or a function that compares two values, set to vim.NIL/false to do no sorting
      sort = { "id", "aliases", "tags" },
    },
    templates = {
      enabled = true,
      folder = nil,
      date_format = "YYYY-MM-DD",
      time_format = "HH:mm",
      --- A map for custom variables, the key should be the variable and the value a function.
      --- Functions are called with obsidian.TemplateContext objects and optional suffix strings.
      --- See: https://github.com/obsidian-nvim/obsidian.nvim/wiki/Template#substitutions
      substitutions = {
        date = function(_, suffix)
          local format = suffix or Obsidian.opts.templates.date_format
          return require("obsidian.util").format_date(os.time(), format)
        end,
        time = function(_, suffix)
          local format = suffix or Obsidian.opts.templates.time_format
          return require("obsidian.util").format_date(os.time(), format)
        end,
        title = function(ctx)
          return ctx.partial_note and ctx.partial_note:display_name()
        end,
        id = function(ctx)
          return ctx.partial_note and ctx.partial_note.id
        end,
        path = function(ctx)
          return ctx.partial_note and tostring(ctx.partial_note.path)
        end,
      },
      customizations = {},
    },
    backlinks = { parse_headers = true },
    completion = { min_chars = 2, match_case = true, create_new = true },
    picker = {
      name = "snacks.picker",
      note_mappings = { new = "<C-x>", insert_link = "<C-l>" },
      tag_mappings = { tag_note = "<C-x>", insert_tag = "<C-l>" },
    },
    search = { sort_by = "modified", sort_reversed = true, max_lines = 1000 },
    daily_notes = {
      enabled = true,
      folder = nil,
      date_format = "YYYY-MM-DD",
      alias_format = nil,
      default_tags = { "daily-notes" },
      workdays_only = true,
    },
    ui = {
      enable = true,
      ignore_conceal_warn = false,
      update_debounce = 200,
      max_file_length = 5000,
      -- checkboxes = {
      --   [" "] = { char = "󰄱", hl_group = "obsidiantodo" },
      --   ["~"] = { char = "󰰱", hl_group = "obsidiantilde" },
      --   ["!"] = { char = "", hl_group = "obsidianimportant" },
      --   [">"] = { char = "", hl_group = "obsidianrightarrow" },
      --   ["x"] = { char = "", hl_group = "obsidiandone" },
      -- },
      bullets = { char = "•", hl_group = "ObsidianBullet" },
      external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
      reference_text = { hl_group = "ObsidianRefText" },
      highlight_text = { hl_group = "ObsidianHighlightText" },
      tags = { hl_group = "ObsidianTag" },
      block_ids = { hl_group = "ObsidianBlockID" },
      hl_groups = {
        ObsidianTodo = { bold = true, fg = "#f78c6c" },
        ObsidianDone = { bold = true, fg = "#89ddff" },
        ObsidianRightArrow = { bold = true, fg = "#f78c6c" },
        ObsidianTilde = { bold = true, fg = "#ff5370" },
        ObsidianImportant = { bold = true, fg = "#d73128" },
        ObsidianBullet = { bold = true, fg = "#89ddff" },
        ObsidianRefText = { underline = true, fg = "#c792ea" },
        ObsidianExtLinkIcon = { fg = "#c792ea" },
        ObsidianTag = { italic = true, fg = "#89ddff" },
        ObsidianBlockID = { italic = true, fg = "#89ddff" },
        ObsidianHighlightText = { bg = "#75662e" },
      },
    },
    unique_note = { enabled = true, format = "YYYYMMDDHHmm", folder = nil, template = nil },
    attachments = {
      ---Default folder to save images to, relative to the vault root (/) or current dir (.), see https://github.com/obsidian-nvim/obsidian.nvim/wiki/Images#change-image-save-location
      folder = "zz",
      ---Default text to insert for pasted images
      img_text_func = require("obsidian.builtin").img_text_func,
      ---Default name for pasted images
      img_name_func = function()
        return string.format("Pasted image %s", os.date "%Y%m%d%H%M%S")
      end,
      ---Whether to confirm the paste or not. Defaults to true.
      confirm_img_paste = true, -- TODO: move to paste module, paste.confirm
    },
    sync = {
      enabled = false,
      ---Which backend to use. Built-in: "obsidian" (obsidian-headless CLI).
      ---Custom backends can be added with `require("obsidian.sync").register(name, backend)`.
      backend = "obsidian",
      ---When to run a sync.
      --- - "continuous": keep a long-running sync process (default for obsidian backend).
      --- - "on_write": run a one-shot sync (debounced) after each note save.
      --- - "manual": only sync via :Obsidian sync start or explicit calls.
      trigger = "continuous",
      ---Sync mode: bidirectional (default), pull-only (only download, ignore local changes), or mirror-remote (only download, revert local changes)
      mode = nil,
      ---Conflict strategy when a conflict is detected, NOTE: conflict is not currently supported in this client
      conflict_strategy = "merge",
      ---Attachment types to sync: image, audio, video, pdf, unsupported, empty table to disable attachment syncing
      -- file_types = { "image", "audio", "video", "pdf", "unsupported" },
      ---Config categories to sync. nil = leave server config unchanged. {} = explicitly disable config syncing (pass --configs ""). Non-empty list = sync only those categories.
      -- configs = { "core-plugin", "core-plugin-data" },
      excluded_folders = {},
      ---Device name to identify this client in the sync version history
      device_name = nil,
      ---Config directory name, this is for obsidian app
      config_dir = ".obsidian",
    },
    callbacks = {
      -- Runs right after setup
      post_setup = nil,
      --- Runs when `Note.create` builds a note object. `opts.scope` is inherited from the `Note.create` opts, defaulting to `"plain"`.
      create_note = nil,
      enter_note = function(note)
        local actions = require("obsidian.actions")
        U.api.keymap("n", "<leader>sf", function()
          require('fff').find_files({
            query = "./**/*.md "
          })
        end, { desc = "'FFFind markdown files'" })
        U.api.keymap("n", "<leader>sg", ":Obsidian search<CR>", { desc = "Search in Obsidian" })
        -- vim.keymap.set("n", "<leader>;", actions.add_property, { buffer = true, desc = "Add frontmatter property" })
        -- vim.keymap.set("n", "<Tab>", function()
        --   actions.nav_link "next"
        -- end, { buffer = true, desc = "Go to next link" })
        -- vim.keymap.set("n", "<S-Tab>", function()
        --   actions.nav_link "prev"
        -- end, { buffer = true, desc = "Go to previous link" })
      end,
      -- Runs when leaving a note buffer.
      leave_note = nil,
      -- Runs right before writing a note buffer.
      pre_write_note = nil,
      -- Runs after adding an attachment.
      add_attachment = nil,
      -- Runs anytime the workspace is set/changed.
      post_set_workspace = nil,

    },
    resolvers = {
      ---Resolve an attachment source before `actions.add_attachment` copies/downloads it.
      attachment = nil,
      ---Resolve a date before date-based actions, such as `daily.pick`, continue.
      date = nil,
      ---Build serializable LSP inlay hints for a note.
      hints = nil,
    },
    footer = {
      enabled = true,
      format = "{{backlinks}} backlinks  {{properties}} properties  {{words}} words  {{chars}} chars",
      hl_group = "Comment",
      separator = string.rep("-", 80), -- Set false to disable separator; set an empty string to insert a blank line separator.
    },
    open = {
      -- Opens the file with current line number
      use_advanced_uri = false,
      ---Function to do the opening, default to vim.ui.open
      func = vim.ui.open,
      ---URI scheme whitelist, new values are appended to this list, and URIs with schemes in this list, will not be prompted to confirm opening
      schemes = { "https", "http", "file", "mailto" },
    },
    checkbox = {
      enabled = true,
      ---Whether to create new checkbox on paragraphs
      create_new = true,
      ---Order of checkbox state chars, e.g. { " ", "x" }
      order = { " ", "~", "!", ">", "x" },
    },
    comment = { enabled = false },
    slides = { enabled = true },
    cache = {
      enabled = false,
      -- Built-in: "json", "memory". Custom backends can be added with `require("obsidian.cache").register(name, backend)`.
      backend = "json",
    },
  })
end

return M
