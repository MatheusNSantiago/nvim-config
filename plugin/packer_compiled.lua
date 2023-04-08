-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

_G._packer = _G._packer or {}
_G._packer.inside_compile = true

local time
local profile_info
local should_profile = false
if should_profile then
  local hrtime = vim.loop.hrtime
  profile_info = {}
  time = function(chunk, start)
    if start then
      profile_info[chunk] = hrtime()
    else
      profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
    end
  end
else
  time = function(chunk, start) end
end

local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end
  if threshold then
    table.insert(results, '(Only showing plugins that took longer than ' .. threshold .. ' ms ' .. 'to load)')
  end

  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/matheus/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/home/matheus/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/home/matheus/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/home/matheus/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/matheus/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["Comment.nvim"] = {
    config = { "\27LJ\2\n�\2\0\0\6\0\f\0\0216\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0004\3\0\0=\3\4\0024\3\0\0=\3\5\0024\3\0\0=\3\6\0025\3\a\0=\3\b\0026\3\0\0'\5\t\0B\3\2\0029\3\n\3B\3\1\2=\3\v\2B\0\2\1K\0\1\0\rpre_hook\20create_pre_hook7ts_context_commentstring.integrations.comment_nvim\rmappings\1\0\2\nbasic\2\nextra\2\nextra\ropleader\ftoggler\1\0\2\vsticky\2\fpadding\2\nsetup\fComment\frequire\0" },
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/Comment.nvim",
    url = "https://github.com/numToStr/Comment.nvim"
  },
  LuaSnip = {
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/LuaSnip",
    url = "https://github.com/L3MON4D3/LuaSnip"
  },
  ["bufferline.nvim"] = {
    config = { "\27LJ\2\n\v\0\1\1\0\0\0\1K\0\1\0W\0\4\b\0\5\0\14\18\6\1\0009\4\0\1'\a\1\0B\4\3\2\15\0\4\0X\5\2�'\4\2\0X\5\1�'\4\3\0'\5\4\0\18\6\4\0\18\a\0\0&\5\a\5L\5\2\0\6 \t \t \nerror\nmatch�\a\1\0\a\0\21\0\0276\0\0\0'\2\1\0B\0\2\0029\1\2\0005\3\18\0005\4\3\0005\5\4\0=\5\5\0043\5\6\0=\5\a\0043\5\b\0=\5\t\0044\5\3\0005\6\n\0>\6\1\5=\5\v\0045\5\f\0=\5\r\0045\5\14\0005\6\15\0=\6\16\5=\5\17\4=\4\19\0034\4\0\0=\4\20\3B\1\2\1K\0\1\0\15highlights\foptions\1\0\0\nhover\vreveal\1\2\0\0\nclose\1\0\2\ndelay\3�\1\fenabled\1\20separator_style\1\3\0\0\6|\6|\foffsets\1\0\4\15text_align\vcenter\ttext\18File Explorer\rfiletype\rNvimTree\14separator\1\26diagnostics_indicator\0\19name_formatter\0\14indicator\1\0\1\nstyle\14underline\1\0\26\19truncate_names\1\rtab_size\3\18\24right_mouse_command\16bdelete! %d!diagnostics_update_in_insert\1\26show_duplicate_prefix\1\16diagnostics\rnvim_lsp\29show_buffer_default_icon\2\28show_buffer_close_icons\1\fnumbers\tnone\fsort_by\ttabs\18close_command\16bdelete! %d\tmode\ttabs\22show_buffer_icons\2\23left_mouse_command\14buffer %d\20show_close_icon\1\24show_tab_indicators\1\22buffer_close_icon\b\25enforce_regular_tabs\1\18modified_icon\b●\15close_icon\b\16color_icons\2\22left_trunc_marker\b\23right_trunc_marker\b\27always_show_bufferline\2\20max_name_length\3\18\22max_prefix_length\3\15\nsetup\15bufferline\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/opt/bufferline.nvim",
    url = "https://github.com/akinsho/bufferline.nvim"
  },
  ["cmp-buffer"] = {
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/cmp-buffer",
    url = "https://github.com/hrsh7th/cmp-buffer"
  },
  ["cmp-cmdline"] = {
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/cmp-cmdline",
    url = "https://github.com/hrsh7th/cmp-cmdline"
  },
  ["cmp-npm"] = {
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/cmp-npm",
    url = "https://github.com/David-Kunz/cmp-npm"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-nvim-lua"] = {
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/cmp-nvim-lua",
    url = "https://github.com/hrsh7th/cmp-nvim-lua"
  },
  ["cmp-path"] = {
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/cmp-path",
    url = "https://github.com/hrsh7th/cmp-path"
  },
  cmp_luasnip = {
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/cmp_luasnip",
    url = "https://github.com/saadparwaiz1/cmp_luasnip"
  },
  ["comment-box.nvim"] = {
    config = { "\27LJ\2\n�\2\0\0\4\0\b\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\0025\3\6\0=\3\a\2B\0\2\1K\0\1\0\tline\1\0\3\rline_end\b─\15line_start\b─\tline\b─\fborders\1\0\b\nright\b│\17bottom_right\b╯\16bottom_left\b╰\rtop_left\b╭\vbottom\b─\14top_right\b╮\tleft\b│\btop\b─\1\0\a\15line_width\3F\22outer_blank_lines\1\22inner_blank_lines\1\26line_blank_line_above\1\26line_blank_line_below\1\14doc_width\3P\14box_width\3<\nsetup\16comment-box\frequire\0" },
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/comment-box.nvim",
    url = "https://github.com/LudoPinelli/comment-box.nvim"
  },
  ["copilot-cmp"] = {
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/copilot-cmp",
    url = "https://github.com/zbirenbaum/copilot-cmp"
  },
  ["copilot.lua"] = {
    commands = { "Copilot" },
    config = { "\27LJ\2\n�\3\0\0\5\0\15\0\0196\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\b\0005\3\3\0005\4\4\0=\4\5\0035\4\6\0=\4\a\3=\3\t\0025\3\n\0005\4\v\0=\4\5\3=\3\f\0025\3\r\0=\3\14\2B\0\2\1K\0\1\0\14filetypes\1\0\a\bsvn\1\6.\1\thelp\1\bcvs\1\14gitcommit\1\14gitrebase\1\rhgcommit\1\15suggestion\1\0\5\16accept_line\1\14jump_next\n<M-]>\tnext\n<M-]>\16accept_word\1\tprev\n<M-[>\1\0\3\17auto_trigger\1\fenabled\1\rdebounce\3K\npanel\1\0\1\25copilot_node_command\tnode\vlayout\1\0\2\rposition\vbottom\nratio\4����\t����\3\vkeymap\1\0\5\14jump_prev\n<M-[>\14jump_next\n<M-]>\vaccept\t<CR>\topen\v<M-CR>\frefresh\agr\1\0\2\fenabled\1\17auto_refresh\1\nsetup\fcopilot\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/opt/copilot.lua",
    url = "https://github.com/zbirenbaum/copilot.lua"
  },
  ["dressing.nvim"] = {
    config = { "\27LJ\2\n\v\0\1\1\0\0\0\1L\0\2\0\v\0\1\1\0\0\0\1L\0\2\0�\n\1\0\6\0001\0?6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\19\0005\3\3\0005\4\4\0=\4\5\0035\4\6\0=\4\a\0034\4\0\0=\4\b\0035\4\t\0=\4\n\0035\4\f\0005\5\v\0=\5\r\0045\5\14\0=\5\15\4=\4\16\0033\4\17\0=\4\18\3=\3\20\0025\3\21\0005\4\22\0=\4\23\0035\4\25\0005\5\24\0=\5\26\4=\4\27\0035\4\29\0005\5\28\0=\5\30\4=\4\31\0035\4 \0005\5!\0=\5\"\0045\5#\0=\5\b\0045\5$\0=\5\n\4=\4%\0035\4&\0004\5\0\0=\5\b\0045\5'\0=\5\n\0045\5(\0=\5\5\0045\5)\0=\5\a\0045\5*\0=\5+\0045\5,\0=\5\16\0043\5-\0=\5\18\4=\4.\0034\4\0\0=\4/\3=\0030\2B\0\2\1K\0\1\0\vselect\25format_item_override\fbuiltin\0\1\0\3\n<C-c>\nClose\t<CR>\fConfirm\n<Esc>\nClose\15min_height\1\3\0\0\3\n\4����\t����\3\1\3\0\0\3(\4����\t����\3\1\3\0\0\3�\1\4����\t����\3\1\0\2\rwinblend\3\n\17winhighlight\"Normal:Normal,NormalNC:Normal\1\0\4\rrelative\veditor\vborder\frounded\vanchor\aNW\15max_height\4͙��\f̙��\3\bnui\1\0\1\rwinblend\3\n\1\0\2\rfiletype\19DressingSelect\rswapfile\1\vborder\1\0\1\nstyle\frounded\1\0\6\14max_width\3P\14min_width\3(\rrelative\veditor\15min_height\3\n\rposition\b50%\15max_height\3(\ffzf_lua\fwinopts\1\0\0\1\0\2\nwidth\4\0����\3\vheight\4����\t����\3\bfzf\vwindow\1\0\0\1\0\2\nwidth\4\0����\3\vheight\4����\t����\3\fbackend\1\6\0\0\14telescope\ffzf_lua\bfzf\fbuiltin\bnui\1\0\2\16trim_prompt\2\fenabled\2\ninput\1\0\0\roverride\0\rmappings\6i\1\0\4\n<C-c>\nClose\t<Up>\16HistoryPrev\t<CR>\fConfirm\v<Down>\16HistoryNext\6n\1\0\0\1\0\2\n<Esc>\nClose\t<CR>\fConfirm\16win_options\1\0\3\twrap\1\rwinblend\3\n\17winhighlight\"Normal:Normal,NormalNC:Normal\16buf_options\14min_width\1\3\0\0\3\20\4����\t����\3\14max_width\1\3\0\0\3�\1\4͙��\f̙��\3\1\0\t\17prompt_align\tleft\16insert_only\2\vanchor\aSW\17prefer_width\3(\20start_in_insert\2\vborder\frounded\rrelative\vcursor\fenabled\2\19default_prompt\vInput:\nsetup\rdressing\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/opt/dressing.nvim",
    url = "https://github.com/stevearc/dressing.nvim"
  },
  ["flutter-tools.nvim"] = {
    config = { "\27LJ\2\n_\0\0\5\0\6\0\v6\0\0\0'\2\1\0B\0\2\0029\1\2\0005\3\3\0004\4\0\0=\4\4\0034\4\0\0=\4\5\3B\1\2\1K\0\1\0\blsp\rdebugger\1\0\0\nsetup\18flutter-tools\frequire\0" },
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/flutter-tools.nvim",
    url = "https://github.com/akinsho/flutter-tools.nvim"
  },
  ["friendly-snippets"] = {
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/friendly-snippets",
    url = "https://github.com/rafamadriz/friendly-snippets"
  },
  ["gitsigns.nvim"] = {
    config = { "\27LJ\2\nW\0\4\n\1\4\0\14\14\0\3\0X\4\1�4\3\0\0-\4\0\0=\4\0\0036\4\1\0009\4\2\0049\4\3\4\18\6\0\0\18\a\1\0\18\b\2\0\18\t\3\0B\4\5\1K\0\1\0\0�\bset\vkeymap\bvim\vbuffer#\0\0\2\1\1\0\4-\0\0\0009\0\0\0B\0\1\1K\0\1\0\0\0\14next_hunkg\1\0\3\1\a\0\0156\0\0\0009\0\1\0009\0\2\0\15\0\0\0X\1\2�'\0\3\0002\0\a�6\0\0\0009\0\4\0003\2\5\0B\0\2\1'\0\6\0002\0\0�L\0\2\0L\0\2\0\1�\r<Ignore>\0\rschedule\a]c\tdiff\awo\bvim#\0\0\2\1\1\0\4-\0\0\0009\0\0\0B\0\1\1K\0\1\0\0\0\14prev_hunkg\1\0\3\1\a\0\0156\0\0\0009\0\1\0009\0\2\0\15\0\0\0X\1\2�'\0\3\0002\0\a�6\0\0\0009\0\4\0003\2\5\0B\0\2\1'\0\6\0002\0\0�L\0\2\0L\0\2\0\1�\r<Ignore>\0\rschedule\a[c\tdiff\awo\bvim1\0\0\3\1\2\0\5-\0\0\0009\0\0\0005\2\1\0B\0\2\1K\0\1\0\1�\1\0\1\tfull\2\15blame_line(\0\0\3\1\2\0\5-\0\0\0009\0\0\0'\2\1\0B\0\2\1K\0\1\0\1�\6~\rdiffthis�\a\1\1\t\0002\0Z6\1\0\0009\1\1\0019\1\2\0013\2\3\0\18\3\2\0'\5\4\0'\6\5\0003\a\6\0005\b\a\0B\3\5\1\18\3\2\0'\5\4\0'\6\b\0003\a\t\0005\b\n\0B\3\5\1\18\3\2\0005\5\v\0'\6\f\0'\a\r\0005\b\14\0B\3\5\1\18\3\2\0005\5\15\0'\6\16\0'\a\17\0005\b\18\0B\3\5\1\18\3\2\0'\5\4\0'\6\19\0009\a\20\0015\b\21\0B\3\5\1\18\3\2\0'\5\4\0'\6\22\0009\a\23\0015\b\24\0B\3\5\1\18\3\2\0'\5\4\0'\6\25\0009\a\26\0015\b\27\0B\3\5\1\18\3\2\0'\5\4\0'\6\28\0009\a\29\0015\b\30\0B\3\5\1\18\3\2\0'\5\4\0'\6\31\0003\a \0005\b!\0B\3\5\1\18\3\2\0'\5\4\0'\6\"\0009\a#\0015\b$\0B\3\5\1\18\3\2\0'\5\4\0'\6%\0009\a&\0015\b'\0B\3\5\1\18\3\2\0'\5\4\0'\6(\0003\a)\0005\b*\0B\3\5\1\18\3\2\0'\5\4\0'\6+\0009\a,\0015\b-\0B\3\5\1\18\3\2\0005\5.\0'\6/\0'\a0\0005\b1\0B\3\5\0012\0\0�K\0\1\0\1\0\1\tdesc\16Select Hunk#:<C-U>Gitsigns select_hunk<CR>\aih\1\3\0\0\6o\6x\1\0\1\tdesc\18Toggle Delete\19toggle_deleted\16<leader>gtd\1\0\1\tdesc\16Diff This ~\0\16<leader>ghD\1\0\1\tdesc\14Diff This\rdiffthis\16<leader>ghd\1\0\1\tdesc\22Toggle Line Blame\30toggle_current_line_blame\16<leader>gtb\1\0\1\tdesc\15Blame Line\0\16<leader>ghb\1\0\1\tdesc\17Preview Hunk\17preview_hunk\16<leader>ghp\1\0\1\tdesc\17Reset Buffer\17reset_buffer\16<leader>ghR\1\0\1\tdesc\20Undo Stage Hunk\20undo_stage_hunk\16<leader>ghu\1\0\1\tdesc\17Stage Buffer\17stage_buffer\16<leader>ghS\1\0\1\tdesc\15Reset Hunk\29:Gitsigns reset_hunk<CR>\16<leader>ghr\1\3\0\0\6n\6v\1\0\1\tdesc\15Stage Hunk\29:Gitsigns stage_hunk<CR>\16<leader>ghs\1\3\0\0\6n\6v\1\0\1\texpr\2\0\a[c\1\0\1\texpr\2\0\a]c\6n\0\rgitsigns\vloaded\fpackage�\4\1\0\6\0\18\0\0213\0\0\0006\1\1\0'\3\2\0B\1\2\0029\1\3\0015\3\15\0005\4\5\0005\5\4\0=\5\6\0045\5\a\0=\5\b\0045\5\t\0=\5\n\0045\5\v\0=\5\f\0045\5\r\0=\5\14\4=\4\16\3=\0\17\3B\1\2\1K\0\1\0\14on_attach\nsigns\1\0\0\17changedelete\1\0\4\ahl\19GitSignsChange\vlinehl\21GitSignsChangeLn\nnumhl\21GitSignsChangeNr\ttext\b▍\14topdelete\1\0\4\ahl\19GitSignsDelete\vlinehl\21GitSignsDeleteLn\nnumhl\21GitSignsDeleteNr\ttext\b▾\vdelete\1\0\4\ahl\19GitSignsDelete\vlinehl\21GitSignsDeleteLn\nnumhl\21GitSignsDeleteNr\ttext\b▸\vchange\1\0\4\ahl\19GitSignsChange\vlinehl\21GitSignsChangeLn\nnumhl\21GitSignsChangeNr\ttext\b▍\badd\1\0\0\1\0\4\ahl\16GitSignsAdd\vlinehl\18GitSignsAddLn\nnumhl\18GitSignsAddNr\ttext\b▍\nsetup\rgitsigns\frequire\0\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/opt/gitsigns.nvim",
    url = "https://github.com/lewis6991/gitsigns.nvim"
  },
  ["hlargs.nvim"] = {
    config = { "\27LJ\2\n�\2\0\2\v\0\r\0'6\2\0\0009\2\1\0029\2\2\2\15\0\2\0X\3\2�+\2\2\0L\2\2\0006\2\0\0009\2\3\0029\2\4\0025\4\5\0=\1\6\4B\2\2\0026\3\a\0\18\5\2\0B\3\2\4H\6\19�9\b\b\a9\t\t\a\6\t\n\0X\t\15�9\t\v\b\15\0\t\0X\n\f�9\t\v\b9\t\f\t\15\0\t\0X\n\b�6\t\0\0009\t\1\t+\n\2\0=\n\2\t6\t\0\0009\t\1\t9\t\2\tL\t\2\0F\6\3\3R\6�\127K\0\1\0\tfull\27semanticTokensProvider\fnull-ls\tname\24server_capabilities\npairs\nbufnr\1\0\0\23get_active_clients\blsp\20semantic_tokens\6b\bvim�\3\1\0\5\0\21\0'6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0004\3\15\0005\4\4\0>\4\1\0035\4\5\0>\4\2\0035\4\6\0>\4\3\0035\4\a\0>\4\4\0035\4\b\0>\4\5\0035\4\t\0>\4\6\0035\4\n\0>\4\a\0035\4\v\0>\4\b\0035\4\f\0>\4\t\0035\4\r\0>\4\n\0035\4\14\0>\4\v\0035\4\15\0>\4\f\0035\4\16\0>\4\r\0035\4\17\0>\4\14\3=\3\18\0023\3\19\0=\3\20\2B\0\2\1K\0\1\0\fdisable\0\17colorpalette\1\0\1\afg\f#8FB272\1\0\1\afg\f#EEF06D\1\0\1\afg\f#BBEA87\1\0\1\afg\f#DE9A4E\1\0\1\afg\f#F67C1B\1\0\1\afg\f#F6B223\1\0\1\afg\f#7FEC35\1\0\1\afg\f#D49DA5\1\0\1\afg\f#8997F5\1\0\1\afg\f#E5D180\1\0\1\afg\f#EB75D6\1\0\1\afg\f#35D27F\1\0\1\afg\f#3AC6BE\1\0\1\afg\f#ef9062\1\0\2\21use_colorpalette\1\ncolor\f#ef9062\nsetup\vhlargs\frequire\0" },
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/hlargs.nvim",
    url = "https://github.com/m-demare/hlargs.nvim"
  },
  ["hop.nvim"] = {
    config = { "\27LJ\2\nO\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\tkeys\22çalskdjfwoeicmvn\nsetup\bhop\frequire\0" },
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/hop.nvim",
    url = "https://github.com/phaazon/hop.nvim"
  },
  ["impatient.nvim"] = {
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/impatient.nvim",
    url = "https://github.com/lewis6991/impatient.nvim"
  },
  ["indent-blankline.nvim"] = {
    config = { "\27LJ\2\n�\2\0\0\4\0\b\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\0025\3\6\0=\3\a\2B\0\2\1K\0\1\0\21filetype_exclude\1\b\0\0\thelp\14dashboard\vpacker\rNvimTree\fTrouble\20TelescopePrompt\nFloat\20buftype_exclude\1\4\0\0\rterminal\14telescope\vnofile\1\0\a\21show_end_of_line\1\tchar\b┊\19use_treesitter\2\25space_char_blankline\6 #show_trailing_blankline_indent\1\25show_current_context\2\31show_current_context_start\1\nsetup\21indent_blankline\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/opt/indent-blankline.nvim",
    url = "https://github.com/lukas-reineke/indent-blankline.nvim"
  },
  ["lsp-colors.nvim"] = {
    config = { "\27LJ\2\n~\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\4\nError\f#db4b4b\16Information\f#0db9d7\fWarning\f#e0af68\tHint\f#10B981\nsetup\15lsp-colors\frequire\0" },
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/lsp-colors.nvim",
    url = "https://github.com/folke/lsp-colors.nvim"
  },
  ["lspkind.nvim"] = {
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/lspkind.nvim",
    url = "https://github.com/onsails/lspkind.nvim"
  },
  ["lspsaga.nvim"] = {
    commands = { "Lspsaga" },
    config = { "\27LJ\2\n�\4\0\0\6\0\22\0\0276\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\5\0005\3\3\0004\4\0\0=\4\4\3=\3\6\0025\3\a\0=\3\b\0025\3\t\0=\3\n\0025\3\v\0005\4\f\0=\4\r\3=\3\14\0025\3\15\0005\4\16\0005\5\17\0=\5\18\0045\5\19\0=\5\20\4=\4\r\3=\3\21\2B\0\2\1K\0\1\0\vfinder\tquit\1\3\0\0\6q\n<ESC>\tedit\1\3\0\0\6o\t<CR>\1\0\6\fjump_to\6p\ttabe\6t\vtabnew\6r\vvsplit\6s\nsplit\6i\21close_in_preview\n<ESC>\1\0\2\21force_max_height\1\15max_height\4\0����\3\16code_action\tkeys\1\0\2\texec\t<CR>\tquit\6q\1\0\3\21show_server_name\1\20extend_gitsigns\2\17num_shortcut\2\14lightbulb\1\0\5\21enable_in_insert\2\18sign_priority\3(\venable\1\tsign\1\17virtual_text\2\vrename\1\0\5\tquit\6q\14in_select\2\fconfirm\t<CR>\texec\t<CR>\tmark\6x\aui\1\0\0\tkind\1\0\t\vexpand\b\rwinblend\3\0\ntitle\2\routgoing\t \vborder\vsingle\16code_action\t💡\rcollapse\b\rincoming\t \nhover\t \nsetup\flspsaga\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/opt/lspsaga.nvim",
    url = "https://github.com/glepnir/lspsaga.nvim"
  },
  ["lualine.nvim"] = {
    config = { "\27LJ\2\n\127\0\2\6\0\5\0\r'\2\1\0=\2\0\0'\2\1\0=\2\2\0\18\4\0\0009\2\3\0\18\5\1\0B\2\3\1\18\4\0\0009\2\4\0B\2\2\0019\2\0\0L\2\2\0\29apply_section_separators\21apply_highlights\22applied_separator\5\vstatus�\3\0\1\18\2\17\2C6\1\0\0\18\3\0\0B\1\2\4H\4<�\18\b\4\0009\6\1\4)\t\t\0)\n\n\0B\6\4\2'\a\2\0\0\6\a\0X\6\2�+\6\1\0X\a\1�+\6\2\0)\a\1\0\6\4\3\0X\b\3�\21\b\5\0\14\0\b\0X\t\2�\21\b\5\0\23\b\0\b)\t\1\0M\a\17�6\v\4\0009\v\5\v\18\r\5\0\24\14\1\n5\15\n\0-\16\0\0>\16\1\0155\16\a\0-\17\1\0009\17\6\17=\17\b\16-\17\1\0009\17\6\17=\17\t\16=\16\v\15B\v\4\1O\a�\1276\a\f\0\18\t\5\0B\a\2\4X\n\16�6\f\r\0\18\14\v\0B\f\2\2\6\f\4\0X\f\4�4\f\3\0>\v\1\f\18\v\f\0<\v\n\5\15\0\6\0X\f\3�5\f\15\0\14\0\f\0X\r\1�5\f\16\0=\f\14\vE\n\3\3R\n�\127F\4\3\3R\4�\127L\0\2\0\2�\0�\1\0\1\tleft\b\1\0\1\nright\b\14separator\ttype\vipairs\ncolor\1\0\0\abg\afg\1\0\0\16transparent\vinsert\ntable\14lualine_z\6x\bsub\npairs\2\4�\1\0\0\1\0\b\0\0226\0\0\0009\0\1\0009\0\2\0\15\0\0\0X\1\3�'\0\3\0L\0\2\0X\0\f�6\0\0\0009\0\1\0009\0\4\0\n\0\1\0X\0\5�6\0\0\0009\0\1\0009\0\5\0\v\0\2\0X\0\2�'\0\6\0L\0\2\0'\0\a\0L\0\2\0\5\6-\rreadonly\15modifiable\6+\rmodified\abo\bvim,\0\0\1\0\3\0\0046\0\0\0009\0\1\0009\0\2\0L\0\2\0\18previewwindow\awo\bvim'\0\0\1\0\3\0\0046\0\0\0009\0\1\0009\0\2\0L\0\2\0\rreadonly\abo\bvimC\0\0\1\0\4\0\t6\0\0\0009\0\1\0009\0\2\0\6\0\3\0X\0\2�+\0\1\0X\1\1�+\0\2\0L\0\2\0\rquickfix\fbuftype\abo\bvim�\f\1\0\14\0X\0�\0015\0\0\0005\1\r\0005\2\6\0005\3\2\0009\4\1\0=\4\3\0039\4\4\0=\4\5\3=\3\a\0025\3\b\0009\4\1\0=\4\3\0039\4\4\0=\4\5\3=\3\t\0025\3\n\0009\4\1\0=\4\3\0039\4\v\0=\4\5\3=\3\f\2=\2\14\0015\2\18\0005\3\16\0009\4\15\0=\4\3\0039\4\17\0=\4\5\3=\3\a\0025\3\19\0009\4\1\0=\4\3\0039\4\4\0=\4\5\3=\3\t\0025\3\20\0009\4\1\0=\4\3\0039\4\v\0=\4\5\3=\3\f\2=\2\17\0015\2\23\0005\3\21\0009\4\15\0=\4\3\0039\4\22\0=\4\5\3=\3\a\0025\3\24\0009\4\1\0=\4\3\0039\4\4\0=\4\5\3=\3\t\0025\3\25\0009\4\1\0=\4\3\0039\4\v\0=\4\5\3=\3\f\2=\2\22\0015\2\28\0005\3\27\0009\4\26\0=\4\5\3=\3\a\0025\3\29\0009\4\1\0=\4\3\0039\4\4\0=\4\5\3=\3\t\0025\3\30\0009\4\1\0=\4\3\0039\4\v\0=\4\5\3=\3\f\2=\2\26\0015\2!\0005\3\31\0009\4\15\0=\4\3\0039\4 \0=\4\5\3=\3\a\0025\3\"\0009\4\1\0=\4\3\0039\4\4\0=\4\5\3=\3\t\0025\3#\0009\4\1\0=\4\3\0039\4\v\0=\4\5\3=\3\f\2=\2 \0015\2&\0005\3$\0009\4\15\0=\4\3\0039\4%\0=\4\5\3=\3\a\0025\3'\0009\4\1\0=\4\3\0039\4\4\0=\4\5\3=\3\t\0025\3(\0009\4\1\0=\4\3\0039\4\v\0=\4\5\3=\3\f\2=\2%\0016\2)\0'\4*\0B\2\2\2\18\4\2\0009\2+\2B\2\2\0023\3-\0=\3,\0023\3.\0003\4/\0006\5)\0'\a0\0B\5\2\0029\0051\0055\a8\0005\b2\0=\0013\b5\t4\0=\t5\b5\t6\0=\t7\b=\b9\a\18\b\3\0005\n;\0005\v:\0=\v<\n5\v=\0005\f>\0005\r?\0=\r@\f5\rA\0=\rB\f>\f\3\v5\fC\0005\rD\0=\r@\f5\rE\0=\rB\f>\f\4\v5\fF\0>\f\5\v4\f\3\0>\4\1\f>\f\6\v5\fG\0003\rH\0=\rI\f>\f\a\v5\fJ\0003\rK\0=\rI\f>\f\b\v5\fL\0003\rM\0=\rI\f>\f\t\v=\vN\n4\v\0\0=\vO\n4\v\0\0=\vP\n5\vQ\0=\vR\n5\vS\0=\vT\nB\b\2\2=\bB\a5\bV\0005\tU\0=\tO\b4\t\0\0=\tP\b=\bW\aB\5\2\0012\0\0�K\0\1\0\22inactive_sections\1\0\0\1\2\0\0\r%f %y %m\14lualine_z\1\2\0\0\f%p%%/%L\14lualine_y\1\2\0\0\rfiletype\14lualine_x\14lualine_c\14lualine_b\0\1\2\0\0\a%q\0\1\2\0\0\a%r\tcond\0\1\2\0\0\a%w\1\2\2\0\rfilename\16file_status\1\tpath\3\1\1\2\0\0\twarn\1\2\0\0\tnvim\1\2\0\0\16diagnostics\rsections\1\2\0\0\nerror\vsource\1\2\0\0\tnvim\1\2\0\0\16diagnostics\1\3\0\0\vbranch\tdiff\14lualine_a\1\0\0\1\2\0\0\tmode\foptions\1\0\0\23section_separators\1\0\2\nright\b\tleft\b\25component_separators\1\0\2\nright\b\tleft\b\ntheme\1\0\0\nsetup\flualine\0\0\0\tdraw\vextend\22lualine.component\frequire\1\0\0\1\0\0\1\0\0\fcommand\1\0\1\bgui\tbold\1\0\0\1\0\0\1\0\0\vinsert\1\0\1\bgui\tbold\1\0\0\1\0\0\1\0\0\1\0\1\bgui\tbold\vnormal\1\0\0\1\0\0\1\0\0\freplace\1\0\1\bgui\tbold\1\0\0\1\0\0\1\0\0\vvisual\1\0\1\bgui\tbold\rdarkgray\rinactive\1\0\0\6c\finnerbg\1\0\0\6b\1\0\0\6a\1\0\0\abg\fouterbg\afg\1\0\1\bgui\tbold\tgray\1\0\b\tgray\f#727169\fouterbg\f#16161D\fcommand\f#e6c384\vvisual\f#ffa066\rdarkgray\f#16161d\freplace\f#e46876\vnormal\f#7e9cd8\vinsert\f#98bb6c\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/opt/lualine.nvim",
    url = "https://github.com/nvim-lualine/lualine.nvim"
  },
  ["mason-lspconfig.nvim"] = {
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/mason-lspconfig.nvim",
    url = "https://github.com/williamboman/mason-lspconfig.nvim"
  },
  ["mason-null-ls.nvim"] = {
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/mason-null-ls.nvim",
    url = "https://github.com/jay-babu/mason-null-ls.nvim"
  },
  ["mason.nvim"] = {
    config = { "\27LJ\2\n�\1\0\1\t\2\b\0\23-\1\0\0009\1\0\0016\2\1\0006\4\2\0'\5\3\0\18\6\0\0&\5\6\5B\2\3\3\15\0\2\0X\4\a�6\4\4\0009\4\5\4'\6\6\0\18\a\1\0\18\b\3\0B\4\4\2\18\1\4\0-\4\1\0008\4\0\0049\4\a\4\18\6\1\0B\4\2\1K\0\1\0\4�\1�\nsetup\nforce\15tbl_extend\bvim\24config.lsp.servers.\frequire\npcall\19default_config4\0\0\3\2\2\0\a-\0\0\0009\0\0\0B\0\1\1-\0\1\0'\2\1\0B\0\2\1K\0\1\0\2�\6�\vlua_ls\nsetup�\3\1\0\v\0\22\0,6\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0026\2\0\0'\4\3\0B\2\2\0026\3\0\0'\5\4\0B\3\2\0026\4\0\0'\6\5\0B\4\2\0026\5\0\0'\a\6\0B\5\2\0029\6\a\0005\b\v\0005\t\b\0005\n\t\0=\n\n\t=\t\f\bB\6\2\0019\6\a\0055\b\r\0004\t\0\0=\t\14\bB\6\2\0019\6\a\0035\b\16\0009\t\15\4=\t\14\bB\6\2\0013\6\17\0009\a\18\0035\t\20\0>\6\1\t3\n\19\0=\n\21\tB\a\2\0012\0\0�K\0\1\0\vlua_ls\1\0\0\0\19setup_handlers\0\1\0\1\27automatic_installation\2\fservers\21ensure_installed\1\0\1\20automatic_setup\2\aui\1\0\0\nicons\1\0\3\24package_uninstalled\b✗\20package_pending\b⟳\22package_installed\b✓\1\0\1\vborder\frounded\nsetup\18mason-null-ls\15config.lsp\20mason-lspconfig\vneodev\14lspconfig\nmason\frequire\0" },
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/mason.nvim",
    url = "https://github.com/williamboman/mason.nvim"
  },
  ["neodev.nvim"] = {
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/neodev.nvim",
    url = "https://github.com/folke/neodev.nvim"
  },
  ["noice.nvim"] = {
    config = { "\27LJ\2\n�\6\0\0\t\0'\00015\0\1\0005\1\0\0=\1\2\0005\1\3\0=\1\4\0005\1\5\0005\2\6\0=\2\2\0015\2\a\0=\2\4\0015\2\b\0005\3\t\0=\3\n\2=\2\v\0015\2\r\0005\3\f\0=\3\14\2=\2\15\0015\2\17\0005\3\16\0=\3\18\0025\3\19\0=\3\20\0025\3\22\0005\4\21\0=\4\18\0035\4\23\0=\4\20\0036\4\24\0'\6\25\0B\4\2\0029\4\26\0045\6\28\0005\a\27\0=\a\29\0064\a\3\0>\2\1\a>\3\2\a=\a\30\0065\a \0005\b\31\0=\b!\a5\b\"\0=\b#\a=\a$\0065\a%\0=\a&\6B\4\2\1K\0\1\0\fpresets\1\0\5\18bottom_search\2\19lsp_doc_border\2\15inc_rename\1\26long_message_to_split\2\20command_palette\1\blsp\roverride\1\0\0031vim.lsp.util.convert_input_to_markdown_lines\2 cmp.entry.get_documentation\2\"vim.lsp.util.stylize_markdown\2\rprogress\1\0\0\1\0\1\fenabled\1\vroutes\fcmdline\1\0\0\1\0\1\tview\fcmdline\nsetup\nnoice\frequire\1\0\1\tskip\2\1\0\0\1\0\2\nevent\rmsg_show\tkind\17search_count\topts\1\0\1\tskip\2\vfilter\1\0\0\1\0\3\nevent\rmsg_show\tkind\5\tfind\fwritten\16win_options\17winhighlight\1\0\0\1\0\2\vNormal\vNormal\16FloatBorder\19DiagnosticInfo\vborder\fpadding\1\3\0\0\3\0\3\1\1\0\1\nstyle\frounded\1\0\2\nwidth\3<\vheight\3\n\1\0\2\bcol\b50%\brow\3\b\1\0\1\rrelative\veditor\tsize\1\0\2\nwidth\3<\vheight\tauto\rposition\1\0\0\1\0\2\bcol\b50%\brow\3\5\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/opt/noice.nvim",
    url = "https://github.com/folke/noice.nvim"
  },
  ["nui.nvim"] = {
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/nui.nvim",
    url = "https://github.com/MunifTanjim/nui.nvim"
  },
  ["null-ls.nvim"] = {
    config = { "\27LJ\2\nl\0\0\5\0\b\0\f6\0\0\0009\0\1\0009\0\2\0009\0\3\0005\2\6\0006\3\0\0009\3\4\0039\3\5\3B\3\1\2=\3\a\2B\0\2\1K\0\1\0\nbufnr\1\0\0\25nvim_get_current_buf\bapi\vformat\bbuf\blsp\bvimV\1\2\b\0\b\0\n6\2\0\0009\2\1\0029\2\2\2'\4\3\0'\5\4\0003\6\5\0005\a\6\0=\1\a\aB\2\5\1K\0\1\0\vbuffer\1\0\0\0\15<Leader>ff\6n\bset\vkeymap\bvim�\3\1\0\t\0\21\1)6\0\0\0'\2\1\0B\0\2\0029\1\2\0009\2\3\0005\4\17\0004\5\n\0009\6\4\0019\6\5\6>\6\1\0059\6\4\0019\6\6\6>\6\2\0059\6\4\0019\6\a\6>\6\3\0059\6\4\0019\6\b\6>\6\4\0059\6\t\0019\6\n\6>\6\5\0059\6\v\0019\6\f\6>\6\6\0059\6\r\0019\6\14\6>\6\a\0059\6\2\0009\6\r\0069\6\15\6>\6\b\0056\6\0\0'\b\16\0B\6\2\0?\6\0\0=\5\18\0043\5\19\0=\5\20\4B\2\2\1K\0\1\0\14on_attach\0\fsources\1\0\0/typescript.extensions.null-ls.code-actions\rgitsigns\reslint_d\17code_actions\fluasnip\15completion\veslint\16diagnostics\ffixjson\14prettierd\nblack\vstylua\15formatting\nsetup\rbuiltins\fnull-ls\frequire\19����\4\0" },
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/null-ls.nvim",
    url = "https://github.com/jose-elias-alvarez/null-ls.nvim"
  },
  ["nvim-autopairs"] = {
    config = { "\27LJ\2\n�\3\0\0\t\0\21\0\"6\0\0\0006\2\1\0'\3\2\0B\0\3\3\15\0\0\0X\2\v�9\2\3\1\18\4\2\0009\2\4\2'\5\5\0006\6\1\0'\b\6\0B\6\2\0029\6\a\0065\b\b\0B\6\2\0A\2\2\0016\2\1\0'\4\t\0B\2\2\0029\2\n\0025\4\v\0005\5\r\0005\6\f\0=\6\14\0055\6\15\0=\6\16\5=\5\17\0045\5\18\0=\5\19\0044\5\0\0=\5\20\4B\2\2\1K\0\1\0\14fast_wrap\21disable_filetype\1\3\0\0\20TelescopePrompt\bvim\14ts_config\15javascript\1\3\0\0\vstring\20template_string\blua\1\0\1\tjava\1\1\3\0\0\vstring\vsource\1\0\1\rcheck_ts\2\nsetup\19nvim-autopairs\1\0\1\btex\1\20on_confirm_done\"nvim-autopairs.completion.cmp\17confirm_done\aon\nevent\bcmp\frequire\npcall\0" },
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/nvim-autopairs",
    url = "https://github.com/windwp/nvim-autopairs"
  },
  ["nvim-cmp"] = {
    config = { "\27LJ\2\n�\1\0\1\3\0\b\0\0264\1\t\0005\2\0\0>\0\2\2>\2\1\0015\2\1\0>\0\2\2>\2\2\0015\2\2\0>\0\2\2>\2\3\0015\2\3\0>\0\2\2>\2\4\0015\2\4\0>\0\2\2>\2\5\0015\2\5\0>\0\2\2>\2\6\0015\2\6\0>\0\2\2>\2\a\0015\2\a\0>\0\2\2>\2\b\1L\1\2\0\1\2\0\0\b│\1\2\0\0\b╰\1\2\0\0\b─\1\2\0\0\b╯\1\2\0\0\b│\1\2\0\0\b╮\1\2\0\0\b─\1\2\0\0\b╭-\0\1\4\1\2\0\5-\1\0\0009\1\0\0019\3\1\0B\1\2\1K\0\1\0\2�\tbody\15lsp_expandT\0\0\2\1\3\0\r-\0\0\0009\0\0\0B\0\1\2\15\0\0\0X\1\4�-\0\0\0009\0\1\0B\0\1\1X\0\3�-\0\0\0009\0\2\0B\0\1\1K\0\1\0\0�\rcomplete\nabort\fvisible�\1\0\1\t\1\a\0\18-\1\0\0009\1\0\1B\1\1\0016\1\1\0009\1\2\0019\1\3\0016\3\1\0009\3\2\0039\3\4\3'\5\5\0+\6\2\0+\a\2\0+\b\2\0B\3\5\2'\4\6\0+\5\2\0B\1\4\1K\0\1\0\0�\6n\n<ESC>\27nvim_replace_termcodes\18nvim_feedkeys\bapi\bvim\nabort�\18\1\0\16\0t\0�\0016\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0026\2\0\0'\4\3\0B\2\2\0026\3\0\0'\5\4\0B\3\2\0029\3\5\3B\3\1\0013\3\6\0006\4\0\0'\6\a\0B\4\2\0029\4\2\0049\5\b\0005\a\f\0005\b\n\0003\t\t\0=\t\v\b=\b\r\a9\b\14\0009\b\15\b9\b\16\b5\n\22\0009\v\14\0009\v\17\v5\r\20\0009\14\18\0009\14\19\14=\14\21\rB\v\2\2=\v\23\n9\v\14\0009\v\17\v5\r\24\0009\14\18\0009\14\19\14=\14\21\rB\v\2\2=\v\25\n9\v\14\0009\v\26\v5\r\27\0009\14\18\0009\14\19\14=\14\21\rB\v\2\2=\v\28\n9\v\14\0009\v\26\v5\r\29\0009\14\18\0009\14\19\14=\14\21\rB\v\2\2=\v\30\n9\v\14\0009\r\14\0009\r\31\r)\15��B\r\2\0025\14 \0B\v\3\2=\v!\n9\v\14\0009\r\14\0009\r\31\r)\15\4\0B\r\2\0025\14\"\0B\v\3\2=\v#\n9\v\14\0003\r$\0005\14%\0B\v\3\2=\v&\n9\v\14\0009\v'\v5\r*\0009\14(\0009\14)\14=\14\21\rB\v\2\2=\v+\n9\v\14\0005\r-\0003\14,\0=\14.\r9\14\14\0009\14/\14B\14\1\2=\0140\rB\v\2\2=\v1\nB\b\2\2=\b\14\a5\b3\0005\t2\0=\t4\b9\t5\0015\v6\0=\0047\vB\t\2\2=\t8\b=\b9\a9\b:\0009\b;\b4\n\t\0005\v<\0>\v\1\n5\v=\0>\v\2\n5\v>\0>\v\3\n5\v?\0>\v\4\n5\v@\0>\v\5\n5\vA\0>\v\6\n5\vB\0>\v\a\n5\vC\0>\v\b\nB\b\2\2=\b;\a5\bD\0004\t\n\0006\n\0\0'\fE\0B\n\2\0029\nF\n>\n\1\t9\n:\0009\nG\n9\nH\n>\n\2\t9\n:\0009\nG\n9\nI\n>\n\3\t9\n:\0009\nG\n9\nJ\n>\n\4\t9\n:\0009\nG\n9\nK\n>\n\5\t9\n:\0009\nG\n9\nL\n>\n\6\t9\n:\0009\nG\n9\nM\n>\n\a\t9\n:\0009\nG\n9\nN\n>\n\b\t9\n:\0009\nG\n9\nO\n>\n\t\t=\tP\b=\bQ\a5\bR\0=\bS\a5\bT\0009\t(\0009\t)\t=\t\21\b=\bU\a5\bY\0009\t:\0009\tV\t9\tW\t5\vX\0B\t\2\2=\tZ\b\18\t\3\0'\v[\0B\t\2\2=\t\\\b=\bV\a5\b]\0=\b^\a9\b_\0009\b`\b=\ba\a5\bb\0=\bc\aB\5\2\0019\5\b\0009\5d\5'\ae\0005\bf\0009\t\14\0009\t\15\t9\td\tB\t\1\2=\t\14\b9\t:\0009\t;\t4\v\3\0005\fg\0>\f\1\v4\f\3\0005\rh\0>\r\1\fB\t\3\2=\t;\bB\5\3\0016\5\0\0'\ai\0B\5\2\0029\5\b\0055\ar\0005\bl\0006\t\0\0'\vj\0B\t\2\0029\tk\t=\tm\b6\t\0\0'\vj\0B\t\2\0029\tn\t=\to\b6\t\0\0'\vj\0B\t\2\0029\tp\t=\tq\b=\bs\aB\5\2\0012\0\0�K\0\1\0\15formatters\1\0\0\fpreview\rdeindent\16insert_text\20remove_existing\nlabel\1\0\0\22format_label_text\23copilot_cmp.format\16copilot_cmp\1\0\1\tname\fcmdline\1\0\1\tname\tpath\1\0\0\6:\fcmdline\tview\1\0\1\fentries\vcustom\14preselect\tNone\18PreselectMode\17experimental\1\0\1\15ghost_text\2\vborder\17CmpDocBorder\15completion\1\0\0\1\0\2\vborder\frounded\17winhighlightENormal:CmpNormal,NormalFloat:NormalFloat,FloatBorder:FloatBorder\rbordered\vwindow\17confirm_opts\1\0\1\vselect\1\15duplicates\1\0\5\fluasnip\3\1\vbuffer\3\1\tpath\3\1\rnvim_lsp\3\1\16cmp_tabnine\3\1\fsorting\16comparators\norder\14sort_text\rlocality\tkind\nexact\voffset\18recently_used\nscore\fcompare\15prioritize\28copilot_cmp.comparators\1\0\1\20priority_weight\3\2\1\0\4\19keyword_length\3\5\rpriority\3�\3\19max_item_count\3\5\tname\vbuffer\1\0\2\19max_item_count\3�\4\tname\15treesitter\1\0\2\rpriority\3�\4\tname\rnvim_lua\1\0\3\rpriority\3�\5\19max_item_count\3\5\tname\fluasnip\1\0\2\rpriority\3�\a\tname\bnpm\1\0\3\rpriority\3�\a\19max_item_count\3\15\tname\rnvim_lsp\1\0\2\rpriority\3�\a\tname\fcopilot\1\0\3\rpriority\3�\15\19max_item_count\3\4\tname\tpath\fsources\vconfig\15formatting\vformat\15symbol_map\1\0\2\14max_width\3(\tmode\vsymbol\15cmp_format\vfields\1\0\0\1\4\0\0\tkind\tabbr\tmenu\n<ESC>\6c\nclose\6i\1\0\0\0\t<CR>\1\0\1\vselect\2\fReplace\20ConfirmBehavior\fconfirm\14<C-Space>\1\3\0\0\6i\6c\0\n<C-d>\1\3\0\0\6i\6c\n<C-u>\1\3\0\0\6i\6c\16scroll_docs\n<C-n>\1\0\0\n<C-k>\1\0\0\21select_next_item\n<C-p>\1\0\0\n<C-l>\1\0\0\rbehavior\1\0\0\vSelect\19SelectBehavior\21select_prev_item\vinsert\vpreset\fmapping\fsnippet\1\0\0\vexpand\1\0\0\0\nsetup\16utils.icons\0\14lazy_load luasnip/loaders/from_vscode\fluasnip\flspkind\bcmp\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/opt/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-colorizer.lua"] = {
    commands = { "ColorizerToggle", "ColorizerAttachToBuffer", "ColorizerDetachFromBuffer", "ColorizerReloadAllBuffers" },
    config = { "\27LJ\2\n;\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\14colorizer\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/opt/nvim-colorizer.lua",
    url = "https://github.com/norcalli/nvim-colorizer.lua"
  },
  ["nvim-lsp-ts-utils"] = {
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/nvim-lsp-ts-utils",
    url = "https://github.com/jose-elias-alvarez/nvim-lsp-ts-utils"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-notify"] = {
    config = { "\27LJ\2\n�\1\0\0\a\0\19\0\0276\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0029\2\3\0005\4\17\0005\5\6\0009\6\4\0019\6\5\6=\6\a\0059\6\4\0019\6\b\6=\6\t\0059\6\4\0019\6\n\6=\6\v\0059\6\f\0019\6\r\6=\6\14\0059\6\f\0019\6\15\6=\6\16\5=\5\18\4B\2\2\1K\0\1\0\nicons\1\0\0\nTRACE\vPencil\nDEBUG\bBug\aui\tINFO\16Information\tWARN\fWarning\nERROR\1\0\0\nError\16diagnostics\nsetup\16utils.icons\vnotify\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/opt/nvim-notify",
    url = "https://github.com/rcarriga/nvim-notify"
  },
  ["nvim-tree.lua"] = {
    commands = { "NvimTreeToggle", "NvimTreeClose", "NvimTreeOpen", "NvimTreeFindFile", "NvimTreeFindFileToggle" },
    config = { "\27LJ\2\n�\1\0\0\4\2\a\0\17-\0\0\0009\0\0\0B\0\1\2\v\0\0\0X\1\1�K\0\1\0006\1\1\0009\1\2\1'\3\3\0B\1\2\1-\1\1\0009\1\4\0019\1\5\0019\1\6\1\18\3\0\0B\1\2\1K\0\1\0\1�\2�\btab\topen\tnode\rwincmd l\bcmd\bvim\23get_node_at_cursorX\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\afn2nvim-tree.actions.tree-modifiers.collapse-all\frequirem\0\0\4\1\3\0\14-\0\0\0009\0\0\0B\0\1\2\v\0\0\0X\1\1�K\0\1\0009\1\1\0\n\1\0\0X\1\4�-\1\0\0009\1\2\1\18\3\0\0B\1\2\1K\0\1\0\1�\23expand_or_collapse\nnodes\23get_node_at_cursor�\2\0\0\6\1\15\0\"-\0\0\0009\0\0\0B\0\1\0029\1\1\0009\1\2\1\6\1\3\0X\2\6�\6\1\4\0X\2\4�\6\1\5\0X\2\2�\a\1\6\0X\2\a�6\2\a\0009\2\b\2'\4\t\0009\5\n\0&\4\5\4B\2\2\1X\2\n�\6\1\v\0X\2\2�\a\1\f\0X\2\6�6\2\a\0009\2\b\2'\4\r\0009\5\n\0&\4\5\4B\2\2\1-\2\0\0009\2\14\2B\2\1\1K\0\1\0\1�\17refresh_tree\"silent !git restore --staged \aA \aM \18absolute_path\21silent !git add \bcmd\bvim\a M\aAM\aMM\a??\tfile\15git_status\23get_node_at_cursorS\0\1\4\1\6\0\v-\1\0\0009\1\0\0019\1\1\0019\1\2\1\18\3\0\0B\1\2\0016\1\3\0009\1\4\0019\1\5\1B\1\1\1K\0\1\0\2�\ftabprev\bcmd\bvim\btab\topen\tnode�\21\1\0\18\0u\0�\0016\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0026\2\0\0'\4\3\0B\2\2\0023\3\4\0003\4\5\0003\5\6\0003\6\a\0003\a\b\0006\b\t\0009\b\n\b)\t\1\0=\t\v\b6\b\t\0009\b\n\b)\t\1\0=\t\f\b)\b\30\0006\t\0\0'\v\r\0B\t\2\0029\n\14\0005\f\19\0005\r\17\0005\14\15\0004\15\0\0=\15\16\14=\14\18\r=\r\20\f4\r\0\0=\r\21\f5\r\22\0005\14\25\0009\15\23\t9\15\24\15=\15\26\0149\15\23\t9\15\27\15=\15\28\0149\15\23\t9\15\29\15=\15\30\0149\15\23\t9\15\31\15=\15 \14=\14!\r=\r\23\f5\r\"\0005\14#\0005\15$\0=\15!\14=\14%\r5\0147\0005\0156\0005\16(\0009\17&\t9\17'\17=\17)\0169\17&\t9\17*\17=\17+\0169\17&\t9\17,\17=\17-\0169\17&\t9\17.\17=\17/\0169\17&\t9\0170\17=\0171\0169\17&\t9\0172\17=\0173\0169\17&\t9\0174\17=\0175\16=\16&\15=\0158\14=\14!\r=\r9\f5\r:\0004\14\0\0=\14;\r=\r<\f5\r=\0004\14\0\0=\14>\r=\r?\f5\r@\0004\14\0\0=\14A\r=\rB\f5\rC\0=\r&\f5\rD\0005\14E\0005\15F\0005\16H\0005\17G\0=\17I\0165\17J\0=\17K\16=\16L\15=\15M\14=\14N\r=\rO\f5\rP\0=\bQ\r5\14R\0004\15\29\0005\16S\0>\16\1\0155\16T\0=\3U\16>\16\2\0155\16V\0=\5U\16>\16\3\0155\16W\0>\16\4\0155\16X\0=\4U\16>\16\5\0155\16Y\0=\6U\16>\16\6\0155\16Z\0=\aU\16>\16\a\0155\16[\0>\16\b\0155\16\\\0>\16\t\0155\16]\0>\16\n\0155\16^\0>\16\v\0155\16_\0>\16\f\0155\16`\0>\16\r\0155\16a\0>\16\14\0155\16b\0>\16\15\0155\16c\0>\16\16\0155\16d\0>\16\17\0155\16e\0>\16\18\0155\16f\0>\16\19\0155\16g\0>\16\20\0155\16h\0>\16\21\0155\16i\0>\16\22\0155\16j\0>\16\23\0155\16k\0>\16\24\0155\16l\0>\16\25\0155\16m\0>\16\26\0155\16n\0>\16\27\0155\16o\0>\16\28\15=\15p\14=\14q\r=\rr\f5\rs\0=\rt\fB\n\2\0012\0\0�K\0\1\0\ntrash\1\0\2\20require_confirm\2\bcmd\ntrash\tview\rmappings\tlist\1\0\2\vaction\16toggle_help\bkey\6?\1\0\2\vaction\nclose\bkey\6q\1\0\2\vaction\18next_git_item\bkey\a]c\1\0\2\vaction\18prev_git_item\bkey\a[c\1\0\2\vaction\23copy_absolute_path\bkey\agy\1\0\2\vaction\14copy_path\bkey\6Y\1\0\2\vaction\14copy_name\bkey\6y\1\0\2\vaction\npaste\bkey\6p\1\0\2\vaction\tcopy\bkey\6c\1\0\2\vaction\bcut\bkey\6x\1\0\2\vaction\vrename\bkey\6r\1\0\2\vaction\vremove\bkey\6d\1\0\2\vaction\vcreate\bkey\6a\1\0\2\vaction\frefresh\bkey\6R\1\0\2\vaction\20toggle_dotfiles\bkey\6H\1\0\2\vaction\17last_sibling\bkey\6K\1\0\2\vaction\18first_sibling\bkey\6L\1\0\2\vaction\fpreview\bkey\n<Tab>\1\0\2\vaction\16parent_node\bkey\6P\1\0\2\vaction\nsplit\bkey\n<C-x>\1\0\2\vaction\vvsplit\bkey\n<C-v>\1\0\2\vaction\20open_tab_silent\bkey\6T\1\0\2\vaction\fgit_add\bkey\aga\1\0\2\vaction\17collapse_all\bkey\6J\1\0\2\vaction\15close_node\bkey\6j\1\0\2\vaction\vexpand\bkey\aç\14action_cb\1\0\2\vaction\23swap_then_open_tab\bkey\6t\1\0\2\vaction\19edit_no_picker\bkey\6o\1\0\1\16custom_only\2\nwidth\1\0\4\tside\tleft\19relativenumber\1\21hide_root_folder\1\vnumber\1\factions\14open_file\18window_picker\fexclude\fbuftype\1\4\0\0\vnofile\rterminal\thelp\rfiletype\1\0\0\1\a\0\0\vnotify\vpacker\aqf\tdiff\rfugitive\18fugitiveblame\1\0\2\nchars)ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890\venable\2\1\0\2\18resize_window\2\17quit_on_open\1\1\0\1\25use_system_clipboard\2\1\0\3\vignore\2\venable\2\ftimeout\3�\3\ffilters\vcustom\1\0\1\rdotfiles\1\16system_open\targs\1\0\1\bcmd\5\24update_focused_file\16ignore_list\1\0\2\15update_cwd\2\venable\2\rrenderer\vglyphs\1\0\0\1\0\0\fignored\vIgnore\fdeleted\vRemove\14untracked\14Untracked\frenamed\vRename\runmerged\rUnmerged\vstaged\vStaged\runstaged\1\0\0\rUnstaged\bgit\19indent_markers\1\0\4\vcorner\b└\tedge\b│\tnone\6 \titem\b│\1\0\2\18inline_arrows\2\venable\1\1\0\5\17add_trailing\1\16group_empty\2\18highlight_git\2\27highlight_opened_files\tnone\25root_folder_modifier\a:~\nicons\nerror\nError\fwarning\fWarning\tinfo\16Information\thint\1\0\0\tHint\16diagnostics\1\0\2\venable\1\17show_on_dirs\1\23ignore_ft_on_setup\btab\1\0\a\16open_on_tab\1\18hijack_cursor\1'hijack_unnamed_buffer_when_opening\1\20respect_buf_cwd\2\15update_cwd\2\18disable_netrw\1\17hijack_netrw\2\tsync\1\0\0\vignore\1\0\2\topen\2\nclose\2\nsetup\16utils.icons\23loaded_netrwPlugin\17loaded_netrw\6g\bvim\0\0\0\0\0\18nvim-tree.api\18nvim-tree.lib\14nvim-tree\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/opt/nvim-tree.lua",
    url = "https://github.com/nvim-tree/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    config = { "\27LJ\2\n�\n\0\0\a\0003\0;6\0\0\0'\2\1\0B\0\2\0029\1\2\0005\3\4\0005\4\3\0=\4\5\0035\4\6\0=\4\a\0035\4\t\0005\5\b\0=\5\n\0045\5\v\0=\5\f\4=\4\r\0035\4\14\0005\5\15\0=\5\16\4=\4\17\0035\4\18\0=\4\19\0035\4\20\0004\5\0\0=\5\21\4=\4\22\0035\4\23\0005\5\24\0=\5\25\0045\5\26\0=\5\27\4=\4\28\0035\4\29\0=\4\30\0035\4(\0005\5\31\0005\6 \0=\6!\0055\6\"\0=\6#\0055\6$\0=\6%\0055\6&\0=\6'\5=\5)\0045\5*\0005\6+\0=\6\16\5=\5,\0045\5-\0004\6\0\0=\6.\5=\5/\4=\0040\0035\0041\0004\5\0\0=\5\21\4=\0042\3B\1\2\1K\0\1\0\fmatchup\1\0\2\25disable_virtual_text\2\venable\1\16textobjects\tswap\14swap_next\1\0\1\venable\1\vselect\1\0\4\aaf\20@function.outer\aif\20@function.inner\aac\17@class.outer\aic\17@class.inner\1\0\3\venable\2\14lookahead\2#include_surrounding_whitespace\1\tmove\1\0\0\22goto_previous_end\1\0\2\a[]\20@function.outer\a[M\17@class.outer\18goto_next_end\1\0\2\a][\20@function.outer\a]M\17@class.outer\24goto_previous_start\1\0\2\a[[\20@function.outer\a[m\17@class.outer\20goto_next_start\1\0\2\a]]\20@function.outer\a]m\17@class.outer\1\0\2\venable\2\14set_jumps\2\26context_commentstring\1\0\2\venable\2\19enable_autocmd\1\frainbow\15termcolors\1\b\0\0\bRed\nGreen\vYellow\tBlue\fMagenta\tCyan\nWhite\vcolors\1\b\0\0\f#cc241d\f#a89984\f#b16286\f#d79921\f#689d6a\f#d65d0e\f#458588\1\0\2\18extended_mode\2\venable\2\vindent\fdisable\1\0\1\venable\2\14highlight\1\0\2\venable\2\21use_languagetree\2\26incremental_selection\fkeymaps\1\0\2\19init_selection\14<C-space>\21node_incremental\14<C-space>\1\0\1\venable\2\rrefactor\28highlight_current_scope\1\0\1\venable\1\26highlight_definitions\1\0\0\1\0\1\venable\2\fautotag\1\0\1\venable\2\21ensure_installed\1\0\0\1\20\0\0\15javascript\15typescript\truby\btsx\vpython\tdart\tjson\thtml\blua\bcss\tscss\rmarkdown\20markdown_inline\ttoml\tfish\njsdoc\nregex\tyaml\tbash\nsetup\28nvim-treesitter.configs\frequire\0" },
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-treesitter-refactor"] = {
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/nvim-treesitter-refactor",
    url = "https://github.com/nvim-treesitter/nvim-treesitter-refactor"
  },
  ["nvim-treesitter-textobjects"] = {
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/nvim-treesitter-textobjects",
    url = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects"
  },
  ["nvim-treesitter-textsubjects"] = {
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/nvim-treesitter-textsubjects",
    url = "https://github.com/RRethy/nvim-treesitter-textsubjects"
  },
  ["nvim-ts-autotag"] = {
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/nvim-ts-autotag",
    url = "https://github.com/windwp/nvim-ts-autotag"
  },
  ["nvim-ts-context-commentstring"] = {
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/nvim-ts-context-commentstring",
    url = "https://github.com/JoosepAlviste/nvim-ts-context-commentstring"
  },
  ["nvim-ts-rainbow"] = {
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/nvim-ts-rainbow",
    url = "https://github.com/p00f/nvim-ts-rainbow"
  },
  ["nvim-ufo"] = {
    config = { "\27LJ\2\n\127\0\0\5\1\b\0\0176\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\4\0-\4\0\0009\4\5\4B\0\4\0016\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\6\0-\4\0\0009\4\a\4B\0\4\1K\0\1\0\0�\18closeAllFolds\azM\17openAllFolds\azR\6n\bset\vkeymap\bvim�\2\0\5\23\0\v\0I4\5\0\0'\6\0\0\18\b\6\0009\6\1\6!\t\1\2B\6\3\0026\a\2\0009\a\3\a9\a\4\a\18\t\6\0B\a\2\2!\b\a\3)\t\0\0006\n\5\0\18\f\0\0B\n\2\4X\r/�:\15\1\0146\16\2\0009\16\3\0169\16\4\16\18\18\15\0B\16\2\2 \17\16\t\1\17\b\0X\17\6�6\17\6\0009\17\a\17\18\19\5\0\18\20\14\0B\17\3\1X\17\31�\18\17\4\0\18\19\15\0!\20\t\bB\17\3\2\18\15\17\0:\17\2\0146\18\6\0009\18\a\18\18\20\5\0004\21\3\0>\15\1\21>\17\2\21B\18\3\0016\18\2\0009\18\3\0189\18\4\18\18\20\15\0B\18\2\2\18\16\18\0 \18\16\t\1\18\b\0X\18\f�\18\18\6\0'\19\b\0\18\21\19\0009\19\t\19!\22\t\b!\22\16\22B\19\3\2&\6\19\18X\n\3� \t\16\tE\r\3\3R\r�\1276\n\6\0009\n\a\n\18\f\5\0005\r\n\0>\6\1\rB\n\3\1L\5\2\0\1\3\0\0\0\fMoreMsg\brep\6 \vinsert\ntable\vipairs\20strdisplaywidth\afn\bvim\vformat\r  %d �\1\0\3\a\0\t\0\0266\3\0\0\18\5\1\0B\3\2\2\a\3\1\0X\3\14�\18\5\1\0009\3\2\1'\6\3\0B\3\3\2\15\0\3\0X\4\b�6\3\4\0'\5\5\0B\3\2\0029\3\6\3\18\5\0\0\18\6\2\0D\3\3\0X\3\6�6\3\4\0'\5\a\0B\3\2\0029\3\b\3\18\5\1\0D\3\2\0K\0\1\0\vreject\fpromise\rgetFolds\bufo\frequire\25UfoFallbackException\nmatch\vstring\ttype*\0\1\6\2\1\0\5-\1\0\0-\3\1\0\18\4\0\0'\5\0\0D\1\4\0\0\0\0�\15treesitter&\0\1\6\2\1\0\5-\1\0\0-\3\1\0\18\4\0\0'\5\0\0D\1\4\0\0\0\0�\vindentj\1\1\5\1\a\0\0166\1\0\0'\3\1\0B\1\2\0029\1\2\1\18\3\0\0'\4\3\0B\1\3\2\18\3\1\0009\1\4\0013\4\5\0B\1\3\2\18\3\1\0009\1\4\0013\4\6\0002\0\0�D\1\3\0\3�\0\0\ncatch\blsp\rgetFolds\bufo\frequire@\1\3\5\0\5\0\n3\3\0\0\6\1\1\0X\4\2�\a\2\2\0X\4\2�'\4\3\0X\5\1�3\4\4\0002\0\0�L\4\2\0\0\vindent\vnofile\5\0�\1\1\0\a\0\14\0\0276\0\0\0'\2\1\0B\0\2\0023\1\2\0003\2\3\0006\3\4\0009\3\5\3)\4c\0=\4\6\0036\3\4\0009\3\5\3)\4c\0=\4\a\0036\3\4\0009\3\5\3+\4\2\0=\4\b\3\18\3\1\0B\3\1\0019\3\t\0005\5\n\0=\2\v\0053\6\f\0=\6\r\5B\3\2\0012\0\0�K\0\1\0\22provider_selector\0\27fold_virt_text_handler\1\0\0\nsetup\15foldenable\19foldlevelstart\14foldlevel\6o\bvim\0\0\bufo\frequire\0" },
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/nvim-ufo",
    url = "https://github.com/kevinhwang91/nvim-ufo"
  },
  ["nvim-web-devicons"] = {
    config = { "\27LJ\2\n`\0\0\4\0\5\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0004\3\0\0=\3\4\2B\0\2\1K\0\1\0\roverride\1\0\1\fdefault\2\nsetup\22nvim-web-devicons\frequire\0" },
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
    url = "https://github.com/nvim-tree/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["prettier.nvim"] = {
    config = { "\27LJ\2\n\15\0\0\1\0\0\0\2+\0\2\0L\0\2\0\15\0\1\2\0\0\0\2+\1\2\0L\1\2\0�\4\1\0\5\0\14\0\0176\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\0025\3\6\0=\3\a\0025\3\t\0003\4\b\0=\4\n\0033\4\v\0=\4\f\3=\3\r\2B\0\2\1K\0\1\0\fnull-ls\22runtime_condition\0\14condition\1\0\1\ftimeout\3�'\0\14filetypes\1\r\0\0\bcss\fgraphql\thtml\15javascript\20javascriptreact\tjson\tless\rmarkdown\tscss\15typescript\20typescriptreact\tyaml\16cli_options\1\0\17 html_whitespace_sensitivity\bcss\21jsx_single_quote\1\16print_width\3P\15prose_wrap\rpreserve vue_indent_script_and_style\1\16quote_props\14as-needed\tsemi\2\30single_attribute_per_line\1\17single_quote\2\19trailing_comma\bes5\ruse_tabs\1\17arrow_parens\valways\20bracket_spacing\2\22bracket_same_line\1!embedded_language_formatting\tauto\16end_of_line\alf\14tab_width\3\2\1\0\1\bbin\14prettierd\nsetup\rprettier\frequire\0" },
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/prettier.nvim",
    url = "https://github.com/MunifTanjim/prettier.nvim"
  },
  ["promise-async"] = {
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/promise-async",
    url = "https://github.com/kevinhwang91/promise-async"
  },
  ["schemastore.nvim"] = {
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/schemastore.nvim",
    url = "https://github.com/b0o/schemastore.nvim"
  },
  ["stay-in-place.nvim"] = {
    config = { "\27LJ\2\nO\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\16set_keymaps\1\nsetup\18stay-in-place\frequire\0" },
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/stay-in-place.nvim",
    url = "https://github.com/gbprod/stay-in-place.nvim"
  },
  ["tabhula.nvim"] = {
    config = { "\27LJ\2\n\15\0\1\2\0\0\0\2)\1\1\0L\1\2\0�\2\1\0\5\0\21\0$3\0\0\0006\1\1\0'\3\2\0B\1\2\0029\1\3\0015\3\4\0005\4\5\0=\0\6\4=\0\a\4=\0\b\4=\0\t\4=\0\n\4=\0\v\4=\0\f\4=\0\r\4=\0\14\4=\0\15\4=\0\16\4=\0\17\4=\4\18\0035\4\19\0=\0\6\4=\0\a\4=\0\b\4=\0\t\4=\0\n\4=\0\v\4=\0\f\4=\0\r\4=\0\14\4=\0\15\4=\0\16\4=\0\17\4=\4\20\3B\1\2\1K\0\1\0\24backward_characters\1\0\0\23forward_characters\6`\6'\6\"\6;\6.\6,\6{\6}\6[\6]\6(\6)\1\0\0\1\0\4\vtabkey\n<Tab>\25evil_backward_tabkey\5\16evil_tabkey\5\20backward_tabkey\f<S-Tab>\nsetup\ftabhula\frequire\0\0" },
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/tabhula.nvim",
    url = "https://github.com/lilibyte/tabhula.nvim"
  },
  ["targets.vim"] = {
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/targets.vim",
    url = "https://github.com/wellle/targets.vim"
  },
  ["telescope-fzf-native.nvim"] = {
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/telescope-fzf-native.nvim",
    url = "https://github.com/nvim-telescope/telescope-fzf-native.nvim"
  },
  ["telescope.nvim"] = {
    config = { "\27LJ\2\n�\n\0\0\t\0005\0N6\0\0\0'\2\1\0B\0\2\0029\1\2\0'\3\3\0B\1\2\0016\1\0\0'\3\4\0B\1\2\0025\2\a\0009\3\5\0019\3\6\3=\3\b\0029\3\5\0019\3\t\3=\3\n\0029\3\5\0019\3\v\3=\3\f\0029\3\5\0019\3\r\3=\3\14\0029\3\5\0019\3\15\3=\3\16\0029\3\5\0019\3\17\3=\3\18\0029\3\19\0005\5\29\0005\6\21\0005\a\20\0=\a\22\0065\a\24\0005\b\23\0=\b\25\a5\b\26\0=\b\27\a=\a\28\6=\6\30\0054\6\0\0=\6\31\0055\6!\0005\a \0=\a\3\6=\6\"\0055\6#\0=\6$\0055\6&\0005\a%\0=\a'\6=\6(\0056\6\0\0'\b)\0B\6\2\0029\6*\6=\6+\5=\2,\0056\6\0\0'\b-\0B\6\2\0029\6.\0069\6/\6=\0060\0056\6\0\0'\b-\0B\6\2\0029\0061\0069\6/\6=\0062\0056\6\0\0'\b-\0B\6\2\0029\0063\0069\6/\6=\0064\5B\3\2\1K\0\1\0\21qflist_previewer\22vim_buffer_qflist\19grep_previewer\23vim_buffer_vimgrep\19file_previewer\bnew\19vim_buffer_cat\25telescope.previewers\14git_icons\16file_sorter\19get_fzy_sorter\22telescope.sorters\18layout_config\15horizontal\1\0\1\20prompt_position\btop\1\0\1\19preview_cutoff\3x\22vimgrep_arguments\1\b\0\0\arg\18--color=never\17--no-heading\20--with-filename\18--line-number\r--column\17--smart-case\15extensions\1\0\0\1\0\3\14case_mode\15smart_case\25override_file_sorter\2\28override_generic_sorter\1\fpickers\rdefaults\1\0\3\21sorting_strategy\14ascending\19color_devicons\2\18prompt_prefix\n  \rmappings\6n\1\0\a\6l\28move_selection_previous\n<C-l>\28move_selection_previous\n<C-k>\24move_selection_next\6v\20select_vertical\n<C-c>\nclose\6t\15select_tab\6k\24move_selection_next\6i\1\0\0\1\0\5\n<C-c>\nclose\n<C-l>\28move_selection_previous\n<C-k>\24move_selection_next\t<CR>\19select_default\n<C-h>\14which_key\25file_ignore_patterns\1\0\0\1\3\0\0\17node_modules\n.venv\nsetup\14untracked\14Untracked\runmerged\rUnmerged\frenamed\vRename\fdeleted\vRemove\fchanged\bMod\nadded\1\0\1\vcopied\6>\bAdd\bgit\16utils.icons\bfzf\19load_extension\14telescope\frequire\0" },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/opt/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["template-string.nvim"] = {
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/template-string.nvim",
    url = "https://github.com/axelvc/template-string.nvim"
  },
  ["toggleterm.nvim"] = {
    commands = { "ToggleTerm", "TermExec", "TermOpen" },
    config = { "\27LJ\2\n�\1\0\1\2\0\a\2\0189\1\0\0\a\1\1\0X\1\6�6\1\2\0009\1\3\0019\1\4\1\24\1\0\1L\1\2\0X\1\b�9\1\0\0\a\1\5\0X\1\5�6\1\2\0009\1\3\0019\1\6\1\24\1\1\1L\1\2\0K\0\1\0\fcolumns\rvertical\nlines\6o\bvim\15horizontal\14direction�̙�\6����\3\1����\3�\2\0\1\6\0\r\0\"9\1\0\0\a\1\1\0X\1\30�6\1\2\0006\3\3\0'\4\4\0B\1\3\3\15\0\1\0X\3\24�9\3\5\2B\3\1\2\15\0\3\0X\4\20�6\3\6\0009\3\a\3'\5\b\0B\3\2\0016\3\6\0009\3\a\3'\5\t\0B\3\2\0016\3\6\0009\3\a\3'\5\n\0B\3\2\0016\3\6\0009\3\a\3'\5\v\0B\3\2\0016\3\6\0009\3\a\3'\5\f\0B\3\2\1K\0\1\0\rwincmd j\rwincmd l\17NvimTreeOpen\18NvimTreeClose\15stopinsert\bcmd\bvim\15is_visible\19nvim-tree.view\frequire\npcall\15horizontal\14direction�\3\1\0\a\0\22\1!6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0003\3\3\0=\3\5\0024\3\0\0=\3\6\0023\3\a\0=\3\b\0026\3\t\0009\3\n\0039\3\v\3=\3\v\0025\3\f\0006\4\r\0009\4\14\0046\6\t\0009\6\n\0069\6\15\6\24\6\0\6B\4\2\2=\4\16\0035\4\17\0=\4\18\3=\3\19\0025\3\20\0004\4\0\0=\4\21\3=\3\18\2B\0\2\1K\0\1\0\vNormal\1\0\0\15float_opts\15highlights\1\0\2\15background\vNormal\vborder\vNormal\nwidth\fcolumns\nfloor\tmath\1\0\3\vborder\vcurved\rwinblend\3\0\vheight\3\15\nshell\6o\bvim\fon_open\0\20shade_filetypes\tsize\1\0\t\19shading_factor\0060\20start_in_insert\2\20insert_mappings\1\17persist_size\1\18close_on_exit\2\17open_mapping\n<c-x>\17hide_numbers\2\20shade_terminals\1\14direction\15horizontal\0\nsetup\15toggleterm\frequire����\25̙��\3\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/opt/toggleterm.nvim",
    url = "https://github.com/akinsho/toggleterm.nvim"
  },
  ["tokyonight.nvim"] = {
    config = { "\27LJ\2\n\v\0\1\1\0\0\0\1K\0\1\0V\0\2\5\0\6\0\b6\2\0\0'\4\1\0B\2\2\0025\3\4\0009\4\3\2=\4\5\3=\3\2\0K\0\1\0\abg\1\0\0\fdark_bg\16NormalFloat\17utils.colors\frequire�\3\1\0\5\0\r\0\0176\0\0\0'\2\1\0B\0\2\0029\1\2\0005\3\3\0005\4\4\0=\4\5\0033\4\6\0=\4\a\0033\4\b\0=\4\t\3B\1\2\0016\1\n\0009\1\v\1'\3\f\0B\1\2\1K\0\1\0\27colorscheme tokyonight\bcmd\bvim\18on_highlights\0\14on_colors\0\vstyles\1\0\6\rsidebars\16transparent\rkeywords\vitalic\vfloats\16transparent\rcomments\vitalic\14variables\tNONE\14functions\tbold\1\0\a\17lualine_bold\1\17dim_inactive\1\29hide_inactive_statusline\1\19day_brightness\4��̙\3����\3\16transparent\2\nstyle\nnight\20terminal_colors\1\nsetup\15tokyonight\frequire\0" },
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/tokyonight.nvim",
    url = "https://github.com/folke/tokyonight.nvim"
  },
  ["typescript.nvim"] = {
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/typescript.nvim",
    url = "https://github.com/jose-elias-alvarez/typescript.nvim"
  },
  ["undoquit.vim"] = {
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/undoquit.vim",
    url = "https://github.com/AndrewRadev/undoquit.vim"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/vim-fugitive",
    url = "https://github.com/tpope/vim-fugitive"
  },
  ["vim-illuminate"] = {
    config = { "\27LJ\2\n�\2\0\0\4\0\14\0\0236\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0024\3\0\0=\3\6\0025\3\a\0=\3\b\0024\3\0\0=\3\t\0024\3\0\0=\3\n\0024\3\0\0=\3\v\0024\3\0\0=\3\f\0024\3\0\0=\3\r\2B\0\2\1K\0\1\0%providers_regex_syntax_allowlist$providers_regex_syntax_denylist\20modes_allowlist\19modes_denylist\24filetypes_allowlist\23filetypes_denylist\1\3\0\0\fdirvish\rfugitive\23filetype_overrides\14providers\1\0\3\ndelay\3�\2\17under_cursor\2\27min_count_to_highlight\3\1\1\2\0\0\nregex\14configure\15illuminate\frequire\0" },
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/vim-illuminate",
    url = "https://github.com/RRethy/vim-illuminate"
  },
  ["vim-repeat"] = {
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/vim-repeat",
    url = "https://github.com/tpope/vim-repeat"
  },
  ["vim-sleuth"] = {
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/vim-sleuth",
    url = "https://github.com/tpope/vim-sleuth"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/vim-surround",
    url = "https://github.com/tpope/vim-surround"
  },
  ["vim-wordmotion"] = {
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/vim-wordmotion",
    url = "https://github.com/chaoren/vim-wordmotion"
  }
}

time([[Defining packer_plugins]], false)
local module_lazy_loads = {
  ["^toggleterm"] = "toggleterm.nvim",
  ["^toggleterm%.terminal"] = "toggleterm.nvim"
}
local lazy_load_called = {['packer.load'] = true}
local function lazy_load_module(module_name)
  local to_load = {}
  if lazy_load_called[module_name] then return nil end
  lazy_load_called[module_name] = true
  for module_pat, plugin_name in pairs(module_lazy_loads) do
    if not _G.packer_plugins[plugin_name].loaded and string.match(module_name, module_pat) then
      to_load[#to_load + 1] = plugin_name
    end
  end

  if #to_load > 0 then
    require('packer.load')(to_load, {module = module_name}, _G.packer_plugins)
    local loaded_mod = package.loaded[module_name]
    if loaded_mod then
      return function(modname) return loaded_mod end
    end
  end
end

if not vim.g.packer_custom_loader_enabled then
  table.insert(package.loaders, 1, lazy_load_module)
  vim.g.packer_custom_loader_enabled = true
end

-- Config for: mason.nvim
time([[Config for mason.nvim]], true)
try_loadstring("\27LJ\2\n�\1\0\1\t\2\b\0\23-\1\0\0009\1\0\0016\2\1\0006\4\2\0'\5\3\0\18\6\0\0&\5\6\5B\2\3\3\15\0\2\0X\4\a�6\4\4\0009\4\5\4'\6\6\0\18\a\1\0\18\b\3\0B\4\4\2\18\1\4\0-\4\1\0008\4\0\0049\4\a\4\18\6\1\0B\4\2\1K\0\1\0\4�\1�\nsetup\nforce\15tbl_extend\bvim\24config.lsp.servers.\frequire\npcall\19default_config4\0\0\3\2\2\0\a-\0\0\0009\0\0\0B\0\1\1-\0\1\0'\2\1\0B\0\2\1K\0\1\0\2�\6�\vlua_ls\nsetup�\3\1\0\v\0\22\0,6\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0026\2\0\0'\4\3\0B\2\2\0026\3\0\0'\5\4\0B\3\2\0026\4\0\0'\6\5\0B\4\2\0026\5\0\0'\a\6\0B\5\2\0029\6\a\0005\b\v\0005\t\b\0005\n\t\0=\n\n\t=\t\f\bB\6\2\0019\6\a\0055\b\r\0004\t\0\0=\t\14\bB\6\2\0019\6\a\0035\b\16\0009\t\15\4=\t\14\bB\6\2\0013\6\17\0009\a\18\0035\t\20\0>\6\1\t3\n\19\0=\n\21\tB\a\2\0012\0\0�K\0\1\0\vlua_ls\1\0\0\0\19setup_handlers\0\1\0\1\27automatic_installation\2\fservers\21ensure_installed\1\0\1\20automatic_setup\2\aui\1\0\0\nicons\1\0\3\24package_uninstalled\b✗\20package_pending\b⟳\22package_installed\b✓\1\0\1\vborder\frounded\nsetup\18mason-null-ls\15config.lsp\20mason-lspconfig\vneodev\14lspconfig\nmason\frequire\0", "config", "mason.nvim")
time([[Config for mason.nvim]], false)
-- Config for: nvim-web-devicons
time([[Config for nvim-web-devicons]], true)
try_loadstring("\27LJ\2\n`\0\0\4\0\5\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0004\3\0\0=\3\4\2B\0\2\1K\0\1\0\roverride\1\0\1\fdefault\2\nsetup\22nvim-web-devicons\frequire\0", "config", "nvim-web-devicons")
time([[Config for nvim-web-devicons]], false)
-- Config for: stay-in-place.nvim
time([[Config for stay-in-place.nvim]], true)
try_loadstring("\27LJ\2\nO\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\16set_keymaps\1\nsetup\18stay-in-place\frequire\0", "config", "stay-in-place.nvim")
time([[Config for stay-in-place.nvim]], false)
-- Config for: vim-illuminate
time([[Config for vim-illuminate]], true)
try_loadstring("\27LJ\2\n�\2\0\0\4\0\14\0\0236\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0024\3\0\0=\3\6\0025\3\a\0=\3\b\0024\3\0\0=\3\t\0024\3\0\0=\3\n\0024\3\0\0=\3\v\0024\3\0\0=\3\f\0024\3\0\0=\3\r\2B\0\2\1K\0\1\0%providers_regex_syntax_allowlist$providers_regex_syntax_denylist\20modes_allowlist\19modes_denylist\24filetypes_allowlist\23filetypes_denylist\1\3\0\0\fdirvish\rfugitive\23filetype_overrides\14providers\1\0\3\ndelay\3�\2\17under_cursor\2\27min_count_to_highlight\3\1\1\2\0\0\nregex\14configure\15illuminate\frequire\0", "config", "vim-illuminate")
time([[Config for vim-illuminate]], false)
-- Config for: flutter-tools.nvim
time([[Config for flutter-tools.nvim]], true)
try_loadstring("\27LJ\2\n_\0\0\5\0\6\0\v6\0\0\0'\2\1\0B\0\2\0029\1\2\0005\3\3\0004\4\0\0=\4\4\0034\4\0\0=\4\5\3B\1\2\1K\0\1\0\blsp\rdebugger\1\0\0\nsetup\18flutter-tools\frequire\0", "config", "flutter-tools.nvim")
time([[Config for flutter-tools.nvim]], false)
-- Config for: nvim-treesitter
time([[Config for nvim-treesitter]], true)
try_loadstring("\27LJ\2\n�\n\0\0\a\0003\0;6\0\0\0'\2\1\0B\0\2\0029\1\2\0005\3\4\0005\4\3\0=\4\5\0035\4\6\0=\4\a\0035\4\t\0005\5\b\0=\5\n\0045\5\v\0=\5\f\4=\4\r\0035\4\14\0005\5\15\0=\5\16\4=\4\17\0035\4\18\0=\4\19\0035\4\20\0004\5\0\0=\5\21\4=\4\22\0035\4\23\0005\5\24\0=\5\25\0045\5\26\0=\5\27\4=\4\28\0035\4\29\0=\4\30\0035\4(\0005\5\31\0005\6 \0=\6!\0055\6\"\0=\6#\0055\6$\0=\6%\0055\6&\0=\6'\5=\5)\0045\5*\0005\6+\0=\6\16\5=\5,\0045\5-\0004\6\0\0=\6.\5=\5/\4=\0040\0035\0041\0004\5\0\0=\5\21\4=\0042\3B\1\2\1K\0\1\0\fmatchup\1\0\2\25disable_virtual_text\2\venable\1\16textobjects\tswap\14swap_next\1\0\1\venable\1\vselect\1\0\4\aaf\20@function.outer\aif\20@function.inner\aac\17@class.outer\aic\17@class.inner\1\0\3\venable\2\14lookahead\2#include_surrounding_whitespace\1\tmove\1\0\0\22goto_previous_end\1\0\2\a[]\20@function.outer\a[M\17@class.outer\18goto_next_end\1\0\2\a][\20@function.outer\a]M\17@class.outer\24goto_previous_start\1\0\2\a[[\20@function.outer\a[m\17@class.outer\20goto_next_start\1\0\2\a]]\20@function.outer\a]m\17@class.outer\1\0\2\venable\2\14set_jumps\2\26context_commentstring\1\0\2\venable\2\19enable_autocmd\1\frainbow\15termcolors\1\b\0\0\bRed\nGreen\vYellow\tBlue\fMagenta\tCyan\nWhite\vcolors\1\b\0\0\f#cc241d\f#a89984\f#b16286\f#d79921\f#689d6a\f#d65d0e\f#458588\1\0\2\18extended_mode\2\venable\2\vindent\fdisable\1\0\1\venable\2\14highlight\1\0\2\venable\2\21use_languagetree\2\26incremental_selection\fkeymaps\1\0\2\19init_selection\14<C-space>\21node_incremental\14<C-space>\1\0\1\venable\2\rrefactor\28highlight_current_scope\1\0\1\venable\1\26highlight_definitions\1\0\0\1\0\1\venable\2\fautotag\1\0\1\venable\2\21ensure_installed\1\0\0\1\20\0\0\15javascript\15typescript\truby\btsx\vpython\tdart\tjson\thtml\blua\bcss\tscss\rmarkdown\20markdown_inline\ttoml\tfish\njsdoc\nregex\tyaml\tbash\nsetup\28nvim-treesitter.configs\frequire\0", "config", "nvim-treesitter")
time([[Config for nvim-treesitter]], false)
-- Config for: prettier.nvim
time([[Config for prettier.nvim]], true)
try_loadstring("\27LJ\2\n\15\0\0\1\0\0\0\2+\0\2\0L\0\2\0\15\0\1\2\0\0\0\2+\1\2\0L\1\2\0�\4\1\0\5\0\14\0\0176\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\0025\3\6\0=\3\a\0025\3\t\0003\4\b\0=\4\n\0033\4\v\0=\4\f\3=\3\r\2B\0\2\1K\0\1\0\fnull-ls\22runtime_condition\0\14condition\1\0\1\ftimeout\3�'\0\14filetypes\1\r\0\0\bcss\fgraphql\thtml\15javascript\20javascriptreact\tjson\tless\rmarkdown\tscss\15typescript\20typescriptreact\tyaml\16cli_options\1\0\17 html_whitespace_sensitivity\bcss\21jsx_single_quote\1\16print_width\3P\15prose_wrap\rpreserve vue_indent_script_and_style\1\16quote_props\14as-needed\tsemi\2\30single_attribute_per_line\1\17single_quote\2\19trailing_comma\bes5\ruse_tabs\1\17arrow_parens\valways\20bracket_spacing\2\22bracket_same_line\1!embedded_language_formatting\tauto\16end_of_line\alf\14tab_width\3\2\1\0\1\bbin\14prettierd\nsetup\rprettier\frequire\0", "config", "prettier.nvim")
time([[Config for prettier.nvim]], false)
-- Config for: tokyonight.nvim
time([[Config for tokyonight.nvim]], true)
try_loadstring("\27LJ\2\n\v\0\1\1\0\0\0\1K\0\1\0V\0\2\5\0\6\0\b6\2\0\0'\4\1\0B\2\2\0025\3\4\0009\4\3\2=\4\5\3=\3\2\0K\0\1\0\abg\1\0\0\fdark_bg\16NormalFloat\17utils.colors\frequire�\3\1\0\5\0\r\0\0176\0\0\0'\2\1\0B\0\2\0029\1\2\0005\3\3\0005\4\4\0=\4\5\0033\4\6\0=\4\a\0033\4\b\0=\4\t\3B\1\2\0016\1\n\0009\1\v\1'\3\f\0B\1\2\1K\0\1\0\27colorscheme tokyonight\bcmd\bvim\18on_highlights\0\14on_colors\0\vstyles\1\0\6\rsidebars\16transparent\rkeywords\vitalic\vfloats\16transparent\rcomments\vitalic\14variables\tNONE\14functions\tbold\1\0\a\17lualine_bold\1\17dim_inactive\1\29hide_inactive_statusline\1\19day_brightness\4��̙\3����\3\16transparent\2\nstyle\nnight\20terminal_colors\1\nsetup\15tokyonight\frequire\0", "config", "tokyonight.nvim")
time([[Config for tokyonight.nvim]], false)
-- Config for: null-ls.nvim
time([[Config for null-ls.nvim]], true)
try_loadstring("\27LJ\2\nl\0\0\5\0\b\0\f6\0\0\0009\0\1\0009\0\2\0009\0\3\0005\2\6\0006\3\0\0009\3\4\0039\3\5\3B\3\1\2=\3\a\2B\0\2\1K\0\1\0\nbufnr\1\0\0\25nvim_get_current_buf\bapi\vformat\bbuf\blsp\bvimV\1\2\b\0\b\0\n6\2\0\0009\2\1\0029\2\2\2'\4\3\0'\5\4\0003\6\5\0005\a\6\0=\1\a\aB\2\5\1K\0\1\0\vbuffer\1\0\0\0\15<Leader>ff\6n\bset\vkeymap\bvim�\3\1\0\t\0\21\1)6\0\0\0'\2\1\0B\0\2\0029\1\2\0009\2\3\0005\4\17\0004\5\n\0009\6\4\0019\6\5\6>\6\1\0059\6\4\0019\6\6\6>\6\2\0059\6\4\0019\6\a\6>\6\3\0059\6\4\0019\6\b\6>\6\4\0059\6\t\0019\6\n\6>\6\5\0059\6\v\0019\6\f\6>\6\6\0059\6\r\0019\6\14\6>\6\a\0059\6\2\0009\6\r\0069\6\15\6>\6\b\0056\6\0\0'\b\16\0B\6\2\0?\6\0\0=\5\18\0043\5\19\0=\5\20\4B\2\2\1K\0\1\0\14on_attach\0\fsources\1\0\0/typescript.extensions.null-ls.code-actions\rgitsigns\reslint_d\17code_actions\fluasnip\15completion\veslint\16diagnostics\ffixjson\14prettierd\nblack\vstylua\15formatting\nsetup\rbuiltins\fnull-ls\frequire\19����\4\0", "config", "null-ls.nvim")
time([[Config for null-ls.nvim]], false)
-- Config for: Comment.nvim
time([[Config for Comment.nvim]], true)
try_loadstring("\27LJ\2\n�\2\0\0\6\0\f\0\0216\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0004\3\0\0=\3\4\0024\3\0\0=\3\5\0024\3\0\0=\3\6\0025\3\a\0=\3\b\0026\3\0\0'\5\t\0B\3\2\0029\3\n\3B\3\1\2=\3\v\2B\0\2\1K\0\1\0\rpre_hook\20create_pre_hook7ts_context_commentstring.integrations.comment_nvim\rmappings\1\0\2\nbasic\2\nextra\2\nextra\ropleader\ftoggler\1\0\2\vsticky\2\fpadding\2\nsetup\fComment\frequire\0", "config", "Comment.nvim")
time([[Config for Comment.nvim]], false)
-- Config for: comment-box.nvim
time([[Config for comment-box.nvim]], true)
try_loadstring("\27LJ\2\n�\2\0\0\4\0\b\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\0025\3\6\0=\3\a\2B\0\2\1K\0\1\0\tline\1\0\3\rline_end\b─\15line_start\b─\tline\b─\fborders\1\0\b\nright\b│\17bottom_right\b╯\16bottom_left\b╰\rtop_left\b╭\vbottom\b─\14top_right\b╮\tleft\b│\btop\b─\1\0\a\15line_width\3F\22outer_blank_lines\1\22inner_blank_lines\1\26line_blank_line_above\1\26line_blank_line_below\1\14doc_width\3P\14box_width\3<\nsetup\16comment-box\frequire\0", "config", "comment-box.nvim")
time([[Config for comment-box.nvim]], false)
-- Config for: tabhula.nvim
time([[Config for tabhula.nvim]], true)
try_loadstring("\27LJ\2\n\15\0\1\2\0\0\0\2)\1\1\0L\1\2\0�\2\1\0\5\0\21\0$3\0\0\0006\1\1\0'\3\2\0B\1\2\0029\1\3\0015\3\4\0005\4\5\0=\0\6\4=\0\a\4=\0\b\4=\0\t\4=\0\n\4=\0\v\4=\0\f\4=\0\r\4=\0\14\4=\0\15\4=\0\16\4=\0\17\4=\4\18\0035\4\19\0=\0\6\4=\0\a\4=\0\b\4=\0\t\4=\0\n\4=\0\v\4=\0\f\4=\0\r\4=\0\14\4=\0\15\4=\0\16\4=\0\17\4=\4\20\3B\1\2\1K\0\1\0\24backward_characters\1\0\0\23forward_characters\6`\6'\6\"\6;\6.\6,\6{\6}\6[\6]\6(\6)\1\0\0\1\0\4\vtabkey\n<Tab>\25evil_backward_tabkey\5\16evil_tabkey\5\20backward_tabkey\f<S-Tab>\nsetup\ftabhula\frequire\0\0", "config", "tabhula.nvim")
time([[Config for tabhula.nvim]], false)
-- Config for: nvim-ufo
time([[Config for nvim-ufo]], true)
try_loadstring("\27LJ\2\n\127\0\0\5\1\b\0\0176\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\4\0-\4\0\0009\4\5\4B\0\4\0016\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\6\0-\4\0\0009\4\a\4B\0\4\1K\0\1\0\0�\18closeAllFolds\azM\17openAllFolds\azR\6n\bset\vkeymap\bvim�\2\0\5\23\0\v\0I4\5\0\0'\6\0\0\18\b\6\0009\6\1\6!\t\1\2B\6\3\0026\a\2\0009\a\3\a9\a\4\a\18\t\6\0B\a\2\2!\b\a\3)\t\0\0006\n\5\0\18\f\0\0B\n\2\4X\r/�:\15\1\0146\16\2\0009\16\3\0169\16\4\16\18\18\15\0B\16\2\2 \17\16\t\1\17\b\0X\17\6�6\17\6\0009\17\a\17\18\19\5\0\18\20\14\0B\17\3\1X\17\31�\18\17\4\0\18\19\15\0!\20\t\bB\17\3\2\18\15\17\0:\17\2\0146\18\6\0009\18\a\18\18\20\5\0004\21\3\0>\15\1\21>\17\2\21B\18\3\0016\18\2\0009\18\3\0189\18\4\18\18\20\15\0B\18\2\2\18\16\18\0 \18\16\t\1\18\b\0X\18\f�\18\18\6\0'\19\b\0\18\21\19\0009\19\t\19!\22\t\b!\22\16\22B\19\3\2&\6\19\18X\n\3� \t\16\tE\r\3\3R\r�\1276\n\6\0009\n\a\n\18\f\5\0005\r\n\0>\6\1\rB\n\3\1L\5\2\0\1\3\0\0\0\fMoreMsg\brep\6 \vinsert\ntable\vipairs\20strdisplaywidth\afn\bvim\vformat\r  %d �\1\0\3\a\0\t\0\0266\3\0\0\18\5\1\0B\3\2\2\a\3\1\0X\3\14�\18\5\1\0009\3\2\1'\6\3\0B\3\3\2\15\0\3\0X\4\b�6\3\4\0'\5\5\0B\3\2\0029\3\6\3\18\5\0\0\18\6\2\0D\3\3\0X\3\6�6\3\4\0'\5\a\0B\3\2\0029\3\b\3\18\5\1\0D\3\2\0K\0\1\0\vreject\fpromise\rgetFolds\bufo\frequire\25UfoFallbackException\nmatch\vstring\ttype*\0\1\6\2\1\0\5-\1\0\0-\3\1\0\18\4\0\0'\5\0\0D\1\4\0\0\0\0�\15treesitter&\0\1\6\2\1\0\5-\1\0\0-\3\1\0\18\4\0\0'\5\0\0D\1\4\0\0\0\0�\vindentj\1\1\5\1\a\0\0166\1\0\0'\3\1\0B\1\2\0029\1\2\1\18\3\0\0'\4\3\0B\1\3\2\18\3\1\0009\1\4\0013\4\5\0B\1\3\2\18\3\1\0009\1\4\0013\4\6\0002\0\0�D\1\3\0\3�\0\0\ncatch\blsp\rgetFolds\bufo\frequire@\1\3\5\0\5\0\n3\3\0\0\6\1\1\0X\4\2�\a\2\2\0X\4\2�'\4\3\0X\5\1�3\4\4\0002\0\0�L\4\2\0\0\vindent\vnofile\5\0�\1\1\0\a\0\14\0\0276\0\0\0'\2\1\0B\0\2\0023\1\2\0003\2\3\0006\3\4\0009\3\5\3)\4c\0=\4\6\0036\3\4\0009\3\5\3)\4c\0=\4\a\0036\3\4\0009\3\5\3+\4\2\0=\4\b\3\18\3\1\0B\3\1\0019\3\t\0005\5\n\0=\2\v\0053\6\f\0=\6\r\5B\3\2\0012\0\0�K\0\1\0\22provider_selector\0\27fold_virt_text_handler\1\0\0\nsetup\15foldenable\19foldlevelstart\14foldlevel\6o\bvim\0\0\bufo\frequire\0", "config", "nvim-ufo")
time([[Config for nvim-ufo]], false)
-- Config for: lsp-colors.nvim
time([[Config for lsp-colors.nvim]], true)
try_loadstring("\27LJ\2\n~\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\4\nError\f#db4b4b\16Information\f#0db9d7\fWarning\f#e0af68\tHint\f#10B981\nsetup\15lsp-colors\frequire\0", "config", "lsp-colors.nvim")
time([[Config for lsp-colors.nvim]], false)
-- Config for: hlargs.nvim
time([[Config for hlargs.nvim]], true)
try_loadstring("\27LJ\2\n�\2\0\2\v\0\r\0'6\2\0\0009\2\1\0029\2\2\2\15\0\2\0X\3\2�+\2\2\0L\2\2\0006\2\0\0009\2\3\0029\2\4\0025\4\5\0=\1\6\4B\2\2\0026\3\a\0\18\5\2\0B\3\2\4H\6\19�9\b\b\a9\t\t\a\6\t\n\0X\t\15�9\t\v\b\15\0\t\0X\n\f�9\t\v\b9\t\f\t\15\0\t\0X\n\b�6\t\0\0009\t\1\t+\n\2\0=\n\2\t6\t\0\0009\t\1\t9\t\2\tL\t\2\0F\6\3\3R\6�\127K\0\1\0\tfull\27semanticTokensProvider\fnull-ls\tname\24server_capabilities\npairs\nbufnr\1\0\0\23get_active_clients\blsp\20semantic_tokens\6b\bvim�\3\1\0\5\0\21\0'6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0004\3\15\0005\4\4\0>\4\1\0035\4\5\0>\4\2\0035\4\6\0>\4\3\0035\4\a\0>\4\4\0035\4\b\0>\4\5\0035\4\t\0>\4\6\0035\4\n\0>\4\a\0035\4\v\0>\4\b\0035\4\f\0>\4\t\0035\4\r\0>\4\n\0035\4\14\0>\4\v\0035\4\15\0>\4\f\0035\4\16\0>\4\r\0035\4\17\0>\4\14\3=\3\18\0023\3\19\0=\3\20\2B\0\2\1K\0\1\0\fdisable\0\17colorpalette\1\0\1\afg\f#8FB272\1\0\1\afg\f#EEF06D\1\0\1\afg\f#BBEA87\1\0\1\afg\f#DE9A4E\1\0\1\afg\f#F67C1B\1\0\1\afg\f#F6B223\1\0\1\afg\f#7FEC35\1\0\1\afg\f#D49DA5\1\0\1\afg\f#8997F5\1\0\1\afg\f#E5D180\1\0\1\afg\f#EB75D6\1\0\1\afg\f#35D27F\1\0\1\afg\f#3AC6BE\1\0\1\afg\f#ef9062\1\0\2\21use_colorpalette\1\ncolor\f#ef9062\nsetup\vhlargs\frequire\0", "config", "hlargs.nvim")
time([[Config for hlargs.nvim]], false)
-- Config for: nvim-autopairs
time([[Config for nvim-autopairs]], true)
try_loadstring("\27LJ\2\n�\3\0\0\t\0\21\0\"6\0\0\0006\2\1\0'\3\2\0B\0\3\3\15\0\0\0X\2\v�9\2\3\1\18\4\2\0009\2\4\2'\5\5\0006\6\1\0'\b\6\0B\6\2\0029\6\a\0065\b\b\0B\6\2\0A\2\2\0016\2\1\0'\4\t\0B\2\2\0029\2\n\0025\4\v\0005\5\r\0005\6\f\0=\6\14\0055\6\15\0=\6\16\5=\5\17\0045\5\18\0=\5\19\0044\5\0\0=\5\20\4B\2\2\1K\0\1\0\14fast_wrap\21disable_filetype\1\3\0\0\20TelescopePrompt\bvim\14ts_config\15javascript\1\3\0\0\vstring\20template_string\blua\1\0\1\tjava\1\1\3\0\0\vstring\vsource\1\0\1\rcheck_ts\2\nsetup\19nvim-autopairs\1\0\1\btex\1\20on_confirm_done\"nvim-autopairs.completion.cmp\17confirm_done\aon\nevent\bcmp\frequire\npcall\0", "config", "nvim-autopairs")
time([[Config for nvim-autopairs]], false)
-- Config for: hop.nvim
time([[Config for hop.nvim]], true)
try_loadstring("\27LJ\2\nO\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\tkeys\22çalskdjfwoeicmvn\nsetup\bhop\frequire\0", "config", "hop.nvim")
time([[Config for hop.nvim]], false)

-- Command lazy-loads
time([[Defining lazy-load commands]], true)
pcall(vim.api.nvim_create_user_command, 'TermOpen', function(cmdargs)
          require('packer.load')({'toggleterm.nvim'}, { cmd = 'TermOpen', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'toggleterm.nvim'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('TermOpen ', 'cmdline')
      end})
pcall(vim.api.nvim_create_user_command, 'Lspsaga', function(cmdargs)
          require('packer.load')({'lspsaga.nvim'}, { cmd = 'Lspsaga', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'lspsaga.nvim'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('Lspsaga ', 'cmdline')
      end})
pcall(vim.api.nvim_create_user_command, 'NvimTreeToggle', function(cmdargs)
          require('packer.load')({'nvim-tree.lua'}, { cmd = 'NvimTreeToggle', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'nvim-tree.lua'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('NvimTreeToggle ', 'cmdline')
      end})
pcall(vim.api.nvim_create_user_command, 'NvimTreeClose', function(cmdargs)
          require('packer.load')({'nvim-tree.lua'}, { cmd = 'NvimTreeClose', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'nvim-tree.lua'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('NvimTreeClose ', 'cmdline')
      end})
pcall(vim.api.nvim_create_user_command, 'NvimTreeOpen', function(cmdargs)
          require('packer.load')({'nvim-tree.lua'}, { cmd = 'NvimTreeOpen', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'nvim-tree.lua'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('NvimTreeOpen ', 'cmdline')
      end})
pcall(vim.api.nvim_create_user_command, 'NvimTreeFindFile', function(cmdargs)
          require('packer.load')({'nvim-tree.lua'}, { cmd = 'NvimTreeFindFile', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'nvim-tree.lua'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('NvimTreeFindFile ', 'cmdline')
      end})
pcall(vim.api.nvim_create_user_command, 'NvimTreeFindFileToggle', function(cmdargs)
          require('packer.load')({'nvim-tree.lua'}, { cmd = 'NvimTreeFindFileToggle', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'nvim-tree.lua'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('NvimTreeFindFileToggle ', 'cmdline')
      end})
pcall(vim.api.nvim_create_user_command, 'Copilot', function(cmdargs)
          require('packer.load')({'copilot.lua'}, { cmd = 'Copilot', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'copilot.lua'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('Copilot ', 'cmdline')
      end})
pcall(vim.api.nvim_create_user_command, 'ColorizerToggle', function(cmdargs)
          require('packer.load')({'nvim-colorizer.lua'}, { cmd = 'ColorizerToggle', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'nvim-colorizer.lua'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('ColorizerToggle ', 'cmdline')
      end})
pcall(vim.api.nvim_create_user_command, 'ColorizerDetachFromBuffer', function(cmdargs)
          require('packer.load')({'nvim-colorizer.lua'}, { cmd = 'ColorizerDetachFromBuffer', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'nvim-colorizer.lua'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('ColorizerDetachFromBuffer ', 'cmdline')
      end})
pcall(vim.api.nvim_create_user_command, 'ColorizerReloadAllBuffers', function(cmdargs)
          require('packer.load')({'nvim-colorizer.lua'}, { cmd = 'ColorizerReloadAllBuffers', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'nvim-colorizer.lua'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('ColorizerReloadAllBuffers ', 'cmdline')
      end})
pcall(vim.api.nvim_create_user_command, 'ColorizerAttachToBuffer', function(cmdargs)
          require('packer.load')({'nvim-colorizer.lua'}, { cmd = 'ColorizerAttachToBuffer', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'nvim-colorizer.lua'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('ColorizerAttachToBuffer ', 'cmdline')
      end})
pcall(vim.api.nvim_create_user_command, 'ToggleTerm', function(cmdargs)
          require('packer.load')({'toggleterm.nvim'}, { cmd = 'ToggleTerm', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'toggleterm.nvim'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('ToggleTerm ', 'cmdline')
      end})
pcall(vim.api.nvim_create_user_command, 'TermExec', function(cmdargs)
          require('packer.load')({'toggleterm.nvim'}, { cmd = 'TermExec', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'toggleterm.nvim'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('TermExec ', 'cmdline')
      end})
time([[Defining lazy-load commands]], false)

vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Event lazy-loads
time([[Defining lazy-load event autocommands]], true)
vim.cmd [[au BufRead * ++once lua require("packer.load")({'nvim-colorizer.lua'}, { event = "BufRead *" }, _G.packer_plugins)]]
vim.cmd [[au VimEnter * ++once lua require("packer.load")({'telescope.nvim', 'noice.nvim'}, { event = "VimEnter *" }, _G.packer_plugins)]]
vim.cmd [[au InsertEnter * ++once lua require("packer.load")({'copilot.lua', 'nvim-cmp'}, { event = "InsertEnter *" }, _G.packer_plugins)]]
vim.cmd [[au BufReadPre * ++once lua require("packer.load")({'lualine.nvim', 'indent-blankline.nvim', 'dressing.nvim', 'nvim-notify', 'bufferline.nvim', 'gitsigns.nvim'}, { event = "BufReadPre *" }, _G.packer_plugins)]]
time([[Defining lazy-load event autocommands]], false)
vim.cmd("augroup END")

_G._packer.inside_compile = false
if _G._packer.needs_bufread == true then
  vim.cmd("doautocmd BufRead")
end
_G._packer.needs_bufread = false

if should_profile then save_profiles(0) end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
