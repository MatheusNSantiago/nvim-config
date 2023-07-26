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
    config = { "\27LJ\2\n�\2\0\0\6\0\f\0\0216\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0004\3\0\0=\3\4\0024\3\0\0=\3\5\0024\3\0\0=\3\6\0025\3\a\0=\3\b\0026\3\0\0'\5\t\0B\3\2\0029\3\n\3B\3\1\2=\3\v\2B\0\2\1K\0\1\0\rpre_hook\20create_pre_hook7ts_context_commentstring.integrations.comment_nvim\rmappings\1\0\2\nextra\2\nbasic\2\nextra\ropleader\ftoggler\1\0\2\fpadding\2\vsticky\2\nsetup\fComment\frequire\0" },
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/Comment.nvim",
    url = "https://github.com/numToStr/Comment.nvim"
  },
  LuaSnip = {
    config = { "\27LJ\2\n�\1\0\1\3\1\5\0\20-\1\0\0009\1\0\1\15\0\1\0X\2\15�-\1\0\0009\1\0\0019\1\1\0019\2\2\0008\1\2\1\15\0\1\0X\2\b�-\1\0\0009\1\0\0019\1\3\1\14\0\1\0X\1\3�-\1\0\0009\1\4\1B\1\1\1K\0\1\0\0�\19unlink_current\16jump_active\bbuf\18current_nodes\fsession�\4\1\0\a\0\26\0-6\0\0\0'\2\1\0B\0\2\0026\1\2\0009\1\3\0019\1\4\1'\3\5\0005\4\6\0B\1\3\0026\2\2\0009\2\3\0029\2\a\2'\4\b\0005\5\t\0=\1\n\0055\6\v\0=\6\f\0053\6\r\0=\6\14\5B\2\3\0019\2\15\0'\4\16\0005\5\17\0B\2\3\0019\2\15\0'\4\18\0005\5\19\0B\2\3\0016\2\0\0'\4\20\0B\2\2\0029\2\21\2B\2\1\0016\2\0\0'\4\20\0B\2\2\0029\2\21\0025\4\22\0B\2\2\0019\2\23\0009\2\24\0025\4\25\0B\2\2\0012\0\0�K\0\1\0\1\0\1\24region_check_events\16CursorMoved\15set_config\vconfig\1\0\1\npaths\15./snippets\14lazy_load luasnip.loaders.from_vscode\1\3\0\0\thtml\15javascript\20javascriptreact\1\3\0\0\thtml\15typescript\20typescriptreact\20filetype_extend\rcallback\0\fpattern\1\3\0\0\bs:n\bi:*\ngroup\1\0\1\tdesc<Forget the current snippet when leaving the insert mode\16ModeChanged\24nvim_create_autocmd\1\0\1\nclear\2\30UnlinkSnippetOnModeChange\24nvim_create_augroup\bapi\bvim\fluasnip\frequire\0" },
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/LuaSnip",
    url = "https://github.com/L3MON4D3/LuaSnip"
  },
  ["awesome-flutter-snippets"] = {
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/awesome-flutter-snippets",
    url = "https://github.com/Nash0x7E2/awesome-flutter-snippets"
  },
  ["bufferline.nvim"] = {
    config = { "\27LJ\2\nW\0\4\b\0\5\0\14\18\6\1\0009\4\0\1'\a\1\0B\4\3\2\15\0\4\0X\5\2�'\4\2\0X\5\1�'\4\3\0'\5\4\0\18\6\4\0\18\a\0\0&\5\a\5L\5\2\0\6 \t \t \nerror\nmatch�\a\1\0\a\0\21\0\0296\0\0\0'\2\1\0B\0\2\0029\1\2\0005\3\18\0005\4\3\0005\5\4\0=\5\5\0043\5\6\0=\5\a\0044\5\4\0005\6\b\0>\6\1\0055\6\t\0>\6\2\0055\6\n\0>\6\3\5=\5\v\0045\5\f\0=\5\r\0045\5\14\0005\6\15\0=\6\16\5=\5\17\4=\4\19\0034\4\0\0=\4\20\3B\1\2\1K\0\1\0\15highlights\foptions\1\0\0\nhover\vreveal\1\2\0\0\nclose\1\0\2\ndelay\3�\1\fenabled\2\20separator_style\1\3\0\0\6|\6|\foffsets\1\0\4\ttext\rUndotree\rfiletype\rundotree\15text_align\vcenter\14separator\2\1\0\4\ttext\20Flutter Outline\rfiletype\24flutterToolsOutline\15text_align\vcenter\14separator\2\1\0\4\ttext\18File Explorer\rfiletype\rNvimTree\15text_align\vcenter\14separator\2\26diagnostics_indicator\0\14indicator\1\0\1\nstyle\14underline\1\0\25\22show_buffer_icons\2\23left_mouse_command\14buffer %d\25enforce_regular_tabs\1\22buffer_close_icon\b\18modified_icon\b●\15close_icon\b\22left_trunc_marker\b\23right_trunc_marker\b\20max_name_length\3\18\16diagnostics\rnvim_lsp\tmode\ttabs\22max_prefix_length\3\15\19truncate_names\1\rtab_size\3\18!diagnostics_update_in_insert\1\fsort_by\ttabs\27always_show_bufferline\2\20show_close_icon\1\26show_duplicate_prefix\1\16color_icons\2\fnumbers\tnone\28show_buffer_close_icons\1\18close_command\16bdelete! %d\24show_tab_indicators\1\24right_mouse_command\16bdelete! %d\nsetup\15bufferline\frequire\0" },
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
  ["cmp-conventionalcommits"] = {
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/cmp-conventionalcommits",
    url = "https://github.com/davidsierradz/cmp-conventionalcommits"
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
  ["cmp-under-comparator"] = {
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/cmp-under-comparator",
    url = "https://github.com/lukas-reineke/cmp-under-comparator"
  },
  cmp_luasnip = {
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/cmp_luasnip",
    url = "https://github.com/saadparwaiz1/cmp_luasnip"
  },
  ["comment-box.nvim"] = {
    config = { "\27LJ\2\n�\2\0\0\4\0\b\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\0025\3\6\0=\3\a\2B\0\2\1K\0\1\0\tline\1\0\3\15line_start\b─\rline_end\b─\tline\b─\fborders\1\0\b\17bottom_right\b╯\rtop_left\b╭\14top_right\b╮\tleft\b│\vbottom\b─\nright\b│\btop\b─\16bottom_left\b╰\1\0\a\22outer_blank_lines\1\22inner_blank_lines\1\26line_blank_line_above\1\26line_blank_line_below\1\14doc_width\3P\14box_width\3<\15line_width\3U\nsetup\16comment-box\frequire\0" },
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
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/copilot.lua",
    url = "https://github.com/zbirenbaum/copilot.lua"
  },
  ["dressing.nvim"] = {
    config = { "\27LJ\2\n\v\0\1\1\0\0\0\1L\0\2\0\v\0\1\1\0\0\0\1L\0\2\0�\n\1\0\a\0002\0A6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\19\0005\3\3\0005\4\4\0=\4\5\0035\4\6\0=\4\a\0034\4\0\0=\4\b\0035\4\t\0=\4\n\0035\4\f\0005\5\v\0=\5\r\0045\5\14\0=\5\15\4=\4\16\0033\4\17\0=\4\18\3=\3\20\0025\3\21\0005\4\22\0=\4\23\0035\4\25\0005\5\24\0=\5\26\4=\4\27\0035\4\29\0005\5\28\0=\5\30\4=\4\31\0035\4 \0005\5!\0=\5\"\0045\5#\0=\5\b\0045\5$\0=\5\n\4=\4%\0035\4&\0004\5\0\0=\5\b\0045\5'\0=\5\n\0045\5(\0=\5\5\0045\5)\0=\5\a\0045\5*\0=\5+\0045\5-\0005\6,\0=\6\r\5=\5\16\0043\5.\0=\5\18\4=\4/\0034\4\0\0=\0040\3=\0031\2B\0\2\1K\0\1\0\vselect\25format_item_override\fbuiltin\0\1\0\3\n<C-c>\nClose\t<CR>\fConfirm\n<Esc>\nClose\1\0\1\6q\nClose\15min_height\1\3\0\0\3\n\4����\t����\3\1\3\0\0\3(\4����\t����\3\1\3\0\0\3�\1\4����\t����\3\1\0\2\rwinblend\3\n\17winhighlight\"Normal:Normal,NormalNC:Normal\1\0\4\vanchor\aNW\15max_height\4͙��\f̙��\3\rrelative\veditor\vborder\frounded\bnui\1\0\1\rwinblend\3\n\1\0\2\rswapfile\1\rfiletype\19DressingSelect\vborder\1\0\1\nstyle\frounded\1\0\6\14min_width\3(\15min_height\3\n\rrelative\veditor\15max_height\3(\14max_width\3P\rposition\b50%\ffzf_lua\fwinopts\1\0\0\1\0\2\vheight\4����\t����\3\nwidth\4\0����\3\bfzf\vwindow\1\0\0\1\0\2\vheight\4����\t����\3\nwidth\4\0����\3\fbackend\1\6\0\0\14telescope\ffzf_lua\bfzf\fbuiltin\bnui\1\0\2\16trim_prompt\2\fenabled\2\ninput\1\0\0\roverride\0\rmappings\6i\1\0\4\n<C-c>\nClose\v<Down>\16HistoryNext\t<CR>\fConfirm\t<Up>\16HistoryPrev\6n\1\0\0\1\0\2\t<CR>\fConfirm\n<Esc>\nClose\16win_options\1\0\3\twrap\1\17winhighlight7Normal:TelescopeNormal,FloatBorder:TelescopeBorder\rwinblend\3\0\16buf_options\14min_width\1\3\0\0\3\20\4����\t����\3\14max_width\1\3\0\0\3�\1\4͙��\f̙��\3\1\0\t\rrelative\vcursor\20start_in_insert\2\vanchor\aSW\17prefer_width\3(\fenabled\2\19default_prompt\vInput:\17prompt_align\tleft\16insert_only\2\vborder\frounded\nsetup\rdressing\frequire\0" },
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/dressing.nvim",
    url = "https://github.com/stevearc/dressing.nvim"
  },
  ["flit.nvim"] = {
    config = { "\27LJ\2\n�\1\0\0\4\0\a\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0024\3\0\0=\3\6\2B\0\2\1K\0\1\0\topts\tkeys\1\0\2\14multiline\1\18labeled_modes\6v\1\0\4\6T\6T\6F\6F\6f\6f\6t\6t\nsetup\tflit\frequire\0" },
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/flit.nvim",
    url = "https://github.com/ggandor/flit.nvim"
  },
  ["flutter-tools.nvim"] = {
    config = { "\27LJ\2\n�\1\0\0\b\0\b\0\0296\0\0\0009\0\1\0009\0\2\0006\2\0\0009\2\1\0029\2\3\2'\4\4\0+\5\2\0+\6\1\0+\a\2\0B\2\5\2'\3\5\0+\4\2\0B\0\4\0016\0\0\0009\0\1\0009\0\2\0'\2\6\0'\3\5\0+\4\2\0B\0\4\0016\0\0\0009\0\1\0009\0\2\0'\2\a\0'\3\5\0+\4\2\0B\0\4\1K\0\1\0\a<<\a>>\6n\n<Esc>\27nvim_replace_termcodes\18nvim_feedkeys\bapi\bvim�\5\1\2\t\1\26\00066\2\0\0'\4\1\0B\2\2\0029\2\2\2\18\4\0\0\18\5\1\0B\2\3\0016\2\0\0'\4\3\0B\2\2\0029\2\4\2'\4\5\0B\2\2\1-\2\0\0'\4\6\0'\5\a\0'\6\b\0005\a\t\0B\2\5\1-\2\0\0'\4\6\0'\5\n\0'\6\v\0005\a\f\0B\2\5\1-\2\0\0'\4\6\0'\5\r\0'\6\14\0005\a\15\0B\2\5\1-\2\0\0'\4\6\0'\5\16\0006\6\0\0'\b\3\0B\6\2\0029\6\17\0069\6\5\0069\6\18\0065\a\19\0B\2\5\1-\2\0\0'\4\6\0'\5\20\0'\6\21\0005\a\22\0B\2\5\0016\2\23\0009\2\24\0023\4\25\0)\5�\nB\2\3\1K\0\1\0\0�\0\rdefer_fn\bvim\1\0\1\tdesc!flutter: run code generation;:TermExec cmd='flutter pub run build_runner watch'<CR>\15<leader>br\1\0\1\tdesc\26Flutter: open pallete\rcommands\15extensions\22<leader><leader>o\1\0\1\tdesc\21Flutter: restart\24:FlutterRestart<CR>\22<leader><leader>r\1\0\1\tdesc\20Flutter: reload\23:FlutterReload<CR>\14<leader>r\1\0\1\tdesc\30Flutter: Open [D]ev [L]og%:tabedit __FLUTTER_DEV_LOG__<CR>\15<leader>dl\6n\fflutter\19load_extension\14telescope\21common_on_attach\blsp\frequire�\4\1\0\b\0\27\0)6\0\0\0009\0\1\0009\0\2\0006\1\3\0'\3\4\0B\1\2\0029\1\5\0014\3\0\0B\1\2\0016\1\3\0'\3\6\0B\1\2\0029\1\5\0015\3\b\0005\4\a\0=\4\t\0034\4\0\0=\4\n\0035\4\f\0005\5\v\0=\5\r\4=\4\14\0035\4\15\0=\4\16\0035\4\17\0=\4\18\0035\4\20\0005\5\19\0=\5\21\0043\5\22\0=\5\23\0046\5\3\0'\a\24\0B\5\2\0029\5\25\5B\5\1\2=\5\26\4=\4\24\3B\1\2\0012\0\0�K\0\1\0\17capabilities\24common_capabilities\blsp\14on_attach\0\rsettings\1\0\0\1\0\2\14showTodos\1\27renameFilesWithClasses\vprompt\fdev_log\1\0\3\18notify_errors\2\ropen_cmd\ftabedit\fenabled\2\18widget_guides\1\0\1\fenabled\2\16decorations\15statusline\1\0\0\1\0\2\16app_version\1\vdevice\1\rdebugger\aui\1\0\0\1\0\2\vborder\frounded\23notification_style\vplugin\18flutter-tools\nsetup\19pubspec-assist\frequire\vkeymap\bapi\nutils\0" },
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
    config = { "\27LJ\2\nW\0\4\n\1\4\0\14\14\0\3\0X\4\1�4\3\0\0-\4\0\0=\4\0\0036\4\1\0009\4\2\0049\4\3\4\18\6\0\0\18\a\1\0\18\b\2\0\18\t\3\0B\4\5\1K\0\1\0\0�\bset\vkeymap\bvim\vbuffer#\0\0\2\1\1\0\4-\0\0\0009\0\0\0B\0\1\1K\0\1\0\0\0\14next_hunkg\1\0\3\1\a\0\0156\0\0\0009\0\1\0009\0\2\0\15\0\0\0X\1\2�'\0\3\0002\0\a�6\0\0\0009\0\4\0003\2\5\0B\0\2\1'\0\6\0002\0\0�L\0\2\0L\0\2\0\1�\r<Ignore>\0\rschedule\a]h\tdiff\awo\bvim#\0\0\2\1\1\0\4-\0\0\0009\0\0\0B\0\1\1K\0\1\0\0\0\14prev_hunkg\1\0\3\1\a\0\0156\0\0\0009\0\1\0009\0\2\0\15\0\0\0X\1\2�'\0\3\0002\0\a�6\0\0\0009\0\4\0003\2\5\0B\0\2\1'\0\6\0002\0\0�L\0\2\0L\0\2\0\1�\r<Ignore>\0\rschedule\a[h\tdiff\awo\bvim1\0\0\3\1\2\0\5-\0\0\0009\0\0\0005\2\1\0B\0\2\1K\0\1\0\1�\1\0\1\tfull\2\15blame_line�\3\1\1\t\0\25\0*6\1\0\0009\1\1\0019\1\2\0013\2\3\0\18\3\2\0'\5\4\0'\6\5\0003\a\6\0005\b\a\0B\3\5\1\18\3\2\0'\5\4\0'\6\b\0003\a\t\0005\b\n\0B\3\5\1\18\3\2\0005\5\v\0'\6\f\0'\a\r\0005\b\14\0B\3\5\1\18\3\2\0005\5\15\0'\6\16\0'\a\17\0005\b\18\0B\3\5\1\18\3\2\0'\5\4\0'\6\19\0009\a\20\0015\b\21\0B\3\5\1\18\3\2\0'\5\4\0'\6\22\0003\a\23\0005\b\24\0B\3\5\0012\0\0�K\0\1\0\1\0\1\tdesc\19[H]unk [B]lame\0\15<leader>hb\1\0\1\tdesc\21[H]unk [P]review\17preview_hunk\15<leader>hp\1\0\1\tdesc\19[H]unk [R]eset\29:Gitsigns reset_hunk<CR>\15<leader>hr\1\3\0\0\6n\6v\1\0\1\tdesc\17[H]unk [A]dd\29:Gitsigns stage_hunk<CR>\15<leader>ha\1\3\0\0\6n\6v\1\0\1\texpr\2\0\a[h\1\0\1\texpr\2\0\a]h\6n\0\rgitsigns\vloaded\fpackage�\a\1\0\6\0\26\0\0293\0\0\0006\1\1\0'\3\2\0B\1\2\0029\1\3\0015\3\15\0005\4\5\0005\5\4\0=\5\6\0045\5\a\0=\5\b\0045\5\t\0=\5\n\0045\5\v\0=\5\f\0045\5\r\0=\5\14\4=\4\16\0035\4\17\0=\4\18\0035\4\19\0=\4\20\0035\4\21\0=\4\22\0035\4\23\0=\4\24\3=\0\25\3B\1\2\1K\0\1\0\14on_attach\tyadm\1\0\1\venable\1\19preview_config\1\0\5\bcol\3\1\rrelative\vcursor\nstyle\fminimal\brow\3\0\vborder\frounded\28current_line_blame_opts\1\0\4\22ignore_whitespace\1\14virt_text\2\18virt_text_pos\beol\ndelay\3�\a\17watch_gitdir\1\0\2\17follow_files\2\rinterval\3�\a\nsigns\1\0\n\15signcolumn\2\18sign_priority\3\6!current_line_blame_formatter1<author>, <author_time:%Y-%m-%d> - <summary>\20update_debounce\3�\1\14word_diff\1\24attach_to_untracked\2\23current_line_blame\1\20max_file_length\3��\2\nnumhl\1\vlinehl\1\17changedelete\1\0\4\ttext\b▍\ahl\19GitSignsChange\nnumhl\21GitSignsChangeNr\vlinehl\21GitSignsChangeLn\14topdelete\1\0\4\ttext\b▾\ahl\19GitSignsDelete\nnumhl\21GitSignsDeleteNr\vlinehl\21GitSignsDeleteLn\vdelete\1\0\4\ttext\b▸\ahl\19GitSignsDelete\nnumhl\21GitSignsDeleteNr\vlinehl\21GitSignsDeleteLn\vchange\1\0\4\ttext\b▍\ahl\19GitSignsChange\nnumhl\21GitSignsChangeNr\vlinehl\21GitSignsChangeLn\badd\1\0\0\1\0\4\ttext\b▍\ahl\16GitSignsAdd\nnumhl\18GitSignsAddNr\vlinehl\18GitSignsAddLn\nsetup\rgitsigns\frequire\0\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/opt/gitsigns.nvim",
    url = "https://github.com/lewis6991/gitsigns.nvim"
  },
  ["guess-indent.nvim"] = {
    config = { "\27LJ\2\n�\1\0\0\4\0\b\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\0025\3\6\0=\3\a\2B\0\2\1K\0\1\0\20buftype_exclude\1\5\0\0\thelp\vnofile\rterminal\vprompt\21filetype_exclude\1\3\0\0\nnetrw\ntutor\1\0\2\rauto_cmd\2\26override_editorconfig\1\nsetup\17guess-indent\frequire\0" },
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/guess-indent.nvim",
    url = "https://github.com/nmac427/guess-indent.nvim"
  },
  ["hlsearch.nvim"] = {
    config = { "\27LJ\2\n6\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\rhlsearch\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/opt/hlsearch.nvim",
    url = "https://github.com/nvimdev/hlsearch.nvim"
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
    config = { "\27LJ\2\n�\4\0\0\4\0\b\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\0025\3\6\0=\3\a\2B\0\2\1K\0\1\0\21filetype_exclude\1\16\0\0\ndbout\19neo-tree-popup\blog\14gitcommit\btxt\thelp\rNvimTree\bgit\24flutterToolsOutline\rundotree\rmarkdown\tnorg\borg\14orgagenda\5\20buftype_exclude\1\4\0\0\rterminal\14telescope\vnofile\1\0\v\tchar\b│\25show_current_context\2\18show_foldtext\1\18char_priority\3\f#show_trailing_blankline_indent\1\25space_char_blankline\6 \28show_first_indent_level\2\21show_end_of_line\1/show_current_context_start_on_current_line\1\31show_current_context_start\2\17context_char\b│\nsetup\21indent_blankline\frequire\0" },
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/indent-blankline.nvim",
    url = "https://github.com/lukas-reineke/indent-blankline.nvim"
  },
  ["leap-spooky.nvim"] = {
    config = { "\27LJ\2\n�\1\0\0\5\0\n\0\r6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\b\0005\3\4\0005\4\3\0=\4\5\0035\4\6\0=\4\a\3=\3\t\2B\0\2\1K\0\1\0\faffixes\1\0\1\25paste_on_remote_yank\1\rmagnetic\1\0\2\17cross_window\6M\vwindow\6m\vremote\1\0\0\1\0\2\17cross_window\6R\vwindow\6r\nsetup\16leap-spooky\frequire\0" },
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/leap-spooky.nvim",
    url = "https://github.com/ggandor/leap-spooky.nvim"
  },
  ["leap.nvim"] = {
    config = { "\27LJ\2\n�\3\0\0\6\0\14\0\0196\0\0\0'\2\1\0B\0\2\0029\1\2\0B\1\1\0019\1\3\0005\3\4\0004\4\0\0=\4\5\0035\4\6\0=\4\a\0035\4\b\0005\5\t\0=\5\n\0045\5\v\0=\5\f\4=\4\r\3B\1\2\1K\0\1\0\17special_keys\16prev_target\1\3\0\0\n<tab>\6,\16next_target\1\3\0\0\f<enter>\6;\1\0\6\15next_group\f<space>\17multi_accept\f<enter>\18repeat_search\f<enter>\26next_phase_one_target\f<enter>\15prev_group\n<tab>\17multi_revert\16<backspace>\vlabels\1\n\0\0\6a\6s\6d\6f\6n\6j\6k\6l\aç\16safe_labels\1\0\2\19case_sensitive\1&max_highlighted_traversal_targets\3\n\nsetup\25add_default_mappings\tleap\frequire\0" },
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/leap.nvim",
    url = "https://github.com/ggandor/leap.nvim"
  },
  ["lsp-colors.nvim"] = {
    config = { "\27LJ\2\n~\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\4\fWarning\f#e0af68\16Information\f#0db9d7\tHint\f#10B981\nError\f#db4b4b\nsetup\15lsp-colors\frequire\0" },
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/lsp-colors.nvim",
    url = "https://github.com/folke/lsp-colors.nvim"
  },
  ["lsp_signature.nvim"] = {
    config = { "\27LJ\2\n�\3\0\0\4\0\a\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\0024\3\0\0=\3\6\2B\0\2\1K\0\1\0\24extra_trigger_chars\17handler_opts\1\0\1\vborder\frounded\1\0\22\19always_trigger\1\17transparency\3d\17shadow_blend\3$\17shadow_guibg\nBlack\19timer_interval\3�\1\15max_height\3\f\15toggle_key\n<A-q>\fpadding\5\16hint_prefix\n🐼 \20floating_window\2\14doc_lines\3\n#floating_window_above_cur_line\2\26floating_window_off_x\3\1\26floating_window_off_y\3\0\18close_timeout\3�\31\ffix_pos\1\16hint_enable\1\twrap\2\14max_width\3P\tbind\2\16hint_scheme\vString\17hi_parameter LspSignatureActiveParameter\nsetup\18lsp_signature\frequire\0" },
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/lsp_signature.nvim",
    url = "https://github.com/ray-x/lsp_signature.nvim"
  },
  ["lspkind.nvim"] = {
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/lspkind.nvim",
    url = "https://github.com/onsails/lspkind.nvim"
  },
  ["lspsaga.nvim"] = {
    config = { "\27LJ\2\n�\v\0\0\6\0%\0-6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0025\3\6\0004\4\0\0=\4\a\3=\3\b\0025\3\t\0005\4\n\0=\4\v\3=\3\f\0025\3\r\0004\4\0\0=\4\14\3=\3\15\0025\3\16\0=\3\17\0025\3\18\0=\3\19\0025\3\20\0005\4\21\0=\4\v\3=\3\22\0025\3\23\0005\4\24\0005\5\25\0=\5\26\0045\5\27\0=\5\28\4=\4\v\3=\3\29\0025\3\30\0=\3\31\0025\3 \0005\4!\0005\5\"\0=\5#\4=\4\v\3=\3$\2B\0\2\1K\0\1\0\15diagnostic\17quit_in_show\1\3\0\0\6q\n<ESC>\1\0\3\16exec_action\6o\tquit\6q\19toggle_or_jump\t<CR>\1\0\f\20max_show_height\4��̙\3���\3\28diagnostic_only_current\1\30extend_relatedInformation\1\18border_follow\2\19text_hl_follow\2\15max_height\4��̙\3���\3\14max_width\4����\t����\3\22jump_num_shortcut\2\23show_normal_height\3\n\16show_layout\nfloat\21show_code_action\2\19max_show_width\4͙��\f̙��\3\14implement\1\0\4\17virtual_text\2\rpriority\3d\venable\2\tsign\2\vfinder\tquit\1\3\0\0\6q\n<ESC>\tedit\1\3\0\0\6o\t<CR>\1\0\6\vtabnew\6r\ttabe\6t\21close_in_preview\n<ESC>\vvsplit\6v\fjump_to\6p\nsplit\6h\1\0\2\15max_height\4\0����\3\21force_max_height\1\16code_action\1\0\2\tquit\6q\texec\t<CR>\1\0\3\21show_server_name\1\17num_shortcut\2\20extend_gitsigns\1\14lightbulb\1\0\6\17virtual_text\1\18sign_priority\3(\rdebounce\3\n\tsign\2\21enable_in_insert\2\venable\2\vrename\1\0\5\tmark\6x\fconfirm\t<CR>\14in_select\2\tquit\n<C-c>\texec\t<CR>\21symbol_in_winbar\20ignore_patterns\1\0\a\15color_mode\2\17respect_root\1\17folder_level\3\1\14show_file\2\17hide_keyword\2\venable\1\14separator\t \15definition\tkeys\1\0\6\tquit\6q\ttabe\v<C-c>t\tedit\v<C-c>o\vvsplit\v<C-c>v\nclose\v<C-c>k\nsplit\v<C-c>h\1\0\2\nwidth\4��̙\3���\3\vheight\4\0����\3\aui\tkind\1\0\t\vexpand\b\rwinblend\3\0\16code_action\t💡\ntitle\2\routgoing\t \rincoming\t \rcollapse\b\nhover\t \vborder\vsingle\19scroll_preview\1\0\1\20request_timeout\3�\23\1\0\2\16scroll_down\n<C-d>\14scroll_up\n<C-u>\nsetup\flspsaga\frequire\0" },
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/lspsaga.nvim",
    url = "https://github.com/glepnir/lspsaga.nvim"
  },
  ["lualine.nvim"] = {
    config = { "\27LJ\2\n1\0\0\3\2\3\0\a-\0\0\0009\0\0\0009\0\1\0'\1\2\0-\2\1\0&\0\2\0L\0\2\0\0�\3�\6 \bGit\bgit�\a\1\0\14\0000\0T6\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0026\2\0\0'\4\3\0B\2\2\0026\3\4\0009\3\5\0039\3\6\0036\5\4\0009\5\5\0059\5\a\0056\a\4\0009\a\5\a9\a\b\a'\t\t\0B\a\2\0A\5\0\2'\6\n\0B\3\3\0029\4\v\0015\6\19\0005\a\r\0006\b\0\0'\n\f\0B\b\2\2=\b\14\a5\b\15\0=\b\16\a5\b\17\0=\b\18\a=\a\20\0065\a\21\0=\a\22\0064\a\0\0=\a\23\0066\a\0\0'\t\24\0B\a\2\2=\a\25\0064\a\0\0=\a\26\0065\a\27\0004\b\0\0=\b\28\a4\b\3\0005\t\29\0>\t\1\b5\t\30\0>\t\2\b=\b\31\a=\a \0065\a$\0005\b\"\0005\t!\0=\t#\b4\t\0\0=\t\25\b>\b\1\a5\b&\0005\t%\0=\t#\b4\t\0\0=\t\25\b5\t-\0004\n\3\0005\v+\0003\f'\0>\f\1\v5\f(\0009\r)\2=\r*\f=\f,\v>\v\1\n=\n.\t=\t\26\b>\b\3\a=\a/\6B\4\2\0012\0\0�K\0\1\0\15extensions\14lualine_b\1\0\0\ncolor\1\0\0\afg\tcyan\1\0\2\bgui\19underline,bold\abg\tNone\0\1\0\0\1\2\0\0\rNvimTree\1\3\0\0\0\rquickfix\14filetypes\1\0\0\1\2\0\0\15toggleterm\22inactive_sections\14lualine_c\1\2\0\0\rfilename\1\2\0\0\a%=\14lualine_x\1\0\0\vwinbar\rsections\"plugins.ui.lualine.statusline\23disabled_filetypes\frefresh\1\0\3\ftabline\3�\a\15statusline\3�\a\vwinbar\3d\foptions\1\0\2\17globalstatus\2\18icons_enabled\2\23section_separators\1\0\2\nright\5\tleft\5\25component_separators\1\0\2\nright\5\tleft\5\ntheme\1\0\0\29plugins.ui.lualine.theme\nsetup\a:t\"git rev-parse --show-toplevel\vsystem\ttrim\16fnamemodify\afn\bvim\17utils.colors\flualine\16utils.icons\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/opt/lualine.nvim",
    url = "https://github.com/nvim-lualine/lualine.nvim"
  },
  ["marks.nvim"] = {
    config = { "\27LJ\2\n�\1\0\0\4\0\a\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0004\3\0\0=\3\4\0025\3\5\0=\3\6\2B\0\2\1K\0\1\0\rmappings\1\0\6\tprev\am[\15delete_buf\adM\16delete_line\adm\fpreview\am:\tnext\am]\bset\6m\18builtin_marks\1\0\2\22force_write_shada\1\21default_mappings\1\nsetup\nmarks\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/opt/marks.nvim",
    url = "https://github.com/chentoast/marks.nvim"
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
    config = { "\27LJ\2\nI\0\1\5\2\2\0\n-\1\0\0009\1\0\1\18\3\0\0B\1\2\2-\2\1\0008\2\0\0029\2\1\2\18\4\1\0B\2\2\1K\0\1\0\4�\1�\nsetup\20get_configs_forP\0\0\4\2\3\0\n-\0\0\0009\0\0\0'\2\1\0B\0\2\2-\1\1\0009\1\1\0019\1\2\1\18\3\0\0B\1\2\1K\0\1\0\4�\1�\nsetup\vlua_ls\20get_configs_fort\0\0\4\0\5\0\f6\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\0026\1\0\0'\3\3\0B\1\2\0029\1\4\1\18\3\0\0B\1\2\1K\0\1\0\nsetup\21typescript-tools\vconfig\27plugins.dev.typescript\frequire�\5\1\0\v\0\"\0;6\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0026\2\0\0'\4\3\0B\2\2\0026\3\0\0'\5\4\0B\3\2\0026\4\0\0'\6\5\0B\4\2\0026\5\0\0'\a\6\0B\5\2\0029\6\a\0005\b\v\0005\t\b\0005\n\t\0=\n\n\t=\t\f\bB\6\2\0019\6\a\0055\b\14\0005\t\r\0=\t\15\bB\6\2\0019\6\a\0035\b\17\0009\t\16\4=\t\15\bB\6\2\0019\6\a\0025\b\21\0005\t\19\0005\n\18\0=\n\20\t=\t\22\bB\6\2\0019\6\23\0035\b\26\0003\t\24\0>\t\1\b3\t\25\0=\t\27\b3\t\28\0=\t\29\bB\6\2\0016\6\0\0'\b\30\0B\6\2\0029\6\31\6'\a!\0=\a \0062\0\0�K\0\1\0\vsingle\vborder\20default_options\25lspconfig.ui.windows\rtsserver\0\vlua_ls\1\0\0\0\0\19setup_handlers\flibrary\1\0\0\fplugins\1\0\1\ntypes\2\1\2\0\0\16nvim-dap-ui\1\0\1\27automatic_installation\2\fservers\21ensure_installed\1\0\1\20automatic_setup\2\1\b\0\0\truff\fdebugpy\nblack\fyamlfmt\14prettierd\fcpplint\17clang-format\aui\1\0\0\nicons\1\0\3\22package_installed\b✓\24package_uninstalled\b✗\20package_pending\b⟳\1\0\1\vborder\frounded\nsetup\18mason-null-ls\blsp\20mason-lspconfig\vneodev\14lspconfig\nmason\frequire\0" },
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/mason.nvim",
    url = "https://github.com/williamboman/mason.nvim"
  },
  ["mini.move"] = {
    config = { "\27LJ\2\n�\1\0\0\4\0\b\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0025\3\6\0=\3\a\2B\0\2\1K\0\1\0\foptions\1\0\1\22reindent_linewise\2\rmappings\1\0\0\1\0\b\tleft\5\14line_left\5\aup\n<M-l>\tdown\n<M-k>\nright\5\fline_up\n<M-l>\15line_right\5\14line_down\n<M-k>\nsetup\14mini.move\frequire\0" },
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/mini.move",
    url = "https://github.com/echasnovski/mini.move"
  },
  ["neodev.nvim"] = {
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/neodev.nvim",
    url = "https://github.com/folke/neodev.nvim"
  },
  neogen = {
    config = { "\27LJ\2\n�\3\0\0\6\0\25\0!6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\a\0005\4\5\0005\5\4\0=\5\6\4=\4\b\0035\4\n\0005\5\t\0=\5\6\4=\4\v\0035\4\r\0005\5\f\0=\5\6\4=\4\14\0035\4\16\0005\5\15\0=\5\6\4=\4\17\0035\4\19\0005\5\18\0=\5\6\4=\4\20\0035\4\22\0005\5\21\0=\5\6\4=\4\23\3=\3\24\2B\0\2\1K\0\1\0\14languages\20typescriptreact\1\0\0\1\0\1\26annotation_convention\ntsdoc\15typescript\1\0\0\1\0\1\26annotation_convention\ntsdoc\15javascript\1\0\0\1\0\1\26annotation_convention\njsdoc\trust\1\0\0\1\0\1\26annotation_convention\frustdoc\vpython\1\0\0\1\0\1\26annotation_convention\22google_docstrings\blua\1\0\0\rtemplate\1\0\0\1\0\1\26annotation_convention\femmylua\1\0\2\19snippet_engine\fluasnip\fenabled\2\nsetup\vneogen\frequire\0" },
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/neogen",
    url = "https://github.com/danymat/neogen"
  },
  ["noice.nvim"] = {
    config = { "\27LJ\2\n�\18\0\0\b\0X\0�\0016\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\22\0005\3\3\0004\4\0\0=\4\4\0035\4\6\0005\5\5\0=\5\a\0045\5\b\0=\5\t\0045\5\n\0=\5\v\0045\5\f\0=\5\r\0045\5\15\0005\6\14\0=\6\16\5=\5\17\0045\5\18\0=\5\19\0044\5\0\0=\5\20\4=\4\21\3=\3\a\0025\3\23\0=\3\24\0025\3\25\0004\4\0\0=\4\26\3=\3\27\0024\3\5\0005\4\29\0005\5\28\0=\5\4\0045\5(\0004\6\v\0005\a\30\0>\a\1\0065\a\31\0>\a\2\0065\a \0>\a\3\0065\a!\0>\a\4\0065\a\"\0>\a\5\0065\a#\0>\a\6\0065\a$\0>\a\a\0065\a%\0>\a\b\0065\a&\0>\a\t\0065\a'\0>\a\n\6=\6)\5=\5\r\4>\4\1\0035\4*\0005\5/\0004\6\5\0005\a+\0>\a\1\0065\a,\0>\a\2\0065\a-\0>\a\3\0065\a.\0>\a\4\6=\6)\5=\5\r\0045\0050\0006\0061\0009\0062\0069\0063\0069\0064\6=\0065\5=\5\4\4>\4\2\0035\0046\0005\0057\0006\0061\0009\0062\0069\0063\0069\0068\6=\0065\5=\5\4\0045\5<\0004\6\4\0005\a9\0>\a\1\0065\a:\0>\a\2\0065\a;\0>\a\3\6=\6)\5=\5\r\4>\4\3\0035\4=\0005\5@\0004\6\3\0005\a>\0>\a\1\0065\a?\0>\a\2\6=\6)\5=\5\r\4>\4\4\3=\3A\0025\3C\0005\4B\0=\4D\0035\4E\0=\4F\0035\4G\0004\5\0\0=\5\4\4=\4H\0035\4I\0005\5J\0=\5K\0044\5\0\0=\5\4\4=\4L\0035\4M\0004\5\0\0=\5\4\4=\4N\0035\4O\0005\5P\0005\6Q\0=\6\21\0055\6R\0=\6S\5=\5\4\4=\4T\3=\3U\0025\3V\0=\3W\2B\0\2\1K\0\1\0\fpresets\1\0\5\18bottom_search\2\20command_palette\1\26long_message_to_split\2\15inc_rename\1\19lsp_doc_border\2\blsp\18documentation\16win_options\1\0\2\17conceallevel\3\3\18concealcursor\6n\1\2\0\0\14{message}\1\0\3\freplace\2\tlang\rmarkdown\vrender\nplain\1\0\1\tview\nhover\fmessage\1\0\2\tview\vnotify\fenabled\2\14signature\14auto_open\1\0\4\rthrottle\0032\ftrigger\2\fluasnip\2\fenabled\2\1\0\1\fenabled\1\nhover\1\0\1\fenabled\2\roverride\1\0\0031vim.lsp.util.convert_input_to_markdown_lines\2\"vim.lsp.util.stylize_markdown\2 cmp.entry.get_documentation\2\rprogress\1\0\0\1\0\1\fenabled\1\vroutes\1\0\0\1\0\2\nevent\vnotify\15max_height\3\1\1\0\2\nevent\rmsg_show\tfind\v^E486:\1\0\1\tview\tmini\1\0\0\1\0\2\nevent\rmsg_show\tfind\v^E%d+:\1\0\2\nevent\rmsg_show\tfind\v^Error\1\0\1\nerror\2\nERROR\1\0\3\ntitle\nError\nmerge\2\freplace\1\1\0\1\tview\vnotify\nlevel\tWARN\vlevels\blog\bvim\1\0\3\ntitle\fWarning\nmerge\1\freplace\1\1\0\0\1\0\2\nevent\rmsg_show\tfind\15^No hunks$\1\0\2\nevent\rmsg_show\tfind\v^W%d+:\1\0\2\nevent\rmsg_show\tfind\n^Warn\1\0\1\fwarning\2\1\0\1\tview\vnotify\bany\1\0\0\1\0\2\nevent\rmsg_show\tfind\30textDocument/foldingRange\1\0\2\nevent\vnotify\tfind\29No information available\1\0\2\nevent\rmsg_show\tfind\18%d+ more line\1\0\2\nevent\rmsg_show\tfind\r%d+ line\1\0\2\nevent\rmsg_show\tfind\15%d+ change\1\0\2\nevent\rmsg_show\tfind\20^Hunk %d+ of %d\1\0\2\nevent\rmsg_show\tfind\15%d+L, %d+B\1\0\2\nevent\rmsg_show\tkind\17search_count\1\0\2\nevent\rmsg_show\tfind\25%d+ lines, %d+ bytes\1\0\2\nevent\rmsg_show\tfind\fwritten\1\0\0\1\0\1\tskip\2\14popupmenu\15kind_icons\1\0\2\fenabled\2\fbackend\bnui\rmessages\1\0\6\fenabled\2\16view_search\16virtualtext\tview\vnotify\15view_error\vnotify\14view_warn\vnotify\17view_history\rmessages\1\0\0\vformat\ninput\thelp\1\0\2\ticon\b\fpattern\20^:%s*he?l?p?%s+\blua\fpattern\1\0\2\tlang\blua\ticon\b\1\4\0\0\16^:%s*lua%s+\20^:%s*lua%s*=%s*\14^:%s*=%s*\vfilter\1\0\3\fpattern\v^:%s*!\tlang\tbash\ticon\b\14search_up\1\0\4\tkind\vsearch\fpattern\b^%?\tlang\nregex\ticon\f \16search_down\1\0\4\tkind\vsearch\fpattern\a^/\tlang\nregex\ticon\f \fcmdline\1\0\0\1\0\3\fpattern\a^:\tlang\bvim\ticon\b\topts\1\0\2\tview\fcmdline\fenabled\2\nsetup\nnoice\frequire\0" },
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
    config = { "\27LJ\2\nz\0\0\5\0\b\0\f6\0\0\0009\0\1\0009\0\2\0009\0\3\0005\2\6\0006\3\0\0009\3\4\0039\3\5\3B\3\1\2=\3\a\2B\0\2\1K\0\1\0\nbufnr\1\0\1\15timeout_ms\3�\23\25nvim_get_current_buf\bapi\vformat\bbuf\blsp\bvim�\1\1\2\b\0\n\0\0159\2\0\0'\4\1\0B\2\2\2\15\0\2\0X\3\t�6\2\2\0009\2\3\0029\2\4\2'\4\5\0'\5\6\0003\6\a\0005\a\b\0=\1\t\aB\2\5\1K\0\1\0\vbuffer\1\0\1\tdesc\17[lsp] format\0\15<Leader>ff\6n\bset\vkeymap\bvim\28textDocument/formatting\20supports_method�\5\1\0\14\0%\1J6\0\0\0'\2\1\0B\0\2\0029\1\2\0009\2\3\0005\4!\0004\5\r\0009\6\4\0019\6\5\0069\6\6\0065\b\f\0005\t\a\0006\n\b\0009\n\t\n9\n\n\n'\f\v\0B\n\2\0?\n\0\0=\t\r\bB\6\2\2>\6\1\0059\6\14\0019\6\15\6>\6\2\0059\6\4\0019\6\16\6>\6\3\0059\6\17\0019\6\18\0069\6\6\0065\b\23\0005\t\19\0006\n\b\0009\n\t\n9\n\n\n6\f\b\0009\f\20\f9\f\21\f'\r\22\0&\f\r\fB\n\2\0?\n\0\0=\t\r\bB\6\2\2>\6\4\0059\6\4\0019\6\24\6>\6\5\0059\6\25\0019\6\26\6>\6\6\0059\6\4\0019\6\27\6>\6\a\0059\6\4\0019\6\28\6>\6\b\0059\6\4\0019\6\29\6>\6\t\0059\6\4\0019\6\30\6>\6\n\0059\6\4\0019\6\31\6>\6\v\0059\6\17\0019\6 \6>\6\f\5=\5\"\0043\5#\0=\5$\4B\2\2\1K\0\1\0\14on_attach\0\fsources\1\0\0\tfish\16fish_indent\fyamlfmt\ffixjson\16dart_format\17clang_format\reslint_d\17code_actions\14prettierd\1\0\0%/lua/lsp/linter-config/ruff.toml\fvim_dir\6g\1\2\0\0\r--config\truff\16diagnostics\nblack\fluasnip\15completion\15extra_args\1\0\0005~/.config/nvim/lua/lsp/linter-config/stylua.toml\vexpand\afn\bvim\1\2\0\0\18--config-path\twith\vstylua\15formatting\nsetup\rbuiltins\fnull-ls\frequire\5����\4\0" },
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/null-ls.nvim",
    url = "https://github.com/jose-elias-alvarez/null-ls.nvim"
  },
  ["nvim-autopairs"] = {
    config = { "\27LJ\2\n�\4\0\0\t\0\22\0\0266\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\5\0005\4\4\0=\4\6\0035\4\a\0=\4\b\3=\3\t\0025\3\n\0=\3\v\0025\3\f\0005\4\r\0=\4\14\0036\4\15\0009\4\16\4'\6\17\0'\a\18\0'\b\19\0B\4\4\2=\4\20\3=\3\21\2B\0\2\1K\0\1\0\14fast_wrap\fpattern\5\b%s+\25 [%'%\"%)%>%]%)%}%,] \tgsub\vstring\nchars\1\6\0\0\6{\6[\6(\6\"\6'\1\0\a\fend_key\6$\bmap\n<M-e>\tkeys\31qwertyuiopzxcvbnmasdfghjkl\16check_comma\2\19highlight_grey\vLineNr\14highlight\rPmenuSel\voffset\3\0\21disable_filetype\1\3\0\0\20TelescopePrompt\bvim\14ts_config\15javascript\1\3\0\0\vstring\20template_string\blua\1\0\1\tjava\1\1\3\0\0\vstring\vsource\1\0\3\24close_triple_quotes\2\30enable_check_bracket_line\2\rcheck_ts\2\nsetup\19nvim-autopairs\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/opt/nvim-autopairs",
    url = "https://github.com/windwp/nvim-autopairs"
  },
  ["nvim-cmp"] = {
    config = { "\27LJ\2\nV\0\1\6\1\5\0\v9\1\0\0\18\3\1\0009\1\1\1'\4\2\0'\5\3\0B\1\4\2-\2\0\0009\2\4\2\18\4\1\0B\2\2\1K\0\1\0\3�\15lsp_expand\v(${1})\t%b()\tgsub\tbody�\3\0\2\a\0\18\0.5\2\1\0009\3\2\0009\3\3\0038\2\3\2\14\0\2\0X\3\1�)\2\0\0=\2\0\0016\2\5\0'\4\6\0B\2\2\0029\2\a\0029\3\4\0018\2\3\2=\2\4\0016\2\b\0009\2\t\0025\4\n\0009\5\2\0009\5\3\5B\2\3\2\15\0\2\0X\3\14�6\2\5\0'\4\v\0B\2\2\0029\2\f\2\18\6\0\0009\4\r\0B\4\2\0029\4\14\4B\2\2\3\15\0\2\0X\4\3�=\2\4\1=\3\15\1L\1\2\0006\2\5\0'\4\16\0B\2\2\0029\2\17\2\18\4\0\0\18\5\1\0B\2\3\2\18\1\2\0L\1\2\0\20format_tailwind%plugins.cmp.utils.custom_formats\18kind_hl_group\nlabel\24get_completion_item\rget_icon\22nvim-web-devicons\1\2\0\0\tpath\17tbl_contains\bvim\flspkind\16utils.icons\frequire\tkind\tname\vsource\1\0\2\tpath\3\0\rnvim_lsp\3\0\bdup�\15\1\0\14\0N\0�\0016\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0026\2\0\0'\4\3\0B\2\2\0026\3\0\0'\5\4\0B\3\2\0029\4\5\0005\6\t\0005\a\a\0003\b\6\0=\b\b\a=\a\n\0066\a\0\0'\t\v\0B\a\2\2=\a\f\0069\a\r\0009\a\14\a4\t\6\0005\n\15\0006\v\0\0'\r\16\0B\v\2\2=\v\17\n>\n\1\t5\n\18\0>\n\2\t5\n\19\0>\n\3\t5\n\20\0>\n\4\t5\n\21\0>\n\5\tB\a\2\2=\a\14\0065\a\22\0=\a\23\0065\a\24\0004\b\n\0006\t\0\0'\v\25\0B\t\2\0029\t\26\t>\t\1\b6\t\0\0'\v\27\0B\t\2\0029\t\28\t>\t\2\b6\t\0\0'\v\29\0B\t\2\0029\t\30\t>\t\3\b9\t\r\0009\t\31\t9\t \t>\t\4\b9\t\r\0009\t\31\t9\t!\t>\t\5\b9\t\r\0009\t\31\t9\t\"\t>\t\6\b9\t\r\0009\t\31\t9\t#\t>\t\a\b9\t\r\0009\t\31\t9\t$\t>\t\b\b9\t\r\0009\t\31\t9\t%\t>\t\t\b=\b&\a=\a'\0065\a)\0005\b(\0=\b*\a9\b+\0025\n,\0006\v\0\0'\r-\0B\v\2\0029\v\3\v=\v.\n3\v/\0=\v0\nB\b\2\2=\b1\a=\a2\0065\a5\0009\b3\0019\b4\b=\b6\a=\a7\0065\a;\0009\b\r\0009\b8\b9\b9\b5\n:\0B\b\2\2=\b<\a9\b\r\0009\b8\b9\b9\b5\n=\0B\b\2\2=\b>\a=\a8\0065\a?\0004\b\0\0=\b@\a=\aA\0069\aB\0009\aC\a=\aD\0065\aE\0=\aF\6B\4\2\0019\4\5\0009\4G\4'\6H\0005\aK\0009\b\r\0009\b\14\b4\n\3\0005\vI\0>\v\1\n4\v\3\0005\fJ\0>\f\1\vB\b\3\2=\b\14\aB\4\3\0016\4\0\0'\6L\0B\4\2\0029\4\5\4B\4\1\0016\4\0\0'\6M\0B\4\2\0029\4\5\4B\4\1\0012\0\0�K\0\1\0\24plugins.cmp.cmdline\24plugins.cmp.copilot\1\0\0\1\0\1\tname\vbuffer\1\0\1\tname\24conventionalcommits\14gitcommit\rfiletype\tview\1\0\1\fentries\vcustom\14preselect\tItem\18PreselectMode\17experimental\15ghost_text\1\0\0\18documentation\1\0\1\17winhighlight7Normal:TelescopeNormal,FloatBorder:TelescopeBorder\15completion\1\0\0\1\0\4\17winhighlight7Normal:TelescopeNormal,FloatBorder:TelescopeBorder\vborder\frounded\17side_padding\3\0\15col_offset\3����\15\rbordered\vwindow\17confirm_opts\rbehavior\1\0\1\vselect\2\fReplace\20ConfirmBehavior\15formatting\vformat\vbefore\0\15symbol_map\16utils.icons\1\0\2\14max_width\0032\tmode\16symbol_text\15cmp_format\vfields\1\0\0\1\4\0\0\tkind\tabbr\tmenu\fsorting\16comparators\norder\14sort_text\tkind\voffset\nexact\nscore\fcompare\nunder\25cmp-under-comparator\24prioritizeVariables\"plugins.cmp.utils.comparators\15prioritize\28copilot_cmp.comparators\1\0\1\20priority_weight\3\2\15duplicates\1\0\4\rnvim_lsp\3\0\vbuffer\3\1\fluasnip\3\0\tpath\3\1\1\0\4\tname\tpath\rpriority\3�\1\16group_index\3\1\19max_item_count\3\4\1\0\5\16group_index\3\2\19keyword_length\3\4\rpriority\3�\3\tname\vbuffer\19max_item_count\3\5\1\0\5\16group_index\3\1\19keyword_length\3\2\rpriority\3�\5\tname\fluasnip\19max_item_count\3\5\1\0\4\tname\fcopilot\rpriority\3�\a\16group_index\3\1\19keyword_length\3\0\17entry_filter&plugins.cmp.utils.limit_lsp_types\1\0\3\tname\rnvim_lsp\rpriority\3�\a\16group_index\3\1\fsources\vconfig\fmapping\25plugins.cmp.mappings\fsnippet\1\0\0\vexpand\1\0\0\0\nsetup\fluasnip\flspkind\18cmp.types.cmp\bcmp\frequire\0" },
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-colorizer.lua"] = {
    config = { "\27LJ\2\n�\2\0\0\6\0\14\0\0176\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0025\3\6\0=\3\a\0025\3\b\0005\4\t\0005\5\n\0=\5\v\4=\4\f\3=\3\r\2B\0\2\1K\0\1\0\25user_default_options\tsass\fparsers\1\2\0\0\bcss\1\0\1\venable\1\1\0\n\bRGB\2\vRRGGBB\2\nnames\2\rRRGGBBAA\2\rAARRGGBB\2\vrgb_fn\2\vhsl_fn\2\bcss\2\vcss_fn\2\tmode\15background\14filetypes\1\4\0\0\6*\14!NvimTree\15!gitcommit\fbuftype\1\0\0\1\4\0\0\6*\f!prompt\f!nofile\nsetup\14colorizer\frequire\0" },
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/nvim-colorizer.lua",
    url = "https://github.com/norcalli/nvim-colorizer.lua"
  },
  ["nvim-dap"] = {
    config = { "\27LJ\2\n�\5\0\0\5\0\25\00085\0\6\0005\1\4\0006\2\0\0009\2\1\0029\2\2\0029\2\3\2=\2\5\1=\1\a\0005\1\b\0006\2\0\0009\2\1\0029\2\2\0029\2\3\2=\2\5\1=\1\t\0005\1\f\0006\2\0\0009\2\1\0029\2\n\0029\2\v\2=\2\5\1=\1\r\0006\1\14\0009\1\15\0019\1\16\1'\3\17\0009\4\a\0B\1\3\0016\1\14\0009\1\15\0019\1\16\1'\3\18\0009\4\r\0B\1\3\0016\1\14\0009\1\15\0019\1\16\1'\3\19\0009\4\t\0B\1\3\0016\1\20\0'\3\21\0B\1\2\0029\1\22\1B\1\1\0016\1\20\0'\3\23\0B\1\2\0029\1\22\1B\1\1\0016\1\20\0'\3\24\0B\1\2\0029\1\22\1B\1\1\1K\0\1\0\31plugins.debug.virtual-text\29plugins.debug.dap-python\nsetup\21plugins.debug.ui\frequire\26DapBreakpointRejected\15DapStopped\18DapBreakpoint\16sign_define\afn\bvim\fstopped\1\0\3\vtexthl\"LspDiagnosticsSignInformation\nnumhl\"LspDiagnosticsSignInformation\vlinehl\28DiagnosticUnderlineInfo\19BoldArrowRight\aui\rrejected\1\0\3\vtexthl\27LspDiagnosticsSignHint\nnumhl\5\vlinehl\5\15breakpoint\1\0\0\ttext\1\0\3\vtexthl\28LspDiagnosticsSignError\nnumhl\5\vlinehl\5\bbug\tbase\nicons\nutils\0" },
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/nvim-dap",
    url = "https://github.com/mfussenegger/nvim-dap"
  },
  ["nvim-dap-python"] = {
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/nvim-dap-python",
    url = "https://github.com/mfussenegger/nvim-dap-python"
  },
  ["nvim-dap-ui"] = {
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/nvim-dap-ui",
    url = "https://github.com/rcarriga/nvim-dap-ui"
  },
  ["nvim-dap-virtual-text"] = {
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/nvim-dap-virtual-text",
    url = "https://github.com/theHamsta/nvim-dap-virtual-text"
  },
  ["nvim-hlslens"] = {
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/nvim-hlslens",
    url = "https://github.com/kevinhwang91/nvim-hlslens"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-navbuddy"] = {
    config = { "\27LJ\2\nk\0\0\t\0\5\0\0166\0\0\0'\2\1\0B\0\2\0029\0\2\0004\1\0\0006\2\3\0\18\4\0\0B\2\2\4H\5\4�\18\a\6\0'\b\4\0&\a\b\a<\a\5\1F\5\3\3R\5�\127L\1\2\0\6 \npairs\flspkind\16utils.icons\frequire�\t\1\0\v\0O\0s6\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0023\2\3\0009\3\4\0005\5\14\0005\6\5\0005\a\a\0005\b\6\0=\b\b\a5\b\t\0=\b\n\a5\b\v\0=\b\f\a=\a\r\6=\6\15\0055\6\16\0005\a\17\0=\a\18\6=\6\19\5\18\6\2\0B\6\1\2=\6\18\0055\6\21\0009\a\20\1B\a\1\2=\a\22\0069\a\20\1B\a\1\2=\a\23\0069\a\24\1B\a\1\2=\a\25\0069\a\26\1B\a\1\2=\a\27\0069\a\28\1B\a\1\2=\a\29\0069\a\30\1B\a\1\2=\a\31\0069\a \1B\a\1\2=\a!\0069\a\"\1B\a\1\2=\a#\0069\a$\1B\a\1\2=\a%\0069\a&\1B\a\1\2=\a'\0069\a(\1B\a\1\2=\a)\0069\a*\1B\a\1\2=\a+\0069\a,\1B\a\1\2=\a-\0069\a.\1B\a\1\2=\a/\0069\a0\1B\a\1\2=\a1\0069\a2\1B\a\1\2=\a3\0069\a4\1B\a\1\2=\a5\0069\a6\1B\a\1\2=\a7\0069\a8\1B\a\1\2=\a9\0069\a:\1B\a\1\2=\a;\0069\a<\1B\a\1\2=\a=\0069\a<\1B\a\1\2=\a>\0069\a?\1B\a\1\2=\a@\0069\aA\1B\a\1\2=\aB\0069\aC\0015\tE\0005\nD\0=\nF\tB\a\2\2=\aG\0069\aH\1B\a\1\2=\aI\6=\6J\0055\6K\0=\6L\0055\6M\0=\6N\5B\3\2\1K\0\1\0\18source_buffer\1\0\3\14highlight\2\16follow_node\2\rreorient\nsmart\blsp\1\0\1\16auto_attach\2\rmappings\6?\thelp\6t\18layout_config\1\0\1\20layout_strategy\15horizontal\1\0\4\18preview_width\4\0����\3\nwidth\4��̙\3���\3\vheight\4��̙\3���\3\20prompt_position\btop\14telescope\n<A-l>\fmove_up\n<A-k>\14move_down\6o\f<enter>\vselect\6c\fcomment\6F\16fold_delete\6f\16fold_create\6d\vdelete\6r\vrename\6A\17append_scope\6a\16append_name\6I\17insert_scope\6i\16insert_name\6Y\15yank_scope\6y\14yank_name\6V\17visual_scope\6v\16visual_name\0060\troot\aç\rchildren\6j\vparent\6l\21previous_sibling\6k\17next_sibling\6q\n<esc>\1\0\0\nclose\17node_markers\nicons\1\0\3\18leaf_selected\n → \vbranch\t \tleaf\a  \1\0\1\fenabled\2\vwindow\1\0\1\25use_default_mappings\1\rsections\nright\1\0\1\fpreview\tleaf\bmid\1\0\1\tsize\b40%\tleft\1\0\0\1\0\1\tsize\b20%\1\0\3\vborder\vsingle\tsize\b60%\rposition\b50%\nsetup\0\26nvim-navbuddy.actions\18nvim-navbuddy\frequire\0" },
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/nvim-navbuddy",
    url = "https://github.com/SmiteshP/nvim-navbuddy"
  },
  ["nvim-navic"] = {
    config = { "\27LJ\2\n�\a\0\0\b\0.\0�\0016\0\0\0'\2\1\0B\0\2\0029\1\2\0006\2\0\0'\4\3\0B\2\2\0029\2\4\0025\4)\0005\5\a\0009\6\5\1'\a\6\0&\6\a\6=\6\5\0059\6\b\1=\6\b\0059\6\t\1'\a\6\0&\6\a\6=\6\t\0059\6\n\1'\a\6\0&\6\a\6=\6\n\0059\6\v\1'\a\6\0&\6\a\6=\6\v\0059\6\f\1'\a\6\0&\6\a\6=\6\f\0059\6\r\1'\a\6\0&\6\a\6=\6\r\0059\6\14\1'\a\6\0&\6\a\6=\6\14\0059\6\15\1'\a\6\0&\6\a\6=\6\15\0059\6\16\1'\a\6\0&\6\a\6=\6\16\0059\6\17\1'\a\6\0&\6\a\6=\6\17\0059\6\18\1'\a\6\0&\6\a\6=\6\18\0059\6\19\1'\a\6\0&\6\a\6=\6\19\0059\6\20\1'\a\6\0&\6\a\6=\6\20\0059\6\21\1'\a\6\0&\6\a\6=\6\21\0059\6\22\1'\a\6\0&\6\a\6=\6\22\0059\6\23\1'\a\6\0&\6\a\6=\6\23\0059\6\24\1'\a\6\0&\6\a\6=\6\24\0059\6\25\1'\a\6\0&\6\a\6=\6\25\0059\6\26\1'\a\6\0&\6\a\6=\6\26\0059\6\27\1'\a\6\0&\6\a\6=\6\27\0059\6\28\1'\a\6\0&\6\a\6=\6\28\0059\6\29\1'\a\6\0&\6\a\6=\6\29\0059\6\30\1'\a\6\0&\6\a\6=\6\30\0059\6\31\1'\a\6\0&\6\a\6=\6\31\0059\6 \1'\a\6\0&\6\a\6=\6 \0059\6!\1'\a\6\0&\6\a\6=\6!\0059\6\"\1'\a\6\0&\6\a\6=\6\"\0059\6#\1'\a\6\0&\6\a\6=\6#\0059\6$\1'\a\6\0&\6\a\6=\6$\0059\6%\1'\a\6\0&\6\a\6=\6%\0059\6&\1'\a\6\0&\6\a\6=\6&\0059\6'\1'\a\6\0&\6\a\6=\6'\0059\6(\1'\a\6\0&\6\a\6=\6(\5=\5*\4'\5\6\0009\6+\0009\6,\6'\a\6\0&\5\a\5=\5-\4B\2\2\1K\0\1\0\14separator\17ChevronRight\aui\nicons\1\0\3\26depth_limit_indicator\a..\14highlight\2\16depth_limit\3\4\rVariable\nValue\tUnit\18TypeParameter\tText\vStruct\vString\fSnippet\14Reference\rProperty\fPackage\rOperator\vObject\vNumber\tNull\14Namespace\vModule\vMethod\fKeyword\bKey\14Interface\rFunction\vFolder\tFile\nField\nEvent\15EnumMember\tEnum\16Constructor\rConstant\nColor\nClass\fBoolean\1\0\0\6 \nArray\nsetup\15nvim-navic\flspkind\16utils.icons\frequire\0" },
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/nvim-navic",
    url = "https://github.com/SmiteshP/nvim-navic"
  },
  ["nvim-neoclip.lua"] = {
    config = { "\27LJ\2\n�\4\0\0\a\0\21\0\0276\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\0025\3\6\0=\3\a\0025\3\b\0=\3\t\0025\3\n\0=\3\v\0025\3\18\0005\4\14\0005\5\f\0004\6\0\0=\6\r\5=\5\15\0045\5\16\0004\6\0\0=\6\r\5=\5\17\4=\4\19\3=\3\20\2B\0\2\1K\0\1\0\tkeys\14telescope\1\0\0\6n\1\0\6\npaste\6p\tedit\6e\vselect\t<cr>\vdelete\6d\17paste_behind\6P\vreplay\6q\6i\1\0\0\vcustom\1\0\6\npaste\n<c-p>\tedit\n<c-e>\vselect\t<cr>\vdelete\n<c-d>\17paste_behind\n<c-k>\vreplay\n<c-q>\21on_custom_action\1\0\1\20close_telescope\2\14on_replay\1\0\3\fset_reg\1\20close_telescope\2\18move_to_front\1\ron_paste\1\0\3\fset_reg\1\20close_telescope\2\18move_to_front\1\14on_select\1\0\2\20close_telescope\2\18move_to_front\1\1\0\6\fhistory\0032\24content_spec_column\1\fpreview\2\21default_register\6\"\28default_register_macros\6q\25enable_macro_history\2\nsetup\fneoclip\frequire\0" },
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/nvim-neoclip.lua",
    url = "https://github.com/AckslD/nvim-neoclip.lua"
  },
  ["nvim-notify"] = {
    config = { "\27LJ\2\n�\2\0\0\a\0\19\0\0276\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0029\2\3\0005\4\4\0005\5\a\0009\6\5\0019\6\6\6=\6\b\0059\6\5\0019\6\t\6=\6\n\0059\6\5\0019\6\v\6=\6\f\0059\6\r\0019\6\14\6=\6\15\0059\6\r\0019\6\16\6=\6\17\5=\5\18\4B\2\2\1K\0\1\0\nicons\nTRACE\vPencil\nDEBUG\bBug\aui\tINFO\16Information\tWARN\fWarning\nERROR\1\0\0\nError\16diagnostics\1\0\b\22background_colour\f#121212\rtop_down\2\14max_width\3x\vstages\22fade_in_slide_out\nlevel\3\2\ftimeout\3�\15\bfpg\3\30\vrender\fdefault\nsetup\16utils.icons\vnotify\frequire\0" },
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/nvim-notify",
    url = "https://github.com/rcarriga/nvim-notify"
  },
  ["nvim-numbertoggle"] = {
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/nvim-numbertoggle",
    url = "https://github.com/sitiom/nvim-numbertoggle"
  },
  ["nvim-scrollbar"] = {
    config = { "\27LJ\2\n\v\0\0\1\0\0\0\1K\0\1\0�\b\1\0\b\0/\0A6\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0029\1\3\1B\1\1\0026\2\0\0'\4\4\0B\2\2\0029\2\3\0025\4\6\0003\5\5\0=\5\a\4B\2\2\0016\2\0\0'\4\b\0B\2\2\0029\2\3\0025\4\t\0005\5\n\0=\5\v\0045\5\r\0005\6\f\0=\6\14\0055\6\16\0005\a\15\0=\a\17\0069\a\18\0=\a\19\6=\6\20\0055\6\22\0005\a\21\0=\a\17\6=\6\23\0055\6\25\0005\a\24\0=\a\17\6=\6\26\0055\6\28\0005\a\27\0=\a\17\6=\6\29\0055\6\31\0005\a\30\0=\a\17\6=\6 \0055\6\"\0005\a!\0=\a\17\6=\6#\5=\5$\0045\5%\0=\5&\0045\5'\0=\5(\0045\5*\0005\6)\0=\6+\5=\5,\0045\5-\0=\5.\4B\2\2\1K\0\1\0\rhandlers\1\0\3\vcursor\2\15diagnostic\2\vsearch\2\fautocmd\vrender\1\0\0\1\b\0\0\16BufWinEnter\rTabEnter\14TermEnter\rWinEnter\16CmdwinLeave\15VimResized\16WinScrolled\23excluded_filetypes\1\3\0\0\vprompt\20TelescopePrompt\22excluded_buftypes\1\2\0\0\rterminal\nmarks\tMisc\1\0\2\rpriority\3\6\14highlight\vNormal\1\3\0\0\6-\6=\tHint\1\0\2\rpriority\3\5\14highlight\30DiagnosticVirtualTextHint\1\3\0\0\6-\6=\tInfo\1\0\2\rpriority\3\4\14highlight\30DiagnosticVirtualTextInfo\1\3\0\0\6-\6=\tWarn\1\0\2\rpriority\3\3\14highlight\30DiagnosticVirtualTextWarn\1\3\0\0\6-\6=\nError\1\0\2\rpriority\3\2\14highlight\31DiagnosticVirtualTextError\1\3\0\0\6-\6=\vSearch\ncolor\14secondary\ttext\1\0\2\rpriority\3\1\14highlight\vSearch\1\2\0\0\6-\vCursor\1\0\0\1\0\3\ttext\b•\14highlight\vNormal\rpriority\3\0\vhandle\1\0\4\ttext\6 \14highlight\17CursorColumn\24hide_if_all_visible\2\nblend\3\30\1\0\2\tshow\2\19set_highlights\2\14scrollbar\18override_lens\1\0\0\0\30scrollbar.handlers.search\nsetup\22tokyonight.colors\17utils.colors\frequire\0" },
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/nvim-scrollbar",
    url = "https://github.com/petertriho/nvim-scrollbar"
  },
  ["nvim-tree.lua"] = {
    config = { "\27LJ\2\n7\0\1\5\0\4\0\a6\1\0\0009\1\1\1'\3\2\0009\4\3\0&\3\4\3B\1\2\1K\0\1\0\nfname\nedit \bcmd\bvim�\3\0\1\t\1\19\1J5\1\0\0006\2\1\0009\2\2\0029\2\3\0029\4\4\0B\2\2\2\b\2\0\0X\2\2�+\2\1\0X\3\1�+\2\2\0009\3\4\0\a\3\5\0X\3\a�6\3\1\0009\3\6\0039\4\a\0008\3\4\0039\3\b\3\6\3\5\0X\3\2�+\3\1\0X\4\1�+\3\2\0006\4\1\0009\4\6\0049\5\a\0008\4\5\0049\4\t\4\14\0\2\0X\5\3�\14\0\3\0X\5\1�K\0\1\0006\5\1\0009\5\n\5\18\a\1\0\18\b\4\0B\5\3\2\15\0\5\0X\6\1�K\0\1\0006\5\1\0009\5\2\0059\5\v\0059\a\4\0B\5\2\2\b\5\0\0X\5\2�+\5\1\0X\6\1�+\5\2\0\15\0\5\0X\6\14�6\6\1\0009\6\f\0069\6\r\6B\6\1\0016\6\1\0009\6\f\0069\6\14\0069\b\a\0B\6\2\0016\6\1\0009\6\f\0069\6\15\0069\b\4\0B\6\2\1-\6\0\0009\6\16\0069\6\17\0065\b\18\0B\6\2\1K\0\1\0\2�\1\0\2\14find_file\2\nfocus\1\vtoggle\ttree\acd\abw\tenew\bcmd\16isdirectory\17tbl_contains\aft\fbuftype\bbuf\abo\5\tfile\17filereadable\afn\bvim\1\2\0\0\14gitcommit\2%\0\1\2\1\0\0\a-\1\0\0\5\0\1\0X\1\2�+\1\1\0X\2\1�+\1\2\0L\1\2\0\0��\1\0\0\4\1\6\1\0206\0\0\0009\0\1\0009\0\2\0B\0\1\2\21\0\0\0\t\0\0\0X\0\1�X\0\v�6\0\0\0009\0\3\0'\2\4\0B\0\2\0016\0\0\0009\0\1\0009\0\5\0-\2\0\0:\2\1\2+\3\2\0B\0\3\1K\0\1\0\4�\19nvim_win_close\17NvimTreeOpen\bcmd\19nvim_list_wins\bapi\bvim\2�\3\1\1\v\1\18\1H6\1\0\0009\1\1\0019\1\2\1\18\3\0\0B\1\2\0026\2\0\0009\2\1\0029\2\3\2\18\4\0\0B\2\2\0026\3\0\0009\3\4\0039\3\5\3\18\5\2\0B\3\2\2:\3\1\0036\4\0\0009\4\6\0043\6\a\0006\a\0\0009\a\1\a9\a\b\a\18\t\1\0B\a\2\0A\4\1\0026\5\0\0009\5\t\0056\a\0\0009\a\1\a9\a\3\a\18\b\4\0B\5\3\0029\6\n\3\18\b\6\0009\6\v\6'\t\f\0B\6\3\2\15\0\6\0X\a\v�6\6\0\0009\6\r\6\18\b\5\0B\6\2\2\14\0\6\0X\6\25�-\6\0\0009\6\14\0069\6\15\6B\6\1\1X\6\20�\21\6\5\0\t\6\0\0X\6\17�6\6\0\0009\6\4\0069\6\5\6:\b\1\5B\6\2\2:\6\1\0069\a\n\6\18\t\a\0009\a\v\a'\n\f\0B\a\3\2\15\0\a\0X\b\4�6\a\0\0009\a\16\a3\t\17\0B\a\2\0012\0\0�K\0\1\0\2�\0\rschedule\nclose\ttree\16tbl_isempty\20.*NvimTree_%d*$\nmatch\tname\ftbl_map\27nvim_tabpage_list_wins\0\15tbl_filter\15getbufinfo\afn\21nvim_win_get_buf\25nvim_win_get_tabpage\bapi\bvim\2y\0\0\a\1\a\0\0156\0\0\0006\2\1\0009\2\2\0029\2\3\2'\4\4\0B\2\2\0A\0\0\0026\1\1\0009\1\5\0016\3\6\0-\5\0\0\18\6\0\0B\3\3\0A\1\0\1K\0\1\0\4�\npcall\18schedule_wrap\r<amatch>\vexpand\afn\bvim\rtonumber�\1\0\0\4\2\a\0\17-\0\0\0009\0\0\0B\0\1\2\v\0\0\0X\1\1�K\0\1\0006\1\1\0009\1\2\1'\3\3\0B\1\2\1-\1\1\0009\1\4\0019\1\5\0019\1\6\1\18\3\0\0B\1\2\1K\0\1\0\1�\2�\btab\topen\tnode\rwincmd l\bcmd\bvim\23get_node_at_cursorX\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\afn2nvim-tree.actions.tree-modifiers.collapse-all\frequirem\0\0\4\1\3\0\14-\0\0\0009\0\0\0B\0\1\2\v\0\0\0X\1\1�K\0\1\0009\1\1\0\n\1\0\0X\1\4�-\1\0\0009\1\2\1\18\3\0\0B\1\2\1K\0\1\0\1�\23expand_or_collapse\nnodes\23get_node_at_cursor�\1\0\0\6\1\14\0\31-\0\0\0009\0\0\0B\0\1\0029\1\1\0009\1\2\1\6\1\3\0X\2\6�\6\1\4\0X\2\4�\6\1\5\0X\2\2�\a\1\6\0X\2\a�6\2\a\0009\2\b\2'\4\t\0009\5\n\0&\4\5\4B\2\2\1X\2\n�\6\1\v\0X\2\2�\a\1\f\0X\2\6�6\2\a\0009\2\b\2'\4\r\0009\5\n\0&\4\5\4B\2\2\1K\0\1\0\1�\"silent !git restore --staged \aA \aM \18absolute_path\21silent !git add \bcmd\bvim\a M\aAM\aMM\a??\tfile\15git_status\23get_node_at_cursorS\0\1\4\1\6\0\v-\1\0\0009\1\0\0019\1\1\0019\1\2\1\18\3\0\0B\1\2\0016\1\3\0009\1\4\0019\1\5\1B\1\1\1K\0\1\0\2�\ftabprev\bcmd\bvim\btab\topen\tnode]\0\1\4\1\4\0\b5\1\1\0'\2\0\0\18\3\0\0&\2\3\2=\2\2\1-\2\0\0=\2\3\1L\1\2\0\0�\vbuffer\tdesc\1\0\3\vsilent\2\vnowait\2\fnoremap\2\16nvim-tree: �\17\1\1\n\6]\0�\0023\1\0\0006\2\1\0009\2\2\0029\2\3\2'\4\4\0'\5\5\0-\6\0\0009\6\6\0069\6\a\0069\6\b\6\18\a\1\0'\t\t\0B\a\2\0A\2\3\0016\2\1\0009\2\2\0029\2\3\2'\4\4\0'\5\n\0-\6\1\0\18\a\1\0'\t\v\0B\a\2\0A\2\3\0016\2\1\0009\2\2\0029\2\3\2'\4\4\0'\5\f\0-\6\2\0\18\a\1\0'\t\r\0B\a\2\0A\2\3\0016\2\1\0009\2\2\0029\2\3\2'\4\4\0'\5\14\0-\6\0\0009\6\6\0069\6\15\0069\6\16\6\18\a\1\0'\t\17\0B\a\2\0A\2\3\0016\2\1\0009\2\2\0029\2\3\2'\4\4\0'\5\18\0-\6\3\0\18\a\1\0'\t\19\0B\a\2\0A\2\3\0016\2\1\0009\2\2\0029\2\3\2'\4\4\0'\5\20\0-\6\4\0\18\a\1\0'\t\21\0B\a\2\0A\2\3\0016\2\1\0009\2\2\0029\2\3\2'\4\4\0'\5\22\0-\6\5\0\18\a\1\0'\t\23\0B\a\2\0A\2\3\0016\2\1\0009\2\2\0029\2\3\2'\4\4\0'\5\24\0-\6\0\0009\6\6\0069\6\a\0069\6\25\6\18\a\1\0'\t\26\0B\a\2\0A\2\3\0016\2\1\0009\2\2\0029\2\3\2'\4\4\0'\5\27\0-\6\0\0009\6\6\0069\6\a\0069\6\28\6\18\a\1\0'\t\29\0B\a\2\0A\2\3\0016\2\1\0009\2\2\0029\2\3\2'\4\4\0'\5\30\0-\6\0\0009\6\6\0069\6\15\0069\6\31\6\18\a\1\0'\t \0B\a\2\0A\2\3\0016\2\1\0009\2\2\0029\2\3\2'\4\4\0'\5!\0-\6\0\0009\6\6\0069\6\a\0069\6\"\6\18\a\1\0'\t#\0B\a\2\0A\2\3\0016\2\1\0009\2\2\0029\2\3\2'\4\4\0'\5$\0-\6\0\0009\6\6\0069\6\15\0069\6%\0069\6&\6\18\a\1\0'\t'\0B\a\2\0A\2\3\0016\2\1\0009\2\2\0029\2\3\2'\4\4\0'\5(\0-\6\0\0009\6\6\0069\6\15\0069\6%\0069\6)\6\18\a\1\0'\t*\0B\a\2\0A\2\3\0016\2\1\0009\2\2\0029\2\3\2'\4\4\0'\5+\0-\6\0\0009\6,\0069\6-\6\18\a\1\0'\t.\0B\a\2\0A\2\3\0016\2\1\0009\2\2\0029\2\3\2'\4\4\0'\5/\0-\6\0\0009\6,\0069\0060\6\18\a\1\0'\t1\0B\a\2\0A\2\3\0016\2\1\0009\2\2\0029\2\3\2'\4\4\0'\0052\0-\6\0\0009\0063\0069\0064\6\18\a\1\0'\t5\0B\a\2\0A\2\3\0016\2\1\0009\2\2\0029\2\3\2'\4\4\0'\0056\0-\6\0\0009\0063\0069\0067\6\18\a\1\0'\t8\0B\a\2\0A\2\3\0016\2\1\0009\2\2\0029\2\3\2'\4\4\0'\0059\0-\6\0\0009\0063\0069\6:\6\18\a\1\0'\t;\0B\a\2\0A\2\3\0016\2\1\0009\2\2\0029\2\3\2'\4\4\0'\5<\0-\6\0\0009\0063\0069\6=\6\18\a\1\0'\t>\0B\a\2\0A\2\3\0016\2\1\0009\2\2\0029\2\3\2'\4\4\0'\5?\0-\6\0\0009\0063\0069\6@\0069\6\6\6\18\a\1\0'\tA\0B\a\2\0A\2\3\0016\2\1\0009\2\2\0029\2\3\2'\4\4\0'\5B\0-\6\0\0009\0063\0069\6C\6\18\a\1\0'\tD\0B\a\2\0A\2\3\0016\2\1\0009\2\2\0029\2\3\2'\4\4\0'\5E\0-\6\0\0009\0063\0069\6@\0069\6F\6\18\a\1\0'\tG\0B\a\2\0A\2\3\0016\2\1\0009\2\2\0029\2\3\2'\4\4\0'\5H\0-\6\0\0009\0063\0069\6@\0069\6I\6\18\a\1\0'\tJ\0B\a\2\0A\2\3\0016\2\1\0009\2\2\0029\2\3\2'\4\4\0'\5K\0-\6\0\0009\0063\0069\6@\0069\6L\6\18\a\1\0'\tM\0B\a\2\0A\2\3\0016\2\1\0009\2\2\0029\2\3\2'\4\4\0'\5N\0-\6\0\0009\6\6\0069\6\15\0069\6O\0069\6P\6\18\a\1\0'\tQ\0B\a\2\0A\2\3\0016\2\1\0009\2\2\0029\2\3\2'\4\4\0'\5R\0-\6\0\0009\6\6\0069\6\15\0069\6O\0069\6S\6\18\a\1\0'\tT\0B\a\2\0A\2\3\0016\2\1\0009\2\2\0029\2\3\2'\4\4\0'\5U\0-\6\0\0009\6,\0069\6V\6\18\a\1\0'\tW\0B\a\2\0A\2\3\0016\2\1\0009\2\2\0029\2\3\2'\4\4\0'\5X\0-\6\0\0009\6,\0069\6Y\6\18\a\1\0'\tZ\0B\a\2\0A\2\3\0016\2\1\0009\2\2\0029\2\3\2'\4\4\0'\5[\0-\6\0\0009\6\6\0069\6\a\0069\6\25\6\18\a\1\0'\t\26\0B\a\2\0A\2\3\0016\2\1\0009\2\2\0029\2\3\2'\4\4\0'\5\\\0-\6\0\0009\6\6\0069\6\a\0069\6\28\6\18\a\1\0'\t\29\0B\a\2\0A\2\3\0012\0\0�K\0\1\0\2�\5�\a�\6�\b�\t�\6h\6v\tHelp\16toggle_help\6?\nClose\nclose\6q\rNext Git\tnext\a]c\rPrev Git\tprev\bgit\a[c\23Copy Absolute Path\18absolute_path\agy\23Copy Relative Path\18relative_path\6Y\14Copy Name\rfilename\6y\nPaste\npaste\6p\tCopy\tcopy\6c\bCut\bcut\6x\vRename\vrename\6r\vDelete\vremove\6d\vCreate\vcreate\afs\6a\fRefresh\vreload\6R\20Toggle Dotfiles\25toggle_hidden_filter\ttree\6H\17Last Sibling\tlast\6K\18First Sibling\nfirst\fsibling\6L\17Open Preview\fpreview\n<Tab>\21Parent Directory\vparent\6P\27Open: Horizontal Split\15horizontal\n<C-x>\25Open: Vertical Split\rvertical\n<C-v>\20open_tab_silent\6T\fgit_add\aga\rCollapse\6J\20Close Directory\17parent_close\rnavigate\6j\vexpand\aç\23swap_then_open_tab\6t\27Open: No Window Picker\21no_window_picker\topen\tnode\6o\6n\bset\vkeymap\bvim\0�\17\1\0\19\0|\0�\0016\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0026\2\0\0'\4\3\0B\2\2\0029\3\4\0029\3\5\0039\5\4\0029\5\6\0059\5\a\0053\6\b\0B\3\3\0013\3\t\0006\4\n\0009\4\v\0049\4\f\4'\6\r\0005\a\14\0=\3\15\aB\4\3\0013\4\16\0006\5\n\0009\5\v\0059\5\f\5'\a\17\0005\b\19\0003\t\18\0=\t\15\bB\5\3\0013\5\20\0003\6\21\0003\a\22\0003\b\23\0003\t\24\0006\n\0\0'\f\25\0B\n\2\0029\v\26\0005\r \0005\14\30\0005\15\27\0005\16\28\0=\16\29\15=\15\31\14=\14!\r5\14%\0006\15\n\0009\15\"\0159\15#\0159\15$\15=\15&\14=\14'\r5\14(\0005\15+\0009\16)\n9\16*\16=\16,\0159\16)\n9\16-\16=\16.\0159\16)\n9\16/\16=\0160\0159\16)\n9\0161\16=\0162\15=\0153\14=\14)\r3\0144\0=\0145\r5\0146\0005\0157\0=\0158\0145\15`\0005\16;\0009\0179\n9\17:\17=\17<\0169\0179\n9\17=\17=\17>\0169\0179\n9\17?\17=\17@\0165\17B\0009\0189\n9\18A\18=\18C\0179\0189\n9\18D\18=\18E\0179\0189\n9\18F\18=\18<\0179\0189\n9\18G\18=\18H\0179\0189\n9\18I\18=\18J\0179\0189\n9\18K\18=\18L\0179\0189\n9\18M\18=\18>\0179\0189\n9\18G\18=\18N\17=\17O\0165\17R\0009\18P\n9\18Q\18=\18S\0179\18P\n9\18T\18=\18U\0179\18P\n9\18V\18=\18W\0179\18P\n9\18X\18=\18Y\0179\18P\n9\18Z\18=\18[\0179\18P\n9\18\\\18=\18]\0179\18P\n9\18^\18=\18_\17=\17P\16=\16a\15=\0153\14=\14b\r5\14c\0=\14d\r5\14e\0005\15f\0=\15g\14=\14h\r5\14i\0004\15\0\0=\15j\14=\14k\r5\14l\0005\15m\0=\15n\0144\15\0\0=\15o\14=\14p\r5\14q\0=\14P\r5\14r\0005\15s\0=\15t\0145\15u\0=\15v\14=\14w\r5\14x\0=\14y\r5\14z\0=\14{\rB\v\2\0012\0\0�K\0\1\0\ntrash\1\0\2\bcmd\ntrash\20require_confirm\2\tview\1\0\4\vnumber\1\nwidth\3\30\tside\tleft\19relativenumber\1\factions\14open_file\1\0\2\17quit_on_open\1\18resize_window\2\15change_dir\1\0\3\23restrict_above_cwd\1\vglobal\1\venable\2\1\0\1\25use_system_clipboard\2\1\0\3\vignore\1\ftimeout\3�\3\venable\2\ffilters\fexclude\vcustom\1\4\0\0\17node_modules\f\\.cache\15.null-ls.*\1\0\3\rdotfiles\1\14git_clean\1\14no_buffer\1\16system_open\targs\1\0\1\bcmd\5\24update_focused_file\16ignore_list\1\2\0\0\14gitcommit\1\0\2\venable\2\15update_cwd\2\23hijack_directories\1\0\2\venable\2\14auto_open\2\rrenderer\vglyphs\1\0\0\fignored\vIgnore\fdeleted\vRemove\14untracked\14Untracked\frenamed\vRename\runmerged\rUnmerged\vstaged\vStaged\runstaged\1\0\0\rUnstaged\bgit\vfolder\17symlink_open\18FolderSymlink\15empty_open\20EmptyFolderOpen\nempty\16EmptyFolder\topen\15FolderOpen\vFolder\15arrow_open\27TriangleShortArrowDown\17arrow_closed\1\0\0\28TriangleShortArrowRight\rbookmark\rBookMark\fsymlink\16FileSymlink\fdefault\1\0\0\tText\aui\19indent_markers\1\0\1\venable\1\1\0\6\25root_folder_modifier\a:~\17add_trailing\1\16group_empty\1\18highlight_git\2\27highlight_opened_files\tnone\22root_folder_label\16:~:s?$?/..?\14on_attach\0\nicons\nerror\nError\fwarning\fWarning\tinfo\16Information\thint\1\0\0\tHint\16diagnostics\1\0\2\17show_on_dirs\1\venable\1\vnotify\14threshold\1\0\0\tWARN\vlevels\blog\btab\1\0\a\16open_on_tab\1\15update_cwd\2\20respect_buf_cwd\1\18disable_netrw\1\17hijack_netrw\2\18hijack_cursor\1'hijack_unnamed_buffer_when_opening\2\tsync\1\0\0\vignore\1\2\0\0\14gitcommit\1\0\2\nclose\2\topen\2\nsetup\16utils.icons\0\0\0\0\0\1\0\1\vnested\2\0\14WinClosed\0\rcallback\1\0\0\rVimEnter\24nvim_create_autocmd\bapi\bvim\0\0\16FileCreated\nEvent\14subscribe\vevents\18nvim-tree.api\18nvim-tree.lib\14nvim-tree\frequire\0" },
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/nvim-tree.lua",
    url = "https://github.com/nvim-tree/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    config = { "\27LJ\2\n�\t\0\0\a\0.\00036\0\0\0'\2\1\0B\0\2\0029\1\2\0005\3\4\0005\4\3\0=\4\5\0035\4\6\0=\4\a\0035\4\t\0005\5\b\0=\5\n\0045\5\v\0=\5\f\4=\4\r\0035\4\14\0005\5\15\0=\5\16\4=\4\17\0035\4\18\0=\4\19\0035\4\20\0=\4\21\0035\4\24\0005\5\22\0005\6\23\0=\6\16\5=\5\25\0045\5\26\0005\6\27\0=\6\28\0055\6\29\0=\6\30\0055\6\31\0=\6 \0055\6!\0=\6\"\5=\5#\0045\5$\0004\6\0\0=\6%\5=\5&\4=\4'\0035\4(\0005\5)\0=\5*\4=\4+\0035\4,\0=\4-\3B\1\2\1K\0\1\0\fendwise\1\0\1\venable\2\fmatchup\fdisable\1\2\0\0\vpython\1\0\2\venable\2\25disable_virtual_text\2\16textobjects\tswap\14swap_next\1\0\1\venable\1\tmove\22goto_previous_end\1\0\2\a[M\17@class.outer\a[]\20@function.outer\18goto_next_end\1\0\2\a]M\17@class.outer\a][\20@function.outer\24goto_previous_start\1\0\2\a[m\17@class.outer\a[[\20@function.outer\20goto_next_start\1\0\2\a]m\17@class.outer\a]]\20@function.outer\1\0\2\venable\2\14set_jumps\2\vselect\1\0\0\1\0\6\aiB\17@block.inner\aic\17@class.inner\aif\20@function.inner\aaf\20@function.outer\aac\17@class.outer\aaB\17@block.outer\1\0\3#include_surrounding_whitespace\1\venable\2\14lookahead\2\26context_commentstring\1\0\2\venable\2\19enable_autocmd\1\14highlight\1\0\2&additional_vim_regex_highlighting\1\venable\2\26incremental_selection\fkeymaps\1\0\2\21node_incremental\14<C-space>\19init_selection\14<C-space>\1\0\1\venable\2\rrefactor\28highlight_current_scope\1\0\1\venable\1\26highlight_definitions\1\0\0\1\0\1\venable\2\fautotag\1\0\1\venable\2\21ensure_installed\1\0\1\17auto_install\2\1\23\0\0\bvim\vvimdoc\rmarkdown\20markdown_inline\tbash\nregex\15javascript\15typescript\vprisma\truby\btsx\vpython\tdart\tjson\thtml\blua\bcss\tscss\ttoml\tfish\njsdoc\tyaml\nsetup\28nvim-treesitter.configs\frequire\0" },
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-treesitter-endwise"] = {
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/nvim-treesitter-endwise",
    url = "https://github.com/RRethy/nvim-treesitter-endwise"
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
  ["nvim-ufo"] = {
    config = { "\27LJ\2\n�\2\0\5\23\0\v\0I4\5\0\0'\6\0\0\18\b\6\0009\6\1\6!\t\1\2B\6\3\0026\a\2\0009\a\3\a9\a\4\a\18\t\6\0B\a\2\2!\b\a\3)\t\0\0006\n\5\0\18\f\0\0B\n\2\4X\r/�:\15\1\0146\16\2\0009\16\3\0169\16\4\16\18\18\15\0B\16\2\2 \17\16\t\1\17\b\0X\17\6�6\17\6\0009\17\a\17\18\19\5\0\18\20\14\0B\17\3\1X\17\31�\18\17\4\0\18\19\15\0!\20\t\bB\17\3\2\18\15\17\0:\17\2\0146\18\6\0009\18\a\18\18\20\5\0004\21\3\0>\15\1\21>\17\2\21B\18\3\0016\18\2\0009\18\3\0189\18\4\18\18\20\15\0B\18\2\2\18\16\18\0 \18\16\t\1\18\b\0X\18\f�\18\18\6\0'\19\b\0\18\21\19\0009\19\t\19!\22\t\b!\22\16\22B\19\3\2&\6\19\18X\n\3� \t\16\tE\r\3\3R\r�\1276\n\6\0009\n\a\n\18\f\5\0005\r\n\0>\6\1\rB\n\3\1L\5\2\0\1\3\0\0\0\fMoreMsg\brep\6 \vinsert\ntable\vipairs\20strdisplaywidth\afn\bvim\vformat\r  %d �\1\0\3\a\0\t\0\0266\3\0\0\18\5\1\0B\3\2\2\a\3\1\0X\3\14�\18\5\1\0009\3\2\1'\6\3\0B\3\3\2\15\0\3\0X\4\b�6\3\4\0'\5\5\0B\3\2\0029\3\6\3\18\5\0\0\18\6\2\0D\3\3\0X\3\6�6\3\4\0'\5\a\0B\3\2\0029\3\b\3\18\5\1\0D\3\2\0K\0\1\0\vreject\fpromise\rgetFolds\bufo\frequire\25UfoFallbackException\nmatch\vstring\ttype*\0\1\6\2\1\0\5-\1\0\0-\3\1\0\18\4\0\0'\5\0\0D\1\4\0\0\0\0�\15treesitter&\0\1\6\2\1\0\5-\1\0\0-\3\1\0\18\4\0\0'\5\0\0D\1\4\0\0\0\0�\vindentj\1\1\5\1\a\0\0166\1\0\0'\3\1\0B\1\2\0029\1\2\1\18\3\0\0'\4\3\0B\1\3\2\18\3\1\0009\1\4\0013\4\5\0B\1\3\2\18\3\1\0009\1\4\0013\4\6\0002\0\0�D\1\3\0\3�\0\0\ncatch\blsp\rgetFolds\bufo\frequire@\1\3\5\0\5\0\n3\3\0\0\6\1\1\0X\4\2�\a\2\2\0X\4\2�'\4\3\0X\5\1�3\4\4\0002\0\0�L\4\2\0\0\vindent\vnofile\5\0�\1\1\0\6\0\r\0\0236\0\0\0'\2\1\0B\0\2\0023\1\2\0006\2\3\0009\2\4\2)\3c\0=\3\5\0026\2\3\0009\2\4\2)\3c\0=\3\6\0026\2\3\0009\2\4\2+\3\2\0=\3\a\0029\2\b\0005\4\t\0=\1\n\0043\5\v\0=\5\f\4B\2\2\1K\0\1\0\22provider_selector\0\27fold_virt_text_handler\1\0\0\nsetup\15foldenable\19foldlevelstart\14foldlevel\6o\bvim\0\bufo\frequire\0" },
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
    config = { "\27LJ\2\n\15\0\0\1\0\0\0\2+\0\2\0L\0\2\0\15\0\1\2\0\0\0\2+\1\2\0L\1\2\0�\4\1\0\5\0\14\0\0176\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\0025\3\6\0=\3\a\0025\3\t\0003\4\b\0=\4\n\0033\4\v\0=\4\f\3=\3\r\2B\0\2\1K\0\1\0\fnull-ls\22runtime_condition\0\14condition\1\0\1\ftimeout\3�'\0\14filetypes\1\r\0\0\bcss\fgraphql\thtml\15javascript\20javascriptreact\tjson\tless\rmarkdown\tscss\15typescript\20typescriptreact\tyaml\16cli_options\1\0\17\20bracket_spacing\2\22bracket_same_line\1!embedded_language_formatting\tauto html_whitespace_sensitivity\bcss\21jsx_single_quote\1\16print_width\3P\16end_of_line\alf\15prose_wrap\rpreserve\16quote_props\14as-needed\tsemi\2\30single_attribute_per_line\1\17single_quote\2\14tab_width\3\2\19trailing_comma\bes5\ruse_tabs\1 vue_indent_script_and_style\1\17arrow_parens\valways\1\0\1\bbin\14prettierd\nsetup\rprettier\frequire\0" },
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/prettier.nvim",
    url = "https://github.com/MunifTanjim/prettier.nvim"
  },
  ["promise-async"] = {
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/promise-async",
    url = "https://github.com/kevinhwang91/promise-async"
  },
  ["pubspec-assist.nvim"] = {
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/pubspec-assist.nvim",
    url = "https://github.com/akinsho/pubspec-assist.nvim"
  },
  ["rainbow-delimiters.nvim"] = {
    config = { "\27LJ\2\n�\2\0\0\5\0\14\0\0176\0\0\0'\2\1\0B\0\2\0026\1\2\0009\1\3\0015\2\t\0005\3\a\0009\4\5\0009\4\6\4=\4\b\3=\3\5\0025\3\n\0=\3\v\0025\3\f\0=\3\r\2=\2\4\1K\0\1\0\14highlight\1\b\0\0\27RainbowDelimiterYellow\24RainbowDelimiterRed\27RainbowDelimiterOrange\25RainbowDelimiterBlue\26RainbowDelimiterGreen\27RainbowDelimiterViolet\25RainbowDelimiterCyan\nquery\1\0\2\5\23rainbow-delimiters\blua\19rainbow-blocks\1\0\0\5\1\0\0\vglobal\rstrategy\23rainbow_delimiters\6g\bvim\23rainbow-delimiters\frequire\0" },
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/rainbow-delimiters.nvim",
    url = "https://github.com/HiPhish/rainbow-delimiters.nvim"
  },
  ["readline.nvim"] = {
    config = { "\27LJ\2\n�\4\0\0\a\0(\0C6\0\0\0'\2\1\0B\0\2\0026\1\2\0009\1\3\0019\1\4\1\18\2\1\0005\4\5\0'\5\6\0'\6\a\0B\2\4\1\18\2\1\0005\4\b\0'\5\t\0'\6\n\0B\2\4\1\18\2\1\0005\4\v\0'\5\f\0009\6\r\0B\2\4\1\18\2\1\0005\4\14\0'\5\15\0009\6\16\0B\2\4\1\18\2\1\0005\4\17\0'\5\18\0009\6\19\0B\2\4\1\18\2\1\0005\4\20\0'\5\21\0009\6\22\0B\2\4\1\18\2\1\0005\4\23\0'\5\24\0009\6\25\0B\2\4\1\18\2\1\0005\4\26\0'\5\27\0009\6\28\0B\2\4\1\18\2\1\0005\4\29\0'\5\30\0009\6\28\0B\2\4\1\18\2\1\0005\4\31\0'\5 \0009\6!\0B\2\4\1\18\2\1\0005\4\"\0'\5#\0009\6$\0B\2\4\1\18\2\1\0005\4%\0'\5&\0009\6'\0B\2\4\1K\0\1\0\23backward_kill_line\n<C-u>\1\3\0\0\6i\6c\14kill_line\n<C-k>\1\3\0\0\6i\6c\21unix_word_rubout\n<C-w>\1\3\0\0\6i\6c\v<M-BS>\1\3\0\0\6i\6c\23backward_kill_word\v<C-BS>\1\3\0\0\6i\6c\14kill_word\n<M-d>\1\3\0\0\6i\6c\16end_of_line\n<C-e>\1\3\0\0\6i\6c\22beginning_of_line\n<C-a>\1\3\0\0\6i\6c\18backward_word\n<M-b>\1\3\0\0\6i\6c\17forward_word\n<M-f>\1\3\0\0\6i\6c\v<Left>\n<C-b>\1\3\0\0\6i\6c\f<Right>\n<C-f>\1\3\0\0\6i\6c\vkeymap\bapi\nutils\rreadline\frequire\0" },
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/readline.nvim",
    url = "https://github.com/linty-org/readline.nvim"
  },
  ["schemastore.nvim"] = {
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/schemastore.nvim",
    url = "https://github.com/b0o/schemastore.nvim"
  },
  ["smart-open.nvim"] = {
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/smart-open.nvim",
    url = "https://github.com/danielfalk/smart-open.nvim"
  },
  ["smart-splits.nvim"] = {
    config = { "\27LJ\2\n�\3\0\0\5\0\16\0\0196\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0025\3\6\0=\3\a\0025\3\b\0005\4\t\0=\4\n\0035\4\v\0=\4\f\3=\3\r\0025\3\14\0=\3\15\2B\0\2\1K\0\1\0\19ignored_events\1\3\0\0\rBufEnter\rWinEnter\16resize_mode\nhooks\1\0\0\16resize_keys\1\5\0\0\6h\6j\6k\6l\1\0\2\vsilent\1\rquit_key\n<ESC>\21ignored_buftypes\1\2\0\0\rNvimTree\22ignored_filetypes\1\0\6 cursor_follows_swapped_bufs\2\14log_level\tinfo\19default_amount\3\3(disable_multiplexer_nav_when_zoomed\2\fat_edge\twrap\25move_cursor_same_row\1\1\4\0\0\vnofile\rquickfix\vprompt\nsetup\17smart-splits\frequire\0" },
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/smart-splits.nvim",
    url = "https://github.com/mrjones2014/smart-splits.nvim"
  },
  ["sqlite.lua"] = {
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/sqlite.lua",
    url = "https://github.com/kkharji/sqlite.lua"
  },
  ["stay-in-place.nvim"] = {
    config = { "\27LJ\2\nO\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\16set_keymaps\1\nsetup\18stay-in-place\frequire\0" },
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/stay-in-place.nvim",
    url = "https://github.com/gbprod/stay-in-place.nvim"
  },
  ["tabhula.nvim"] = {
    config = { "\27LJ\2\n\15\0\1\2\0\0\0\2)\1\1\0L\1\2\0�\2\1\0\5\0\21\0$3\0\0\0006\1\1\0'\3\2\0B\1\2\0029\1\3\0015\3\4\0005\4\5\0=\0\6\4=\0\a\4=\0\b\4=\0\t\4=\0\n\4=\0\v\4=\0\f\4=\0\r\4=\0\14\4=\0\15\4=\0\16\4=\0\17\4=\4\18\0035\4\19\0=\0\6\4=\0\a\4=\0\b\4=\0\t\4=\0\n\4=\0\v\4=\0\f\4=\0\r\4=\0\14\4=\0\15\4=\0\16\4=\0\17\4=\4\20\3B\1\2\1K\0\1\0\24backward_characters\1\0\0\23forward_characters\6`\6'\6\"\6;\6.\6,\6{\6}\6[\6]\6(\6)\1\0\0\1\0\4\16evil_tabkey\5\25evil_backward_tabkey\5\vtabkey\n<Tab>\20backward_tabkey\f<S-Tab>\nsetup\ftabhula\frequire\0\0" },
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
  ["telescope-media-files.nvim"] = {
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/telescope-media-files.nvim",
    url = "https://github.com/nvim-telescope/telescope-media-files.nvim"
  },
  ["telescope.nvim"] = {
    config = { "\27LJ\2\nn\0\2\a\4\2\1\16\14\0\1\0X\2\1�K\0\1\0009\2\0\1*\3\0\0\1\3\2\0X\2\2�K\0\1\0X\2\6�-\2\0\0009\2\1\2-\4\1\0-\5\2\0-\6\3\0B\2\4\1K\0\1\0\1\0\0\0\2\0\3\0\27buffer_previewer_maker\tsize��=\\\0\0\a\1\4\0\n6\0\0\0009\0\1\0009\0\2\0-\2\0\0)\3\0\0)\4��+\5\1\0005\6\3\0B\0\6\1K\0\1\0\2\0\1\2\0\0\16BINARY FILE\23nvim_buf_set_lines\bapi\bvim�\1\1\1\6\4\n\0\0236\1\0\0009\1\1\1\18\5\0\0009\3\2\0B\3\2\2:\3\1\3'\4\3\0B\1\3\2:\1\1\1\a\1\4\0X\2\a�6\2\0\0009\2\5\0029\2\6\2-\4\0\0003\5\a\0B\2\3\1X\2\4�6\2\0\0009\2\b\0023\4\t\0B\2\2\1K\0\1\0\0�\1\0\1�\2�\0\rschedule\0\ffs_stat\tloop\ttext\6/\vresult\nsplit\bvim�\1\1\3\b\2\n\0\0216\3\0\0009\3\1\0039\3\2\3\18\5\0\0B\3\2\2\18\0\3\0-\3\0\0\18\5\3\0009\3\3\0035\6\4\0005\a\5\0>\0\3\a=\a\6\0063\a\a\0=\a\b\6B\3\3\2\18\5\3\0009\3\t\3B\3\2\0012\0\0�K\0\1\0\3�\2�\tsync\fon_exit\0\targs\1\3\0\0\16--mime-type\a-b\1\0\1\fcommand\tfile\bnew\vexpand\afn\bvim\25\0\1\3\0\1\0\4'\1\0\0\18\2\0\0&\1\2\1L\1\2\0\6!�\r\1\0\15\0G\0o6\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0026\2\0\0'\4\3\0B\2\2\0026\3\0\0'\5\4\0B\3\2\0023\4\5\0005\5\6\0009\6\a\0005\b\15\0005\t\r\0005\n\t\0005\v\b\0=\v\n\n5\v\v\0=\v\f\n=\n\14\t=\t\16\b=\4\17\b5\t\20\0005\n\18\0=\5\19\n=\n\21\t5\n\25\0006\v\22\0009\v\23\v3\r\24\0\18\14\5\0B\v\3\2=\v\26\n=\n\27\t=\t\28\b5\t\30\0005\n\29\0=\n\31\t5\n!\0005\v \0=\v\"\n=\n#\t5\n$\0=\5%\n=\n&\t=\t'\b5\t)\0005\n(\0=\n*\t=\t+\b6\t\0\0'\v,\0B\t\2\0029\t-\t=\t.\b5\t1\0009\n/\0019\n0\n=\n2\t9\n/\0019\n3\n=\n4\t9\n/\0019\n5\n=\n6\t9\n/\0019\n7\n=\n8\t9\n/\0019\n9\n=\n:\t9\n/\0019\n;\n=\n<\t=\t=\b6\t\0\0'\v\3\0B\t\2\0029\t>\t9\t?\t=\t@\b6\t\0\0'\v\3\0B\t\2\0029\tA\t9\t?\t=\tB\b6\t\0\0'\v\3\0B\t\2\0029\tC\t9\t?\t=\tD\bB\6\2\0019\6E\0'\b\31\0B\6\2\0019\6E\0'\b#\0B\6\2\0019\6E\0'\bF\0B\6\2\0019\6E\0'\b&\0B\6\2\0012\0\0�K\0\1\0\fneoclip\19load_extension\21qflist_previewer\22vim_buffer_qflist\19grep_previewer\23vim_buffer_vimgrep\19file_previewer\bnew\19vim_buffer_cat\14git_icons\14untracked\14Untracked\runmerged\rUnmerged\frenamed\vRename\fdeleted\vRemove\fchanged\bMod\nadded\1\0\1\vcopied\6>\bAdd\bgit\16file_sorter\19get_fzy_sorter\22telescope.sorters\18layout_config\15horizontal\1\0\1\20prompt_position\btop\1\0\1\19preview_cutoff\3x\15extensions\15smart_open\20ignore_patterns\1\0\3\16show_scores\1\20match_algorithm\bfzf\21disable_devicons\1\16media_files\14filetypes\1\0\1\rfind_cmd\afd\1\b\0\0\bpng\twebp\bjpg\tjpeg\bpdf\bmp4\twebm\bfzf\1\0\0\1\0\4\25override_file_sorter\2\28override_generic_sorter\2\nfuzzy\2\14case_mode\15smart_case\fpickers\14live_grep\17glob_pattern\1\0\0\0\ftbl_map\bvim\15find_files\1\0\0\25file_ignore_patterns\1\0\1\vhidden\2\27buffer_previewer_maker\rdefaults\1\0\4\20selection_caret\t \18prompt_prefix\n  \21sorting_strategy\14ascending\19color_devicons\2\rmappings\1\0\0\6n\1\0\a\n<C-c>\nclose\6k\24move_selection_next\6v\20select_vertical\6l\28move_selection_previous\n<C-k>\24move_selection_next\n<C-l>\28move_selection_previous\6t\15select_tab\6i\1\0\0\1\0\5\n<C-c>\nclose\n<C-k>\24move_selection_next\t<CR>\19select_default\n<C-h>\14which_key\n<C-l>\28move_selection_previous\nsetup\1\19\0\0\t.git\n.venv\17node_modules\n*.jpg\v*.jpeg\n*.png\v*.lock\16.dart_tool/\n.idea\fandroid\vbuild/\bios\nlinux\nmacos\bweb\fwindows\14.metadata\n%.iml\0\16plenary.job\25telescope.previewers\16utils.icons\14telescope\frequire\0" },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/opt/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["todo-comments.nvim"] = {
    config = { "\27LJ\2\n�\t\0\0\a\0<\0Q6\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0029\1\3\0015\3\4\0005\4\v\0005\5\a\0009\6\5\0009\6\6\6=\6\b\0055\6\t\0=\6\n\5=\5\f\0045\5\14\0009\6\5\0009\6\r\6=\6\b\5=\5\15\0045\5\17\0009\6\5\0009\6\16\6=\6\b\5=\5\18\0045\5\21\0009\6\19\0009\6\20\6=\6\b\0055\6\22\0=\6\n\5=\5\23\0045\5\25\0009\6\5\0009\6\24\6=\6\b\0055\6\26\0=\6\n\5=\5\27\0045\5\29\0009\6\5\0009\6\28\6=\6\b\0055\6\30\0=\6\n\5=\5\31\0045\5!\0009\6\5\0009\6 \6=\6\b\0055\6\"\0=\6\n\5=\5#\4=\4$\0035\4%\0=\4&\0035\4'\0004\5\0\0=\5(\4=\4)\0035\4+\0005\5*\0=\5,\0045\5-\0=\5.\0045\5/\0=\0050\0045\0051\0=\0052\0045\0053\0=\0054\0045\0055\0=\0056\4=\0047\0035\0048\0005\0059\0=\5:\4=\4;\3B\1\2\1K\0\1\0\vsearch\targs\1\6\0\0\18--color=never\17--no-heading\20--with-filename\18--line-number\r--column\1\0\2\fcommand\arg\fpattern\18\\b(KEYWORDS):\vcolors\ttest\1\3\0\0\15Identifier\f#FF00FF\fdefault\1\3\0\0\15Identifier\f#7C3AED\thint\1\3\0\0\19DiagnosticHint\f#10B981\tinfo\1\3\0\0\19DiagnosticInfo\f#2563EB\fwarning\1\4\0\0\19DiagnosticWarn\15WarningMsg\f#FBBF24\nerror\1\0\0\1\4\0\0\20DiagnosticError\rErrorMsg\f#DC2626\14highlight\fexclude\1\0\t\nafter\afg\fpattern\22.*<(KEYWORDS)\\s*:\fkeyword\twide\vbefore\5\18comments_only\2\17max_line_len\3�\3\14multiline\2\22multiline_pattern\a^.\22multiline_context\3\n\14gui_style\1\0\2\afg\tNONE\abg\tBOLD\rkeywords\tTEST\1\4\0\0\fTESTING\vPASSED\vFAILED\1\0\1\ncolor\ttest\16Speedometer\tNOTE\1\2\0\0\tINFO\1\0\1\ncolor\thint\fComment\tPERF\1\4\0\0\nOPTIM\16PERFORMANCE\rOPTIMIZE\1\0\0\16Performance\tWARN\1\3\0\0\fWARNING\bXXX\1\0\1\ncolor\fwarning\fWarning\16diagnostics\tHACK\1\0\1\ncolor\fwarning\tFire\tTODO\1\0\1\ncolor\tinfo\rBookMark\bFIX\1\0\0\balt\1\5\0\0\nFIXME\bBUG\nFIXIT\nISSUE\ticon\1\0\1\ncolor\nerror\bBug\aui\1\0\3\19merge_keywords\2\18sign_priority\3\b\nsigns\2\nsetup\18todo-comments\16utils.icons\frequire\0" },
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/todo-comments.nvim",
    url = "https://github.com/folke/todo-comments.nvim"
  },
  ["toggleterm.nvim"] = {
    commands = { "ToggleTerm", "TermExec", "TermOpen" },
    config = { "\27LJ\2\n�\1\0\1\2\0\a\2\0189\1\0\0\a\1\1\0X\1\6�6\1\2\0009\1\3\0019\1\4\1\24\1\0\1L\1\2\0X\1\b�9\1\0\0\a\1\5\0X\1\5�6\1\2\0009\1\3\0019\1\6\1\24\1\1\1L\1\2\0K\0\1\0\fcolumns\rvertical\nlines\6o\bvim\15horizontal\14direction�̙�\6����\3\1����\3�\1\0\1\a\0\n\0\0209\1\0\0\a\1\1\0X\1\16�6\1\2\0006\3\3\0'\4\4\0B\1\3\0039\3\5\2\15\0\1\0X\4\t�9\4\6\3B\4\1\2\15\0\4\0X\5\5�9\4\a\3B\4\1\0019\4\b\0035\6\t\0B\4\2\1K\0\1\0\1\0\1\nfocus\1\vtoggle\nclose\15is_visible\ttree\18nvim-tree.api\frequire\npcall\15horizontal\14direction\v\0\1\1\0\0\0\1K\0\1\0\20\0\1\2\0\1\0\0029\1\0\0L\1\2\0\tname�\4\1\0\a\0\28\1'6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0003\3\3\0=\3\5\0024\3\0\0=\3\6\0023\3\a\0=\3\b\0023\3\t\0=\3\n\0026\3\v\0009\3\f\0039\3\r\3=\3\r\0025\3\14\0006\4\15\0009\4\16\0046\6\v\0009\6\f\0069\6\17\6\24\6\0\6B\4\2\2=\4\18\0035\4\19\0=\4\20\3=\3\21\0025\3\22\0004\4\0\0=\4\23\3=\3\20\0025\3\24\0003\4\25\0=\4\26\3=\3\27\2B\0\2\1K\0\1\0\vwinbar\19name_formatter\0\1\0\1\fenabled\1\vNormal\1\0\0\15float_opts\15highlights\1\0\2\vborder\vNormal\15background\vNormal\nwidth\fcolumns\nfloor\tmath\1\0\3\rwinblend\3\0\vheight\3\15\vborder\vcurved\nshell\6o\bvim\ron_close\0\fon_open\0\20shade_filetypes\tsize\1\0\b\20insert_mappings\1\17persist_size\1\18close_on_exit\2\17hide_numbers\2\20shade_terminals\1\14direction\15horizontal\19shading_factor\0060\20start_in_insert\2\0\nsetup\15toggleterm\frequire����\25̙��\3\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/opt/toggleterm.nvim",
    url = "https://github.com/akinsho/toggleterm.nvim"
  },
  ["tokyonight.nvim"] = {
    config = { "\27LJ\2\nd\0\2\t\0\4\0\f6\2\0\0006\4\1\0'\6\2\0B\4\2\0029\4\3\4B\4\1\0A\2\0\4H\5\1�<\6\5\0F\5\3\3R\5�\127K\0\1\0\23get_all_highlights\16colorscheme\frequire\npairs�\2\1\0\5\0\v\0\0156\0\0\0'\2\1\0B\0\2\0029\1\2\0005\3\3\0005\4\4\0=\4\5\0033\4\6\0=\4\a\3B\1\2\0016\1\b\0009\1\t\1'\3\n\0B\1\2\1K\0\1\0\27colorscheme tokyonight\bcmd\bvim\18on_highlights\0\vstyles\1\0\6\rsidebars\16transparent\rkeywords\vitalic\14functions\tbold\14variables\tNONE\rcomments\vitalic\vfloats\16transparent\1\0\3\20terminal_colors\1\nstyle\nnight\16transparent\2\nsetup\15tokyonight\frequire\0" },
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/tokyonight.nvim",
    url = "https://github.com/folke/tokyonight.nvim"
  },
  ["typescript-tools.nvim"] = {
    config = { "\27LJ\2\n�\16\0\0\a\0\17\0\0246\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0B\0\2\0025\1\f\0005\2\4\0005\3\5\0=\3\6\0024\3\0\0=\3\a\0025\3\b\0=\3\t\0025\3\n\0=\3\v\2=\2\r\0016\2\14\0009\2\15\2'\4\16\0\18\5\0\0\18\6\1\0B\2\4\2L\2\2\0\nforce\20tbl_deep_extend\bvim\rsettings\1\0\0\28tsserver_format_options\1\0\18\15semicolons\vignore\21indentSwitchCase\2#insertSpaceAfterCommaDelimiter\2 insertSpaceAfterConstructor\1-insertSpaceAfterSemicolonInForStatements\2-insertSpaceBeforeAndAfterBinaryOperators\0024insertSpaceAfterKeywordsInControlFlowStatements\0029insertSpaceAfterFunctionKeywordForAnonymousFunctions\2)insertSpaceBeforeFunctionParenthesis\1?insertSpaceAfterOpeningAndBeforeClosingNonemptyParenthesis\1<insertSpaceAfterOpeningAndBeforeClosingNonemptyBrackets\1:insertSpaceAfterOpeningAndBeforeClosingNonemptyBraces\0027insertSpaceAfterOpeningAndBeforeClosingEmptyBraces\2@insertSpaceAfterOpeningAndBeforeClosingTemplateStringBraces\1?insertSpaceAfterOpeningAndBeforeClosingJsxExpressionBraces\1\"insertSpaceAfterTypeAssertion\1(placeOpenBraceOnNewLineForFunctions\1,placeOpenBraceOnNewLineForControlBlocks\1\30tsserver_file_preferences\1\0\25'provideRefactorNotApplicableReason\2 generateReturnInDocTemplate\2*includeCompletionsForImportStatements\2&includeCompletionsWithSnippetText\2.includeCompletionsWithClassMemberSnippets\0026includeCompletionsWithObjectLiteralMethodSnippets\2'useLabelDetailsInCompletionEntries\2\31allowIncompleteCompletions\2\25displayPartsForJSDoc\2 disableLineTextInReferences\2#includeInlayParameterNameHints\tnone:includeInlayParameterNameHintsWhenArgumentMatchesName\1+includeInlayFunctionParameterTypeHints\1\"includeInlayVariableTypeHints\0015includeInlayVariableTypeHintsWhenTypeMatchesName\1-includeInlayPropertyDeclarationTypeHints\1,includeInlayFunctionLikeReturnTypeHints\1%includeInlayEnumMemberValueHints\1\20quotePreference\tauto importModuleSpecifierEnding\tauto jsxAttributeCompletionStyle\tauto\31allowTextChangesInNewFiles\2(providePrefixAndSuffixTextForRename\2\28allowRenameOfImportPath\2-includeAutomaticOptionalChainCompletions\2\21tsserver_plugins\26expose_as_code_action\1\4\0\0\ffix_all\24add_missing_imports\18remove_unused\1\0\3\31separate_diagnostic_server\1\26publish_diagnostic_on\17insert_leave\24tsserver_max_memory\tauto\rtsserver\20get_configs_for\blsp\frequire\0" },
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/typescript-tools.nvim",
    url = "https://github.com/pmizio/typescript-tools.nvim"
  },
  ["undoquit.vim"] = {
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/undoquit.vim",
    url = "https://github.com/AndrewRadev/undoquit.vim"
  },
  undotree = {
    config = { "\27LJ\2\n�\2\0\0\3\0\b\0\0176\0\0\0009\0\1\0)\1\1\0=\1\2\0006\0\0\0009\0\1\0'\1\4\0=\1\3\0006\0\0\0009\0\1\0)\1\3\0=\1\5\0006\0\0\0009\0\6\0'\2\a\0B\0\2\1K\0\1\0�\1        function! g:Undotree_CustomMap() abort\n\t\tnmap <buffer> L <plug>UndotreeNextState\n\t\tnmap <buffer> K <plug>UndotreePreviousState\n        endfunction\n      \bcmd\26undotree_WindowLayout\b◉\27undotree_TreeNodeShape undotree_SetFocusWhenToggle\6g\bvim\0" },
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/undotree",
    url = "https://github.com/mbbill/undotree"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/vim-fugitive",
    url = "https://github.com/tpope/vim-fugitive"
  },
  ["vim-highlighturl"] = {
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/vim-highlighturl",
    url = "https://github.com/itchyny/vim-highlighturl"
  },
  ["vim-illuminate"] = {
    config = { "\27LJ\2\n�\3\0\0\4\0\14\0\0236\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0024\3\0\0=\3\6\0025\3\a\0=\3\b\0024\3\0\0=\3\t\0024\3\0\0=\3\n\0024\3\0\0=\3\v\0024\3\0\0=\3\f\0024\3\0\0=\3\r\2B\0\2\1K\0\1\0%providers_regex_syntax_allowlist$providers_regex_syntax_denylist\20modes_allowlist\19modes_denylist\24filetypes_allowlist\23filetypes_denylist\1\16\0\0\fdirvish\rfugitive\fdirvish\rfugitive\nalpha\rNvimTree\tlazy\17neogitstatus\fTrouble\blir\fOutline\18spectre_panel\15toggleterm\19DressingSelect\20TelescopePrompt\23filetype_overrides\14providers\1\0\2\17under_cursor\2\ndelay\3�\2\1\4\0\0\blsp\15treesitter\nregex\14configure\15illuminate\frequire\0" },
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/vim-illuminate",
    url = "https://github.com/RRethy/vim-illuminate"
  },
  ["vim-kitty"] = {
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/vim-kitty",
    url = "https://github.com/fladson/vim-kitty"
  },
  ["vim-matchup"] = {
    config = { "\27LJ\2\n\v\0\0\1\0\0\0\1K\0\1\0\0" },
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/vim-matchup",
    url = "https://github.com/andymass/vim-matchup"
  },
  ["vim-operator-user"] = {
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/vim-operator-user",
    url = "https://github.com/kana/vim-operator-user"
  },
  ["vim-python-pep8-indent"] = {
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/vim-python-pep8-indent",
    url = "https://github.com/Vimjas/vim-python-pep8-indent"
  },
  ["vim-repeat"] = {
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/vim-repeat",
    url = "https://github.com/tpope/vim-repeat"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/vim-surround",
    url = "https://github.com/tpope/vim-surround"
  },
  ["vim-textobj-comment"] = {
    config = { "\27LJ\2\nI\0\0\2\0\3\0\0056\0\0\0009\0\1\0)\1\1\0=\1\2\0K\0\1\0,textobj_comment_no_default_key_mappings\6g\bvim\0" },
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/vim-textobj-comment",
    url = "https://github.com/glts/vim-textobj-comment"
  },
  ["vim-textobj-user"] = {
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/vim-textobj-user",
    url = "https://github.com/kana/vim-textobj-user"
  },
  ["vim-visual-multi"] = {
    config = { "\27LJ\2\n�\3\0\0\4\0\f\0\0256\0\0\0009\0\1\0)\1\0\0=\1\2\0006\0\0\0009\0\1\0)\1\0\0=\1\3\0006\0\0\0009\0\4\0009\0\5\0'\2\6\0005\3\a\0B\0\3\0016\0\0\0009\0\4\0009\0\5\0'\2\b\0005\3\t\0B\0\3\0016\0\0\0009\0\1\0005\1\v\0=\1\n\0K\0\1\0\1\0\4\aç\6l\6k\6j\6j\6h\6l\6k\22VM_custom_motions\1\0\a\20Add Cursor Down\f<C-M-k>\tUndo\6u\18Add Cursor Up\f<C-M-l>\15Find Under\n<C-n>\tRedo\n<C-r>\23Find Subword Under\n<C-n>\15Select All\14<leader>A\fVM_maps\1\0\3\vvisual\6 \vbuffer\6z\fdefault\6 \14VM_leader\17nvim_set_var\bapi\21VM_show_warnings\24VM_default_mappings\6g\bvim\0" },
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/vim-visual-multi",
    url = "https://github.com/mg979/vim-visual-multi"
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

-- Config for: nvim-colorizer.lua
time([[Config for nvim-colorizer.lua]], true)
try_loadstring("\27LJ\2\n�\2\0\0\6\0\14\0\0176\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0025\3\6\0=\3\a\0025\3\b\0005\4\t\0005\5\n\0=\5\v\4=\4\f\3=\3\r\2B\0\2\1K\0\1\0\25user_default_options\tsass\fparsers\1\2\0\0\bcss\1\0\1\venable\1\1\0\n\bRGB\2\vRRGGBB\2\nnames\2\rRRGGBBAA\2\rAARRGGBB\2\vrgb_fn\2\vhsl_fn\2\bcss\2\vcss_fn\2\tmode\15background\14filetypes\1\4\0\0\6*\14!NvimTree\15!gitcommit\fbuftype\1\0\0\1\4\0\0\6*\f!prompt\f!nofile\nsetup\14colorizer\frequire\0", "config", "nvim-colorizer.lua")
time([[Config for nvim-colorizer.lua]], false)
-- Config for: dressing.nvim
time([[Config for dressing.nvim]], true)
try_loadstring("\27LJ\2\n\v\0\1\1\0\0\0\1L\0\2\0\v\0\1\1\0\0\0\1L\0\2\0�\n\1\0\a\0002\0A6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\19\0005\3\3\0005\4\4\0=\4\5\0035\4\6\0=\4\a\0034\4\0\0=\4\b\0035\4\t\0=\4\n\0035\4\f\0005\5\v\0=\5\r\0045\5\14\0=\5\15\4=\4\16\0033\4\17\0=\4\18\3=\3\20\0025\3\21\0005\4\22\0=\4\23\0035\4\25\0005\5\24\0=\5\26\4=\4\27\0035\4\29\0005\5\28\0=\5\30\4=\4\31\0035\4 \0005\5!\0=\5\"\0045\5#\0=\5\b\0045\5$\0=\5\n\4=\4%\0035\4&\0004\5\0\0=\5\b\0045\5'\0=\5\n\0045\5(\0=\5\5\0045\5)\0=\5\a\0045\5*\0=\5+\0045\5-\0005\6,\0=\6\r\5=\5\16\0043\5.\0=\5\18\4=\4/\0034\4\0\0=\0040\3=\0031\2B\0\2\1K\0\1\0\vselect\25format_item_override\fbuiltin\0\1\0\3\n<C-c>\nClose\t<CR>\fConfirm\n<Esc>\nClose\1\0\1\6q\nClose\15min_height\1\3\0\0\3\n\4����\t����\3\1\3\0\0\3(\4����\t����\3\1\3\0\0\3�\1\4����\t����\3\1\0\2\rwinblend\3\n\17winhighlight\"Normal:Normal,NormalNC:Normal\1\0\4\vanchor\aNW\15max_height\4͙��\f̙��\3\rrelative\veditor\vborder\frounded\bnui\1\0\1\rwinblend\3\n\1\0\2\rswapfile\1\rfiletype\19DressingSelect\vborder\1\0\1\nstyle\frounded\1\0\6\14min_width\3(\15min_height\3\n\rrelative\veditor\15max_height\3(\14max_width\3P\rposition\b50%\ffzf_lua\fwinopts\1\0\0\1\0\2\vheight\4����\t����\3\nwidth\4\0����\3\bfzf\vwindow\1\0\0\1\0\2\vheight\4����\t����\3\nwidth\4\0����\3\fbackend\1\6\0\0\14telescope\ffzf_lua\bfzf\fbuiltin\bnui\1\0\2\16trim_prompt\2\fenabled\2\ninput\1\0\0\roverride\0\rmappings\6i\1\0\4\n<C-c>\nClose\v<Down>\16HistoryNext\t<CR>\fConfirm\t<Up>\16HistoryPrev\6n\1\0\0\1\0\2\t<CR>\fConfirm\n<Esc>\nClose\16win_options\1\0\3\twrap\1\17winhighlight7Normal:TelescopeNormal,FloatBorder:TelescopeBorder\rwinblend\3\0\16buf_options\14min_width\1\3\0\0\3\20\4����\t����\3\14max_width\1\3\0\0\3�\1\4͙��\f̙��\3\1\0\t\rrelative\vcursor\20start_in_insert\2\vanchor\aSW\17prefer_width\3(\fenabled\2\19default_prompt\vInput:\17prompt_align\tleft\16insert_only\2\vborder\frounded\nsetup\rdressing\frequire\0", "config", "dressing.nvim")
time([[Config for dressing.nvim]], false)
-- Config for: hop.nvim
time([[Config for hop.nvim]], true)
try_loadstring("\27LJ\2\nO\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\tkeys\22çalskdjfwoeicmvn\nsetup\bhop\frequire\0", "config", "hop.nvim")
time([[Config for hop.nvim]], false)
-- Config for: prettier.nvim
time([[Config for prettier.nvim]], true)
try_loadstring("\27LJ\2\n\15\0\0\1\0\0\0\2+\0\2\0L\0\2\0\15\0\1\2\0\0\0\2+\1\2\0L\1\2\0�\4\1\0\5\0\14\0\0176\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\0025\3\6\0=\3\a\0025\3\t\0003\4\b\0=\4\n\0033\4\v\0=\4\f\3=\3\r\2B\0\2\1K\0\1\0\fnull-ls\22runtime_condition\0\14condition\1\0\1\ftimeout\3�'\0\14filetypes\1\r\0\0\bcss\fgraphql\thtml\15javascript\20javascriptreact\tjson\tless\rmarkdown\tscss\15typescript\20typescriptreact\tyaml\16cli_options\1\0\17\20bracket_spacing\2\22bracket_same_line\1!embedded_language_formatting\tauto html_whitespace_sensitivity\bcss\21jsx_single_quote\1\16print_width\3P\16end_of_line\alf\15prose_wrap\rpreserve\16quote_props\14as-needed\tsemi\2\30single_attribute_per_line\1\17single_quote\2\14tab_width\3\2\19trailing_comma\bes5\ruse_tabs\1 vue_indent_script_and_style\1\17arrow_parens\valways\1\0\1\bbin\14prettierd\nsetup\rprettier\frequire\0", "config", "prettier.nvim")
time([[Config for prettier.nvim]], false)
-- Config for: nvim-navic
time([[Config for nvim-navic]], true)
try_loadstring("\27LJ\2\n�\a\0\0\b\0.\0�\0016\0\0\0'\2\1\0B\0\2\0029\1\2\0006\2\0\0'\4\3\0B\2\2\0029\2\4\0025\4)\0005\5\a\0009\6\5\1'\a\6\0&\6\a\6=\6\5\0059\6\b\1=\6\b\0059\6\t\1'\a\6\0&\6\a\6=\6\t\0059\6\n\1'\a\6\0&\6\a\6=\6\n\0059\6\v\1'\a\6\0&\6\a\6=\6\v\0059\6\f\1'\a\6\0&\6\a\6=\6\f\0059\6\r\1'\a\6\0&\6\a\6=\6\r\0059\6\14\1'\a\6\0&\6\a\6=\6\14\0059\6\15\1'\a\6\0&\6\a\6=\6\15\0059\6\16\1'\a\6\0&\6\a\6=\6\16\0059\6\17\1'\a\6\0&\6\a\6=\6\17\0059\6\18\1'\a\6\0&\6\a\6=\6\18\0059\6\19\1'\a\6\0&\6\a\6=\6\19\0059\6\20\1'\a\6\0&\6\a\6=\6\20\0059\6\21\1'\a\6\0&\6\a\6=\6\21\0059\6\22\1'\a\6\0&\6\a\6=\6\22\0059\6\23\1'\a\6\0&\6\a\6=\6\23\0059\6\24\1'\a\6\0&\6\a\6=\6\24\0059\6\25\1'\a\6\0&\6\a\6=\6\25\0059\6\26\1'\a\6\0&\6\a\6=\6\26\0059\6\27\1'\a\6\0&\6\a\6=\6\27\0059\6\28\1'\a\6\0&\6\a\6=\6\28\0059\6\29\1'\a\6\0&\6\a\6=\6\29\0059\6\30\1'\a\6\0&\6\a\6=\6\30\0059\6\31\1'\a\6\0&\6\a\6=\6\31\0059\6 \1'\a\6\0&\6\a\6=\6 \0059\6!\1'\a\6\0&\6\a\6=\6!\0059\6\"\1'\a\6\0&\6\a\6=\6\"\0059\6#\1'\a\6\0&\6\a\6=\6#\0059\6$\1'\a\6\0&\6\a\6=\6$\0059\6%\1'\a\6\0&\6\a\6=\6%\0059\6&\1'\a\6\0&\6\a\6=\6&\0059\6'\1'\a\6\0&\6\a\6=\6'\0059\6(\1'\a\6\0&\6\a\6=\6(\5=\5*\4'\5\6\0009\6+\0009\6,\6'\a\6\0&\5\a\5=\5-\4B\2\2\1K\0\1\0\14separator\17ChevronRight\aui\nicons\1\0\3\26depth_limit_indicator\a..\14highlight\2\16depth_limit\3\4\rVariable\nValue\tUnit\18TypeParameter\tText\vStruct\vString\fSnippet\14Reference\rProperty\fPackage\rOperator\vObject\vNumber\tNull\14Namespace\vModule\vMethod\fKeyword\bKey\14Interface\rFunction\vFolder\tFile\nField\nEvent\15EnumMember\tEnum\16Constructor\rConstant\nColor\nClass\fBoolean\1\0\0\6 \nArray\nsetup\15nvim-navic\flspkind\16utils.icons\frequire\0", "config", "nvim-navic")
time([[Config for nvim-navic]], false)
-- Config for: null-ls.nvim
time([[Config for null-ls.nvim]], true)
try_loadstring("\27LJ\2\nz\0\0\5\0\b\0\f6\0\0\0009\0\1\0009\0\2\0009\0\3\0005\2\6\0006\3\0\0009\3\4\0039\3\5\3B\3\1\2=\3\a\2B\0\2\1K\0\1\0\nbufnr\1\0\1\15timeout_ms\3�\23\25nvim_get_current_buf\bapi\vformat\bbuf\blsp\bvim�\1\1\2\b\0\n\0\0159\2\0\0'\4\1\0B\2\2\2\15\0\2\0X\3\t�6\2\2\0009\2\3\0029\2\4\2'\4\5\0'\5\6\0003\6\a\0005\a\b\0=\1\t\aB\2\5\1K\0\1\0\vbuffer\1\0\1\tdesc\17[lsp] format\0\15<Leader>ff\6n\bset\vkeymap\bvim\28textDocument/formatting\20supports_method�\5\1\0\14\0%\1J6\0\0\0'\2\1\0B\0\2\0029\1\2\0009\2\3\0005\4!\0004\5\r\0009\6\4\0019\6\5\0069\6\6\0065\b\f\0005\t\a\0006\n\b\0009\n\t\n9\n\n\n'\f\v\0B\n\2\0?\n\0\0=\t\r\bB\6\2\2>\6\1\0059\6\14\0019\6\15\6>\6\2\0059\6\4\0019\6\16\6>\6\3\0059\6\17\0019\6\18\0069\6\6\0065\b\23\0005\t\19\0006\n\b\0009\n\t\n9\n\n\n6\f\b\0009\f\20\f9\f\21\f'\r\22\0&\f\r\fB\n\2\0?\n\0\0=\t\r\bB\6\2\2>\6\4\0059\6\4\0019\6\24\6>\6\5\0059\6\25\0019\6\26\6>\6\6\0059\6\4\0019\6\27\6>\6\a\0059\6\4\0019\6\28\6>\6\b\0059\6\4\0019\6\29\6>\6\t\0059\6\4\0019\6\30\6>\6\n\0059\6\4\0019\6\31\6>\6\v\0059\6\17\0019\6 \6>\6\f\5=\5\"\0043\5#\0=\5$\4B\2\2\1K\0\1\0\14on_attach\0\fsources\1\0\0\tfish\16fish_indent\fyamlfmt\ffixjson\16dart_format\17clang_format\reslint_d\17code_actions\14prettierd\1\0\0%/lua/lsp/linter-config/ruff.toml\fvim_dir\6g\1\2\0\0\r--config\truff\16diagnostics\nblack\fluasnip\15completion\15extra_args\1\0\0005~/.config/nvim/lua/lsp/linter-config/stylua.toml\vexpand\afn\bvim\1\2\0\0\18--config-path\twith\vstylua\15formatting\nsetup\rbuiltins\fnull-ls\frequire\5����\4\0", "config", "null-ls.nvim")
time([[Config for null-ls.nvim]], false)
-- Config for: guess-indent.nvim
time([[Config for guess-indent.nvim]], true)
try_loadstring("\27LJ\2\n�\1\0\0\4\0\b\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\0025\3\6\0=\3\a\2B\0\2\1K\0\1\0\20buftype_exclude\1\5\0\0\thelp\vnofile\rterminal\vprompt\21filetype_exclude\1\3\0\0\nnetrw\ntutor\1\0\2\rauto_cmd\2\26override_editorconfig\1\nsetup\17guess-indent\frequire\0", "config", "guess-indent.nvim")
time([[Config for guess-indent.nvim]], false)
-- Config for: nvim-treesitter
time([[Config for nvim-treesitter]], true)
try_loadstring("\27LJ\2\n�\t\0\0\a\0.\00036\0\0\0'\2\1\0B\0\2\0029\1\2\0005\3\4\0005\4\3\0=\4\5\0035\4\6\0=\4\a\0035\4\t\0005\5\b\0=\5\n\0045\5\v\0=\5\f\4=\4\r\0035\4\14\0005\5\15\0=\5\16\4=\4\17\0035\4\18\0=\4\19\0035\4\20\0=\4\21\0035\4\24\0005\5\22\0005\6\23\0=\6\16\5=\5\25\0045\5\26\0005\6\27\0=\6\28\0055\6\29\0=\6\30\0055\6\31\0=\6 \0055\6!\0=\6\"\5=\5#\0045\5$\0004\6\0\0=\6%\5=\5&\4=\4'\0035\4(\0005\5)\0=\5*\4=\4+\0035\4,\0=\4-\3B\1\2\1K\0\1\0\fendwise\1\0\1\venable\2\fmatchup\fdisable\1\2\0\0\vpython\1\0\2\venable\2\25disable_virtual_text\2\16textobjects\tswap\14swap_next\1\0\1\venable\1\tmove\22goto_previous_end\1\0\2\a[M\17@class.outer\a[]\20@function.outer\18goto_next_end\1\0\2\a]M\17@class.outer\a][\20@function.outer\24goto_previous_start\1\0\2\a[m\17@class.outer\a[[\20@function.outer\20goto_next_start\1\0\2\a]m\17@class.outer\a]]\20@function.outer\1\0\2\venable\2\14set_jumps\2\vselect\1\0\0\1\0\6\aiB\17@block.inner\aic\17@class.inner\aif\20@function.inner\aaf\20@function.outer\aac\17@class.outer\aaB\17@block.outer\1\0\3#include_surrounding_whitespace\1\venable\2\14lookahead\2\26context_commentstring\1\0\2\venable\2\19enable_autocmd\1\14highlight\1\0\2&additional_vim_regex_highlighting\1\venable\2\26incremental_selection\fkeymaps\1\0\2\21node_incremental\14<C-space>\19init_selection\14<C-space>\1\0\1\venable\2\rrefactor\28highlight_current_scope\1\0\1\venable\1\26highlight_definitions\1\0\0\1\0\1\venable\2\fautotag\1\0\1\venable\2\21ensure_installed\1\0\1\17auto_install\2\1\23\0\0\bvim\vvimdoc\rmarkdown\20markdown_inline\tbash\nregex\15javascript\15typescript\vprisma\truby\btsx\vpython\tdart\tjson\thtml\blua\bcss\tscss\ttoml\tfish\njsdoc\tyaml\nsetup\28nvim-treesitter.configs\frequire\0", "config", "nvim-treesitter")
time([[Config for nvim-treesitter]], false)
-- Config for: nvim-notify
time([[Config for nvim-notify]], true)
try_loadstring("\27LJ\2\n�\2\0\0\a\0\19\0\0276\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0029\2\3\0005\4\4\0005\5\a\0009\6\5\0019\6\6\6=\6\b\0059\6\5\0019\6\t\6=\6\n\0059\6\5\0019\6\v\6=\6\f\0059\6\r\0019\6\14\6=\6\15\0059\6\r\0019\6\16\6=\6\17\5=\5\18\4B\2\2\1K\0\1\0\nicons\nTRACE\vPencil\nDEBUG\bBug\aui\tINFO\16Information\tWARN\fWarning\nERROR\1\0\0\nError\16diagnostics\1\0\b\22background_colour\f#121212\rtop_down\2\14max_width\3x\vstages\22fade_in_slide_out\nlevel\3\2\ftimeout\3�\15\bfpg\3\30\vrender\fdefault\nsetup\16utils.icons\vnotify\frequire\0", "config", "nvim-notify")
time([[Config for nvim-notify]], false)
-- Config for: mason.nvim
time([[Config for mason.nvim]], true)
try_loadstring("\27LJ\2\nI\0\1\5\2\2\0\n-\1\0\0009\1\0\1\18\3\0\0B\1\2\2-\2\1\0008\2\0\0029\2\1\2\18\4\1\0B\2\2\1K\0\1\0\4�\1�\nsetup\20get_configs_forP\0\0\4\2\3\0\n-\0\0\0009\0\0\0'\2\1\0B\0\2\2-\1\1\0009\1\1\0019\1\2\1\18\3\0\0B\1\2\1K\0\1\0\4�\1�\nsetup\vlua_ls\20get_configs_fort\0\0\4\0\5\0\f6\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\0026\1\0\0'\3\3\0B\1\2\0029\1\4\1\18\3\0\0B\1\2\1K\0\1\0\nsetup\21typescript-tools\vconfig\27plugins.dev.typescript\frequire�\5\1\0\v\0\"\0;6\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0026\2\0\0'\4\3\0B\2\2\0026\3\0\0'\5\4\0B\3\2\0026\4\0\0'\6\5\0B\4\2\0026\5\0\0'\a\6\0B\5\2\0029\6\a\0005\b\v\0005\t\b\0005\n\t\0=\n\n\t=\t\f\bB\6\2\0019\6\a\0055\b\14\0005\t\r\0=\t\15\bB\6\2\0019\6\a\0035\b\17\0009\t\16\4=\t\15\bB\6\2\0019\6\a\0025\b\21\0005\t\19\0005\n\18\0=\n\20\t=\t\22\bB\6\2\0019\6\23\0035\b\26\0003\t\24\0>\t\1\b3\t\25\0=\t\27\b3\t\28\0=\t\29\bB\6\2\0016\6\0\0'\b\30\0B\6\2\0029\6\31\6'\a!\0=\a \0062\0\0�K\0\1\0\vsingle\vborder\20default_options\25lspconfig.ui.windows\rtsserver\0\vlua_ls\1\0\0\0\0\19setup_handlers\flibrary\1\0\0\fplugins\1\0\1\ntypes\2\1\2\0\0\16nvim-dap-ui\1\0\1\27automatic_installation\2\fservers\21ensure_installed\1\0\1\20automatic_setup\2\1\b\0\0\truff\fdebugpy\nblack\fyamlfmt\14prettierd\fcpplint\17clang-format\aui\1\0\0\nicons\1\0\3\22package_installed\b✓\24package_uninstalled\b✗\20package_pending\b⟳\1\0\1\vborder\frounded\nsetup\18mason-null-ls\blsp\20mason-lspconfig\vneodev\14lspconfig\nmason\frequire\0", "config", "mason.nvim")
time([[Config for mason.nvim]], false)
-- Config for: nvim-web-devicons
time([[Config for nvim-web-devicons]], true)
try_loadstring("\27LJ\2\n`\0\0\4\0\5\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0004\3\0\0=\3\4\2B\0\2\1K\0\1\0\roverride\1\0\1\fdefault\2\nsetup\22nvim-web-devicons\frequire\0", "config", "nvim-web-devicons")
time([[Config for nvim-web-devicons]], false)
-- Config for: nvim-navbuddy
time([[Config for nvim-navbuddy]], true)
try_loadstring("\27LJ\2\nk\0\0\t\0\5\0\0166\0\0\0'\2\1\0B\0\2\0029\0\2\0004\1\0\0006\2\3\0\18\4\0\0B\2\2\4H\5\4�\18\a\6\0'\b\4\0&\a\b\a<\a\5\1F\5\3\3R\5�\127L\1\2\0\6 \npairs\flspkind\16utils.icons\frequire�\t\1\0\v\0O\0s6\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0023\2\3\0009\3\4\0005\5\14\0005\6\5\0005\a\a\0005\b\6\0=\b\b\a5\b\t\0=\b\n\a5\b\v\0=\b\f\a=\a\r\6=\6\15\0055\6\16\0005\a\17\0=\a\18\6=\6\19\5\18\6\2\0B\6\1\2=\6\18\0055\6\21\0009\a\20\1B\a\1\2=\a\22\0069\a\20\1B\a\1\2=\a\23\0069\a\24\1B\a\1\2=\a\25\0069\a\26\1B\a\1\2=\a\27\0069\a\28\1B\a\1\2=\a\29\0069\a\30\1B\a\1\2=\a\31\0069\a \1B\a\1\2=\a!\0069\a\"\1B\a\1\2=\a#\0069\a$\1B\a\1\2=\a%\0069\a&\1B\a\1\2=\a'\0069\a(\1B\a\1\2=\a)\0069\a*\1B\a\1\2=\a+\0069\a,\1B\a\1\2=\a-\0069\a.\1B\a\1\2=\a/\0069\a0\1B\a\1\2=\a1\0069\a2\1B\a\1\2=\a3\0069\a4\1B\a\1\2=\a5\0069\a6\1B\a\1\2=\a7\0069\a8\1B\a\1\2=\a9\0069\a:\1B\a\1\2=\a;\0069\a<\1B\a\1\2=\a=\0069\a<\1B\a\1\2=\a>\0069\a?\1B\a\1\2=\a@\0069\aA\1B\a\1\2=\aB\0069\aC\0015\tE\0005\nD\0=\nF\tB\a\2\2=\aG\0069\aH\1B\a\1\2=\aI\6=\6J\0055\6K\0=\6L\0055\6M\0=\6N\5B\3\2\1K\0\1\0\18source_buffer\1\0\3\14highlight\2\16follow_node\2\rreorient\nsmart\blsp\1\0\1\16auto_attach\2\rmappings\6?\thelp\6t\18layout_config\1\0\1\20layout_strategy\15horizontal\1\0\4\18preview_width\4\0����\3\nwidth\4��̙\3���\3\vheight\4��̙\3���\3\20prompt_position\btop\14telescope\n<A-l>\fmove_up\n<A-k>\14move_down\6o\f<enter>\vselect\6c\fcomment\6F\16fold_delete\6f\16fold_create\6d\vdelete\6r\vrename\6A\17append_scope\6a\16append_name\6I\17insert_scope\6i\16insert_name\6Y\15yank_scope\6y\14yank_name\6V\17visual_scope\6v\16visual_name\0060\troot\aç\rchildren\6j\vparent\6l\21previous_sibling\6k\17next_sibling\6q\n<esc>\1\0\0\nclose\17node_markers\nicons\1\0\3\18leaf_selected\n → \vbranch\t \tleaf\a  \1\0\1\fenabled\2\vwindow\1\0\1\25use_default_mappings\1\rsections\nright\1\0\1\fpreview\tleaf\bmid\1\0\1\tsize\b40%\tleft\1\0\0\1\0\1\tsize\b20%\1\0\3\vborder\vsingle\tsize\b60%\rposition\b50%\nsetup\0\26nvim-navbuddy.actions\18nvim-navbuddy\frequire\0", "config", "nvim-navbuddy")
time([[Config for nvim-navbuddy]], false)
-- Config for: nvim-tree.lua
time([[Config for nvim-tree.lua]], true)
try_loadstring("\27LJ\2\n7\0\1\5\0\4\0\a6\1\0\0009\1\1\1'\3\2\0009\4\3\0&\3\4\3B\1\2\1K\0\1\0\nfname\nedit \bcmd\bvim�\3\0\1\t\1\19\1J5\1\0\0006\2\1\0009\2\2\0029\2\3\0029\4\4\0B\2\2\2\b\2\0\0X\2\2�+\2\1\0X\3\1�+\2\2\0009\3\4\0\a\3\5\0X\3\a�6\3\1\0009\3\6\0039\4\a\0008\3\4\0039\3\b\3\6\3\5\0X\3\2�+\3\1\0X\4\1�+\3\2\0006\4\1\0009\4\6\0049\5\a\0008\4\5\0049\4\t\4\14\0\2\0X\5\3�\14\0\3\0X\5\1�K\0\1\0006\5\1\0009\5\n\5\18\a\1\0\18\b\4\0B\5\3\2\15\0\5\0X\6\1�K\0\1\0006\5\1\0009\5\2\0059\5\v\0059\a\4\0B\5\2\2\b\5\0\0X\5\2�+\5\1\0X\6\1�+\5\2\0\15\0\5\0X\6\14�6\6\1\0009\6\f\0069\6\r\6B\6\1\0016\6\1\0009\6\f\0069\6\14\0069\b\a\0B\6\2\0016\6\1\0009\6\f\0069\6\15\0069\b\4\0B\6\2\1-\6\0\0009\6\16\0069\6\17\0065\b\18\0B\6\2\1K\0\1\0\2�\1\0\2\14find_file\2\nfocus\1\vtoggle\ttree\acd\abw\tenew\bcmd\16isdirectory\17tbl_contains\aft\fbuftype\bbuf\abo\5\tfile\17filereadable\afn\bvim\1\2\0\0\14gitcommit\2%\0\1\2\1\0\0\a-\1\0\0\5\0\1\0X\1\2�+\1\1\0X\2\1�+\1\2\0L\1\2\0\0��\1\0\0\4\1\6\1\0206\0\0\0009\0\1\0009\0\2\0B\0\1\2\21\0\0\0\t\0\0\0X\0\1�X\0\v�6\0\0\0009\0\3\0'\2\4\0B\0\2\0016\0\0\0009\0\1\0009\0\5\0-\2\0\0:\2\1\2+\3\2\0B\0\3\1K\0\1\0\4�\19nvim_win_close\17NvimTreeOpen\bcmd\19nvim_list_wins\bapi\bvim\2�\3\1\1\v\1\18\1H6\1\0\0009\1\1\0019\1\2\1\18\3\0\0B\1\2\0026\2\0\0009\2\1\0029\2\3\2\18\4\0\0B\2\2\0026\3\0\0009\3\4\0039\3\5\3\18\5\2\0B\3\2\2:\3\1\0036\4\0\0009\4\6\0043\6\a\0006\a\0\0009\a\1\a9\a\b\a\18\t\1\0B\a\2\0A\4\1\0026\5\0\0009\5\t\0056\a\0\0009\a\1\a9\a\3\a\18\b\4\0B\5\3\0029\6\n\3\18\b\6\0009\6\v\6'\t\f\0B\6\3\2\15\0\6\0X\a\v�6\6\0\0009\6\r\6\18\b\5\0B\6\2\2\14\0\6\0X\6\25�-\6\0\0009\6\14\0069\6\15\6B\6\1\1X\6\20�\21\6\5\0\t\6\0\0X\6\17�6\6\0\0009\6\4\0069\6\5\6:\b\1\5B\6\2\2:\6\1\0069\a\n\6\18\t\a\0009\a\v\a'\n\f\0B\a\3\2\15\0\a\0X\b\4�6\a\0\0009\a\16\a3\t\17\0B\a\2\0012\0\0�K\0\1\0\2�\0\rschedule\nclose\ttree\16tbl_isempty\20.*NvimTree_%d*$\nmatch\tname\ftbl_map\27nvim_tabpage_list_wins\0\15tbl_filter\15getbufinfo\afn\21nvim_win_get_buf\25nvim_win_get_tabpage\bapi\bvim\2y\0\0\a\1\a\0\0156\0\0\0006\2\1\0009\2\2\0029\2\3\2'\4\4\0B\2\2\0A\0\0\0026\1\1\0009\1\5\0016\3\6\0-\5\0\0\18\6\0\0B\3\3\0A\1\0\1K\0\1\0\4�\npcall\18schedule_wrap\r<amatch>\vexpand\afn\bvim\rtonumber�\1\0\0\4\2\a\0\17-\0\0\0009\0\0\0B\0\1\2\v\0\0\0X\1\1�K\0\1\0006\1\1\0009\1\2\1'\3\3\0B\1\2\1-\1\1\0009\1\4\0019\1\5\0019\1\6\1\18\3\0\0B\1\2\1K\0\1\0\1�\2�\btab\topen\tnode\rwincmd l\bcmd\bvim\23get_node_at_cursorX\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\afn2nvim-tree.actions.tree-modifiers.collapse-all\frequirem\0\0\4\1\3\0\14-\0\0\0009\0\0\0B\0\1\2\v\0\0\0X\1\1�K\0\1\0009\1\1\0\n\1\0\0X\1\4�-\1\0\0009\1\2\1\18\3\0\0B\1\2\1K\0\1\0\1�\23expand_or_collapse\nnodes\23get_node_at_cursor�\1\0\0\6\1\14\0\31-\0\0\0009\0\0\0B\0\1\0029\1\1\0009\1\2\1\6\1\3\0X\2\6�\6\1\4\0X\2\4�\6\1\5\0X\2\2�\a\1\6\0X\2\a�6\2\a\0009\2\b\2'\4\t\0009\5\n\0&\4\5\4B\2\2\1X\2\n�\6\1\v\0X\2\2�\a\1\f\0X\2\6�6\2\a\0009\2\b\2'\4\r\0009\5\n\0&\4\5\4B\2\2\1K\0\1\0\1�\"silent !git restore --staged \aA \aM \18absolute_path\21silent !git add \bcmd\bvim\a M\aAM\aMM\a??\tfile\15git_status\23get_node_at_cursorS\0\1\4\1\6\0\v-\1\0\0009\1\0\0019\1\1\0019\1\2\1\18\3\0\0B\1\2\0016\1\3\0009\1\4\0019\1\5\1B\1\1\1K\0\1\0\2�\ftabprev\bcmd\bvim\btab\topen\tnode]\0\1\4\1\4\0\b5\1\1\0'\2\0\0\18\3\0\0&\2\3\2=\2\2\1-\2\0\0=\2\3\1L\1\2\0\0�\vbuffer\tdesc\1\0\3\vsilent\2\vnowait\2\fnoremap\2\16nvim-tree: �\17\1\1\n\6]\0�\0023\1\0\0006\2\1\0009\2\2\0029\2\3\2'\4\4\0'\5\5\0-\6\0\0009\6\6\0069\6\a\0069\6\b\6\18\a\1\0'\t\t\0B\a\2\0A\2\3\0016\2\1\0009\2\2\0029\2\3\2'\4\4\0'\5\n\0-\6\1\0\18\a\1\0'\t\v\0B\a\2\0A\2\3\0016\2\1\0009\2\2\0029\2\3\2'\4\4\0'\5\f\0-\6\2\0\18\a\1\0'\t\r\0B\a\2\0A\2\3\0016\2\1\0009\2\2\0029\2\3\2'\4\4\0'\5\14\0-\6\0\0009\6\6\0069\6\15\0069\6\16\6\18\a\1\0'\t\17\0B\a\2\0A\2\3\0016\2\1\0009\2\2\0029\2\3\2'\4\4\0'\5\18\0-\6\3\0\18\a\1\0'\t\19\0B\a\2\0A\2\3\0016\2\1\0009\2\2\0029\2\3\2'\4\4\0'\5\20\0-\6\4\0\18\a\1\0'\t\21\0B\a\2\0A\2\3\0016\2\1\0009\2\2\0029\2\3\2'\4\4\0'\5\22\0-\6\5\0\18\a\1\0'\t\23\0B\a\2\0A\2\3\0016\2\1\0009\2\2\0029\2\3\2'\4\4\0'\5\24\0-\6\0\0009\6\6\0069\6\a\0069\6\25\6\18\a\1\0'\t\26\0B\a\2\0A\2\3\0016\2\1\0009\2\2\0029\2\3\2'\4\4\0'\5\27\0-\6\0\0009\6\6\0069\6\a\0069\6\28\6\18\a\1\0'\t\29\0B\a\2\0A\2\3\0016\2\1\0009\2\2\0029\2\3\2'\4\4\0'\5\30\0-\6\0\0009\6\6\0069\6\15\0069\6\31\6\18\a\1\0'\t \0B\a\2\0A\2\3\0016\2\1\0009\2\2\0029\2\3\2'\4\4\0'\5!\0-\6\0\0009\6\6\0069\6\a\0069\6\"\6\18\a\1\0'\t#\0B\a\2\0A\2\3\0016\2\1\0009\2\2\0029\2\3\2'\4\4\0'\5$\0-\6\0\0009\6\6\0069\6\15\0069\6%\0069\6&\6\18\a\1\0'\t'\0B\a\2\0A\2\3\0016\2\1\0009\2\2\0029\2\3\2'\4\4\0'\5(\0-\6\0\0009\6\6\0069\6\15\0069\6%\0069\6)\6\18\a\1\0'\t*\0B\a\2\0A\2\3\0016\2\1\0009\2\2\0029\2\3\2'\4\4\0'\5+\0-\6\0\0009\6,\0069\6-\6\18\a\1\0'\t.\0B\a\2\0A\2\3\0016\2\1\0009\2\2\0029\2\3\2'\4\4\0'\5/\0-\6\0\0009\6,\0069\0060\6\18\a\1\0'\t1\0B\a\2\0A\2\3\0016\2\1\0009\2\2\0029\2\3\2'\4\4\0'\0052\0-\6\0\0009\0063\0069\0064\6\18\a\1\0'\t5\0B\a\2\0A\2\3\0016\2\1\0009\2\2\0029\2\3\2'\4\4\0'\0056\0-\6\0\0009\0063\0069\0067\6\18\a\1\0'\t8\0B\a\2\0A\2\3\0016\2\1\0009\2\2\0029\2\3\2'\4\4\0'\0059\0-\6\0\0009\0063\0069\6:\6\18\a\1\0'\t;\0B\a\2\0A\2\3\0016\2\1\0009\2\2\0029\2\3\2'\4\4\0'\5<\0-\6\0\0009\0063\0069\6=\6\18\a\1\0'\t>\0B\a\2\0A\2\3\0016\2\1\0009\2\2\0029\2\3\2'\4\4\0'\5?\0-\6\0\0009\0063\0069\6@\0069\6\6\6\18\a\1\0'\tA\0B\a\2\0A\2\3\0016\2\1\0009\2\2\0029\2\3\2'\4\4\0'\5B\0-\6\0\0009\0063\0069\6C\6\18\a\1\0'\tD\0B\a\2\0A\2\3\0016\2\1\0009\2\2\0029\2\3\2'\4\4\0'\5E\0-\6\0\0009\0063\0069\6@\0069\6F\6\18\a\1\0'\tG\0B\a\2\0A\2\3\0016\2\1\0009\2\2\0029\2\3\2'\4\4\0'\5H\0-\6\0\0009\0063\0069\6@\0069\6I\6\18\a\1\0'\tJ\0B\a\2\0A\2\3\0016\2\1\0009\2\2\0029\2\3\2'\4\4\0'\5K\0-\6\0\0009\0063\0069\6@\0069\6L\6\18\a\1\0'\tM\0B\a\2\0A\2\3\0016\2\1\0009\2\2\0029\2\3\2'\4\4\0'\5N\0-\6\0\0009\6\6\0069\6\15\0069\6O\0069\6P\6\18\a\1\0'\tQ\0B\a\2\0A\2\3\0016\2\1\0009\2\2\0029\2\3\2'\4\4\0'\5R\0-\6\0\0009\6\6\0069\6\15\0069\6O\0069\6S\6\18\a\1\0'\tT\0B\a\2\0A\2\3\0016\2\1\0009\2\2\0029\2\3\2'\4\4\0'\5U\0-\6\0\0009\6,\0069\6V\6\18\a\1\0'\tW\0B\a\2\0A\2\3\0016\2\1\0009\2\2\0029\2\3\2'\4\4\0'\5X\0-\6\0\0009\6,\0069\6Y\6\18\a\1\0'\tZ\0B\a\2\0A\2\3\0016\2\1\0009\2\2\0029\2\3\2'\4\4\0'\5[\0-\6\0\0009\6\6\0069\6\a\0069\6\25\6\18\a\1\0'\t\26\0B\a\2\0A\2\3\0016\2\1\0009\2\2\0029\2\3\2'\4\4\0'\5\\\0-\6\0\0009\6\6\0069\6\a\0069\6\28\6\18\a\1\0'\t\29\0B\a\2\0A\2\3\0012\0\0�K\0\1\0\2�\5�\a�\6�\b�\t�\6h\6v\tHelp\16toggle_help\6?\nClose\nclose\6q\rNext Git\tnext\a]c\rPrev Git\tprev\bgit\a[c\23Copy Absolute Path\18absolute_path\agy\23Copy Relative Path\18relative_path\6Y\14Copy Name\rfilename\6y\nPaste\npaste\6p\tCopy\tcopy\6c\bCut\bcut\6x\vRename\vrename\6r\vDelete\vremove\6d\vCreate\vcreate\afs\6a\fRefresh\vreload\6R\20Toggle Dotfiles\25toggle_hidden_filter\ttree\6H\17Last Sibling\tlast\6K\18First Sibling\nfirst\fsibling\6L\17Open Preview\fpreview\n<Tab>\21Parent Directory\vparent\6P\27Open: Horizontal Split\15horizontal\n<C-x>\25Open: Vertical Split\rvertical\n<C-v>\20open_tab_silent\6T\fgit_add\aga\rCollapse\6J\20Close Directory\17parent_close\rnavigate\6j\vexpand\aç\23swap_then_open_tab\6t\27Open: No Window Picker\21no_window_picker\topen\tnode\6o\6n\bset\vkeymap\bvim\0�\17\1\0\19\0|\0�\0016\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0026\2\0\0'\4\3\0B\2\2\0029\3\4\0029\3\5\0039\5\4\0029\5\6\0059\5\a\0053\6\b\0B\3\3\0013\3\t\0006\4\n\0009\4\v\0049\4\f\4'\6\r\0005\a\14\0=\3\15\aB\4\3\0013\4\16\0006\5\n\0009\5\v\0059\5\f\5'\a\17\0005\b\19\0003\t\18\0=\t\15\bB\5\3\0013\5\20\0003\6\21\0003\a\22\0003\b\23\0003\t\24\0006\n\0\0'\f\25\0B\n\2\0029\v\26\0005\r \0005\14\30\0005\15\27\0005\16\28\0=\16\29\15=\15\31\14=\14!\r5\14%\0006\15\n\0009\15\"\0159\15#\0159\15$\15=\15&\14=\14'\r5\14(\0005\15+\0009\16)\n9\16*\16=\16,\0159\16)\n9\16-\16=\16.\0159\16)\n9\16/\16=\0160\0159\16)\n9\0161\16=\0162\15=\0153\14=\14)\r3\0144\0=\0145\r5\0146\0005\0157\0=\0158\0145\15`\0005\16;\0009\0179\n9\17:\17=\17<\0169\0179\n9\17=\17=\17>\0169\0179\n9\17?\17=\17@\0165\17B\0009\0189\n9\18A\18=\18C\0179\0189\n9\18D\18=\18E\0179\0189\n9\18F\18=\18<\0179\0189\n9\18G\18=\18H\0179\0189\n9\18I\18=\18J\0179\0189\n9\18K\18=\18L\0179\0189\n9\18M\18=\18>\0179\0189\n9\18G\18=\18N\17=\17O\0165\17R\0009\18P\n9\18Q\18=\18S\0179\18P\n9\18T\18=\18U\0179\18P\n9\18V\18=\18W\0179\18P\n9\18X\18=\18Y\0179\18P\n9\18Z\18=\18[\0179\18P\n9\18\\\18=\18]\0179\18P\n9\18^\18=\18_\17=\17P\16=\16a\15=\0153\14=\14b\r5\14c\0=\14d\r5\14e\0005\15f\0=\15g\14=\14h\r5\14i\0004\15\0\0=\15j\14=\14k\r5\14l\0005\15m\0=\15n\0144\15\0\0=\15o\14=\14p\r5\14q\0=\14P\r5\14r\0005\15s\0=\15t\0145\15u\0=\15v\14=\14w\r5\14x\0=\14y\r5\14z\0=\14{\rB\v\2\0012\0\0�K\0\1\0\ntrash\1\0\2\bcmd\ntrash\20require_confirm\2\tview\1\0\4\vnumber\1\nwidth\3\30\tside\tleft\19relativenumber\1\factions\14open_file\1\0\2\17quit_on_open\1\18resize_window\2\15change_dir\1\0\3\23restrict_above_cwd\1\vglobal\1\venable\2\1\0\1\25use_system_clipboard\2\1\0\3\vignore\1\ftimeout\3�\3\venable\2\ffilters\fexclude\vcustom\1\4\0\0\17node_modules\f\\.cache\15.null-ls.*\1\0\3\rdotfiles\1\14git_clean\1\14no_buffer\1\16system_open\targs\1\0\1\bcmd\5\24update_focused_file\16ignore_list\1\2\0\0\14gitcommit\1\0\2\venable\2\15update_cwd\2\23hijack_directories\1\0\2\venable\2\14auto_open\2\rrenderer\vglyphs\1\0\0\fignored\vIgnore\fdeleted\vRemove\14untracked\14Untracked\frenamed\vRename\runmerged\rUnmerged\vstaged\vStaged\runstaged\1\0\0\rUnstaged\bgit\vfolder\17symlink_open\18FolderSymlink\15empty_open\20EmptyFolderOpen\nempty\16EmptyFolder\topen\15FolderOpen\vFolder\15arrow_open\27TriangleShortArrowDown\17arrow_closed\1\0\0\28TriangleShortArrowRight\rbookmark\rBookMark\fsymlink\16FileSymlink\fdefault\1\0\0\tText\aui\19indent_markers\1\0\1\venable\1\1\0\6\25root_folder_modifier\a:~\17add_trailing\1\16group_empty\1\18highlight_git\2\27highlight_opened_files\tnone\22root_folder_label\16:~:s?$?/..?\14on_attach\0\nicons\nerror\nError\fwarning\fWarning\tinfo\16Information\thint\1\0\0\tHint\16diagnostics\1\0\2\17show_on_dirs\1\venable\1\vnotify\14threshold\1\0\0\tWARN\vlevels\blog\btab\1\0\a\16open_on_tab\1\15update_cwd\2\20respect_buf_cwd\1\18disable_netrw\1\17hijack_netrw\2\18hijack_cursor\1'hijack_unnamed_buffer_when_opening\2\tsync\1\0\0\vignore\1\2\0\0\14gitcommit\1\0\2\nclose\2\topen\2\nsetup\16utils.icons\0\0\0\0\0\1\0\1\vnested\2\0\14WinClosed\0\rcallback\1\0\0\rVimEnter\24nvim_create_autocmd\bapi\bvim\0\0\16FileCreated\nEvent\14subscribe\vevents\18nvim-tree.api\18nvim-tree.lib\14nvim-tree\frequire\0", "config", "nvim-tree.lua")
time([[Config for nvim-tree.lua]], false)
-- Config for: nvim-ufo
time([[Config for nvim-ufo]], true)
try_loadstring("\27LJ\2\n�\2\0\5\23\0\v\0I4\5\0\0'\6\0\0\18\b\6\0009\6\1\6!\t\1\2B\6\3\0026\a\2\0009\a\3\a9\a\4\a\18\t\6\0B\a\2\2!\b\a\3)\t\0\0006\n\5\0\18\f\0\0B\n\2\4X\r/�:\15\1\0146\16\2\0009\16\3\0169\16\4\16\18\18\15\0B\16\2\2 \17\16\t\1\17\b\0X\17\6�6\17\6\0009\17\a\17\18\19\5\0\18\20\14\0B\17\3\1X\17\31�\18\17\4\0\18\19\15\0!\20\t\bB\17\3\2\18\15\17\0:\17\2\0146\18\6\0009\18\a\18\18\20\5\0004\21\3\0>\15\1\21>\17\2\21B\18\3\0016\18\2\0009\18\3\0189\18\4\18\18\20\15\0B\18\2\2\18\16\18\0 \18\16\t\1\18\b\0X\18\f�\18\18\6\0'\19\b\0\18\21\19\0009\19\t\19!\22\t\b!\22\16\22B\19\3\2&\6\19\18X\n\3� \t\16\tE\r\3\3R\r�\1276\n\6\0009\n\a\n\18\f\5\0005\r\n\0>\6\1\rB\n\3\1L\5\2\0\1\3\0\0\0\fMoreMsg\brep\6 \vinsert\ntable\vipairs\20strdisplaywidth\afn\bvim\vformat\r  %d �\1\0\3\a\0\t\0\0266\3\0\0\18\5\1\0B\3\2\2\a\3\1\0X\3\14�\18\5\1\0009\3\2\1'\6\3\0B\3\3\2\15\0\3\0X\4\b�6\3\4\0'\5\5\0B\3\2\0029\3\6\3\18\5\0\0\18\6\2\0D\3\3\0X\3\6�6\3\4\0'\5\a\0B\3\2\0029\3\b\3\18\5\1\0D\3\2\0K\0\1\0\vreject\fpromise\rgetFolds\bufo\frequire\25UfoFallbackException\nmatch\vstring\ttype*\0\1\6\2\1\0\5-\1\0\0-\3\1\0\18\4\0\0'\5\0\0D\1\4\0\0\0\0�\15treesitter&\0\1\6\2\1\0\5-\1\0\0-\3\1\0\18\4\0\0'\5\0\0D\1\4\0\0\0\0�\vindentj\1\1\5\1\a\0\0166\1\0\0'\3\1\0B\1\2\0029\1\2\1\18\3\0\0'\4\3\0B\1\3\2\18\3\1\0009\1\4\0013\4\5\0B\1\3\2\18\3\1\0009\1\4\0013\4\6\0002\0\0�D\1\3\0\3�\0\0\ncatch\blsp\rgetFolds\bufo\frequire@\1\3\5\0\5\0\n3\3\0\0\6\1\1\0X\4\2�\a\2\2\0X\4\2�'\4\3\0X\5\1�3\4\4\0002\0\0�L\4\2\0\0\vindent\vnofile\5\0�\1\1\0\6\0\r\0\0236\0\0\0'\2\1\0B\0\2\0023\1\2\0006\2\3\0009\2\4\2)\3c\0=\3\5\0026\2\3\0009\2\4\2)\3c\0=\3\6\0026\2\3\0009\2\4\2+\3\2\0=\3\a\0029\2\b\0005\4\t\0=\1\n\0043\5\v\0=\5\f\4B\2\2\1K\0\1\0\22provider_selector\0\27fold_virt_text_handler\1\0\0\nsetup\15foldenable\19foldlevelstart\14foldlevel\6o\bvim\0\bufo\frequire\0", "config", "nvim-ufo")
time([[Config for nvim-ufo]], false)
-- Config for: neogen
time([[Config for neogen]], true)
try_loadstring("\27LJ\2\n�\3\0\0\6\0\25\0!6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\a\0005\4\5\0005\5\4\0=\5\6\4=\4\b\0035\4\n\0005\5\t\0=\5\6\4=\4\v\0035\4\r\0005\5\f\0=\5\6\4=\4\14\0035\4\16\0005\5\15\0=\5\6\4=\4\17\0035\4\19\0005\5\18\0=\5\6\4=\4\20\0035\4\22\0005\5\21\0=\5\6\4=\4\23\3=\3\24\2B\0\2\1K\0\1\0\14languages\20typescriptreact\1\0\0\1\0\1\26annotation_convention\ntsdoc\15typescript\1\0\0\1\0\1\26annotation_convention\ntsdoc\15javascript\1\0\0\1\0\1\26annotation_convention\njsdoc\trust\1\0\0\1\0\1\26annotation_convention\frustdoc\vpython\1\0\0\1\0\1\26annotation_convention\22google_docstrings\blua\1\0\0\rtemplate\1\0\0\1\0\1\26annotation_convention\femmylua\1\0\2\19snippet_engine\fluasnip\fenabled\2\nsetup\vneogen\frequire\0", "config", "neogen")
time([[Config for neogen]], false)
-- Config for: mini.move
time([[Config for mini.move]], true)
try_loadstring("\27LJ\2\n�\1\0\0\4\0\b\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0025\3\6\0=\3\a\2B\0\2\1K\0\1\0\foptions\1\0\1\22reindent_linewise\2\rmappings\1\0\0\1\0\b\tleft\5\14line_left\5\aup\n<M-l>\tdown\n<M-k>\nright\5\fline_up\n<M-l>\15line_right\5\14line_down\n<M-k>\nsetup\14mini.move\frequire\0", "config", "mini.move")
time([[Config for mini.move]], false)
-- Config for: vim-textobj-comment
time([[Config for vim-textobj-comment]], true)
try_loadstring("\27LJ\2\nI\0\0\2\0\3\0\0056\0\0\0009\0\1\0)\1\1\0=\1\2\0K\0\1\0,textobj_comment_no_default_key_mappings\6g\bvim\0", "config", "vim-textobj-comment")
time([[Config for vim-textobj-comment]], false)
-- Config for: nvim-dap
time([[Config for nvim-dap]], true)
try_loadstring("\27LJ\2\n�\5\0\0\5\0\25\00085\0\6\0005\1\4\0006\2\0\0009\2\1\0029\2\2\0029\2\3\2=\2\5\1=\1\a\0005\1\b\0006\2\0\0009\2\1\0029\2\2\0029\2\3\2=\2\5\1=\1\t\0005\1\f\0006\2\0\0009\2\1\0029\2\n\0029\2\v\2=\2\5\1=\1\r\0006\1\14\0009\1\15\0019\1\16\1'\3\17\0009\4\a\0B\1\3\0016\1\14\0009\1\15\0019\1\16\1'\3\18\0009\4\r\0B\1\3\0016\1\14\0009\1\15\0019\1\16\1'\3\19\0009\4\t\0B\1\3\0016\1\20\0'\3\21\0B\1\2\0029\1\22\1B\1\1\0016\1\20\0'\3\23\0B\1\2\0029\1\22\1B\1\1\0016\1\20\0'\3\24\0B\1\2\0029\1\22\1B\1\1\1K\0\1\0\31plugins.debug.virtual-text\29plugins.debug.dap-python\nsetup\21plugins.debug.ui\frequire\26DapBreakpointRejected\15DapStopped\18DapBreakpoint\16sign_define\afn\bvim\fstopped\1\0\3\vtexthl\"LspDiagnosticsSignInformation\nnumhl\"LspDiagnosticsSignInformation\vlinehl\28DiagnosticUnderlineInfo\19BoldArrowRight\aui\rrejected\1\0\3\vtexthl\27LspDiagnosticsSignHint\nnumhl\5\vlinehl\5\15breakpoint\1\0\0\ttext\1\0\3\vtexthl\28LspDiagnosticsSignError\nnumhl\5\vlinehl\5\bbug\tbase\nicons\nutils\0", "config", "nvim-dap")
time([[Config for nvim-dap]], false)
-- Config for: tabhula.nvim
time([[Config for tabhula.nvim]], true)
try_loadstring("\27LJ\2\n\15\0\1\2\0\0\0\2)\1\1\0L\1\2\0�\2\1\0\5\0\21\0$3\0\0\0006\1\1\0'\3\2\0B\1\2\0029\1\3\0015\3\4\0005\4\5\0=\0\6\4=\0\a\4=\0\b\4=\0\t\4=\0\n\4=\0\v\4=\0\f\4=\0\r\4=\0\14\4=\0\15\4=\0\16\4=\0\17\4=\4\18\0035\4\19\0=\0\6\4=\0\a\4=\0\b\4=\0\t\4=\0\n\4=\0\v\4=\0\f\4=\0\r\4=\0\14\4=\0\15\4=\0\16\4=\0\17\4=\4\20\3B\1\2\1K\0\1\0\24backward_characters\1\0\0\23forward_characters\6`\6'\6\"\6;\6.\6,\6{\6}\6[\6]\6(\6)\1\0\0\1\0\4\16evil_tabkey\5\25evil_backward_tabkey\5\vtabkey\n<Tab>\20backward_tabkey\f<S-Tab>\nsetup\ftabhula\frequire\0\0", "config", "tabhula.nvim")
time([[Config for tabhula.nvim]], false)
-- Config for: rainbow-delimiters.nvim
time([[Config for rainbow-delimiters.nvim]], true)
try_loadstring("\27LJ\2\n�\2\0\0\5\0\14\0\0176\0\0\0'\2\1\0B\0\2\0026\1\2\0009\1\3\0015\2\t\0005\3\a\0009\4\5\0009\4\6\4=\4\b\3=\3\5\0025\3\n\0=\3\v\0025\3\f\0=\3\r\2=\2\4\1K\0\1\0\14highlight\1\b\0\0\27RainbowDelimiterYellow\24RainbowDelimiterRed\27RainbowDelimiterOrange\25RainbowDelimiterBlue\26RainbowDelimiterGreen\27RainbowDelimiterViolet\25RainbowDelimiterCyan\nquery\1\0\2\5\23rainbow-delimiters\blua\19rainbow-blocks\1\0\0\5\1\0\0\vglobal\rstrategy\23rainbow_delimiters\6g\bvim\23rainbow-delimiters\frequire\0", "config", "rainbow-delimiters.nvim")
time([[Config for rainbow-delimiters.nvim]], false)
-- Config for: leap-spooky.nvim
time([[Config for leap-spooky.nvim]], true)
try_loadstring("\27LJ\2\n�\1\0\0\5\0\n\0\r6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\b\0005\3\4\0005\4\3\0=\4\5\0035\4\6\0=\4\a\3=\3\t\2B\0\2\1K\0\1\0\faffixes\1\0\1\25paste_on_remote_yank\1\rmagnetic\1\0\2\17cross_window\6M\vwindow\6m\vremote\1\0\0\1\0\2\17cross_window\6R\vwindow\6r\nsetup\16leap-spooky\frequire\0", "config", "leap-spooky.nvim")
time([[Config for leap-spooky.nvim]], false)
-- Config for: stay-in-place.nvim
time([[Config for stay-in-place.nvim]], true)
try_loadstring("\27LJ\2\nO\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\16set_keymaps\1\nsetup\18stay-in-place\frequire\0", "config", "stay-in-place.nvim")
time([[Config for stay-in-place.nvim]], false)
-- Config for: LuaSnip
time([[Config for LuaSnip]], true)
try_loadstring("\27LJ\2\n�\1\0\1\3\1\5\0\20-\1\0\0009\1\0\1\15\0\1\0X\2\15�-\1\0\0009\1\0\0019\1\1\0019\2\2\0008\1\2\1\15\0\1\0X\2\b�-\1\0\0009\1\0\0019\1\3\1\14\0\1\0X\1\3�-\1\0\0009\1\4\1B\1\1\1K\0\1\0\0�\19unlink_current\16jump_active\bbuf\18current_nodes\fsession�\4\1\0\a\0\26\0-6\0\0\0'\2\1\0B\0\2\0026\1\2\0009\1\3\0019\1\4\1'\3\5\0005\4\6\0B\1\3\0026\2\2\0009\2\3\0029\2\a\2'\4\b\0005\5\t\0=\1\n\0055\6\v\0=\6\f\0053\6\r\0=\6\14\5B\2\3\0019\2\15\0'\4\16\0005\5\17\0B\2\3\0019\2\15\0'\4\18\0005\5\19\0B\2\3\0016\2\0\0'\4\20\0B\2\2\0029\2\21\2B\2\1\0016\2\0\0'\4\20\0B\2\2\0029\2\21\0025\4\22\0B\2\2\0019\2\23\0009\2\24\0025\4\25\0B\2\2\0012\0\0�K\0\1\0\1\0\1\24region_check_events\16CursorMoved\15set_config\vconfig\1\0\1\npaths\15./snippets\14lazy_load luasnip.loaders.from_vscode\1\3\0\0\thtml\15javascript\20javascriptreact\1\3\0\0\thtml\15typescript\20typescriptreact\20filetype_extend\rcallback\0\fpattern\1\3\0\0\bs:n\bi:*\ngroup\1\0\1\tdesc<Forget the current snippet when leaving the insert mode\16ModeChanged\24nvim_create_autocmd\1\0\1\nclear\2\30UnlinkSnippetOnModeChange\24nvim_create_augroup\bapi\bvim\fluasnip\frequire\0", "config", "LuaSnip")
time([[Config for LuaSnip]], false)
-- Config for: lspsaga.nvim
time([[Config for lspsaga.nvim]], true)
try_loadstring("\27LJ\2\n�\v\0\0\6\0%\0-6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0025\3\6\0004\4\0\0=\4\a\3=\3\b\0025\3\t\0005\4\n\0=\4\v\3=\3\f\0025\3\r\0004\4\0\0=\4\14\3=\3\15\0025\3\16\0=\3\17\0025\3\18\0=\3\19\0025\3\20\0005\4\21\0=\4\v\3=\3\22\0025\3\23\0005\4\24\0005\5\25\0=\5\26\0045\5\27\0=\5\28\4=\4\v\3=\3\29\0025\3\30\0=\3\31\0025\3 \0005\4!\0005\5\"\0=\5#\4=\4\v\3=\3$\2B\0\2\1K\0\1\0\15diagnostic\17quit_in_show\1\3\0\0\6q\n<ESC>\1\0\3\16exec_action\6o\tquit\6q\19toggle_or_jump\t<CR>\1\0\f\20max_show_height\4��̙\3���\3\28diagnostic_only_current\1\30extend_relatedInformation\1\18border_follow\2\19text_hl_follow\2\15max_height\4��̙\3���\3\14max_width\4����\t����\3\22jump_num_shortcut\2\23show_normal_height\3\n\16show_layout\nfloat\21show_code_action\2\19max_show_width\4͙��\f̙��\3\14implement\1\0\4\17virtual_text\2\rpriority\3d\venable\2\tsign\2\vfinder\tquit\1\3\0\0\6q\n<ESC>\tedit\1\3\0\0\6o\t<CR>\1\0\6\vtabnew\6r\ttabe\6t\21close_in_preview\n<ESC>\vvsplit\6v\fjump_to\6p\nsplit\6h\1\0\2\15max_height\4\0����\3\21force_max_height\1\16code_action\1\0\2\tquit\6q\texec\t<CR>\1\0\3\21show_server_name\1\17num_shortcut\2\20extend_gitsigns\1\14lightbulb\1\0\6\17virtual_text\1\18sign_priority\3(\rdebounce\3\n\tsign\2\21enable_in_insert\2\venable\2\vrename\1\0\5\tmark\6x\fconfirm\t<CR>\14in_select\2\tquit\n<C-c>\texec\t<CR>\21symbol_in_winbar\20ignore_patterns\1\0\a\15color_mode\2\17respect_root\1\17folder_level\3\1\14show_file\2\17hide_keyword\2\venable\1\14separator\t \15definition\tkeys\1\0\6\tquit\6q\ttabe\v<C-c>t\tedit\v<C-c>o\vvsplit\v<C-c>v\nclose\v<C-c>k\nsplit\v<C-c>h\1\0\2\nwidth\4��̙\3���\3\vheight\4\0����\3\aui\tkind\1\0\t\vexpand\b\rwinblend\3\0\16code_action\t💡\ntitle\2\routgoing\t \rincoming\t \rcollapse\b\nhover\t \vborder\vsingle\19scroll_preview\1\0\1\20request_timeout\3�\23\1\0\2\16scroll_down\n<C-d>\14scroll_up\n<C-u>\nsetup\flspsaga\frequire\0", "config", "lspsaga.nvim")
time([[Config for lspsaga.nvim]], false)
-- Config for: Comment.nvim
time([[Config for Comment.nvim]], true)
try_loadstring("\27LJ\2\n�\2\0\0\6\0\f\0\0216\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0004\3\0\0=\3\4\0024\3\0\0=\3\5\0024\3\0\0=\3\6\0025\3\a\0=\3\b\0026\3\0\0'\5\t\0B\3\2\0029\3\n\3B\3\1\2=\3\v\2B\0\2\1K\0\1\0\rpre_hook\20create_pre_hook7ts_context_commentstring.integrations.comment_nvim\rmappings\1\0\2\nextra\2\nbasic\2\nextra\ropleader\ftoggler\1\0\2\fpadding\2\vsticky\2\nsetup\fComment\frequire\0", "config", "Comment.nvim")
time([[Config for Comment.nvim]], false)
-- Config for: vim-matchup
time([[Config for vim-matchup]], true)
try_loadstring("\27LJ\2\n\v\0\0\1\0\0\0\1K\0\1\0\0", "config", "vim-matchup")
time([[Config for vim-matchup]], false)
-- Config for: nvim-cmp
time([[Config for nvim-cmp]], true)
try_loadstring("\27LJ\2\nV\0\1\6\1\5\0\v9\1\0\0\18\3\1\0009\1\1\1'\4\2\0'\5\3\0B\1\4\2-\2\0\0009\2\4\2\18\4\1\0B\2\2\1K\0\1\0\3�\15lsp_expand\v(${1})\t%b()\tgsub\tbody�\3\0\2\a\0\18\0.5\2\1\0009\3\2\0009\3\3\0038\2\3\2\14\0\2\0X\3\1�)\2\0\0=\2\0\0016\2\5\0'\4\6\0B\2\2\0029\2\a\0029\3\4\0018\2\3\2=\2\4\0016\2\b\0009\2\t\0025\4\n\0009\5\2\0009\5\3\5B\2\3\2\15\0\2\0X\3\14�6\2\5\0'\4\v\0B\2\2\0029\2\f\2\18\6\0\0009\4\r\0B\4\2\0029\4\14\4B\2\2\3\15\0\2\0X\4\3�=\2\4\1=\3\15\1L\1\2\0006\2\5\0'\4\16\0B\2\2\0029\2\17\2\18\4\0\0\18\5\1\0B\2\3\2\18\1\2\0L\1\2\0\20format_tailwind%plugins.cmp.utils.custom_formats\18kind_hl_group\nlabel\24get_completion_item\rget_icon\22nvim-web-devicons\1\2\0\0\tpath\17tbl_contains\bvim\flspkind\16utils.icons\frequire\tkind\tname\vsource\1\0\2\tpath\3\0\rnvim_lsp\3\0\bdup�\15\1\0\14\0N\0�\0016\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0026\2\0\0'\4\3\0B\2\2\0026\3\0\0'\5\4\0B\3\2\0029\4\5\0005\6\t\0005\a\a\0003\b\6\0=\b\b\a=\a\n\0066\a\0\0'\t\v\0B\a\2\2=\a\f\0069\a\r\0009\a\14\a4\t\6\0005\n\15\0006\v\0\0'\r\16\0B\v\2\2=\v\17\n>\n\1\t5\n\18\0>\n\2\t5\n\19\0>\n\3\t5\n\20\0>\n\4\t5\n\21\0>\n\5\tB\a\2\2=\a\14\0065\a\22\0=\a\23\0065\a\24\0004\b\n\0006\t\0\0'\v\25\0B\t\2\0029\t\26\t>\t\1\b6\t\0\0'\v\27\0B\t\2\0029\t\28\t>\t\2\b6\t\0\0'\v\29\0B\t\2\0029\t\30\t>\t\3\b9\t\r\0009\t\31\t9\t \t>\t\4\b9\t\r\0009\t\31\t9\t!\t>\t\5\b9\t\r\0009\t\31\t9\t\"\t>\t\6\b9\t\r\0009\t\31\t9\t#\t>\t\a\b9\t\r\0009\t\31\t9\t$\t>\t\b\b9\t\r\0009\t\31\t9\t%\t>\t\t\b=\b&\a=\a'\0065\a)\0005\b(\0=\b*\a9\b+\0025\n,\0006\v\0\0'\r-\0B\v\2\0029\v\3\v=\v.\n3\v/\0=\v0\nB\b\2\2=\b1\a=\a2\0065\a5\0009\b3\0019\b4\b=\b6\a=\a7\0065\a;\0009\b\r\0009\b8\b9\b9\b5\n:\0B\b\2\2=\b<\a9\b\r\0009\b8\b9\b9\b5\n=\0B\b\2\2=\b>\a=\a8\0065\a?\0004\b\0\0=\b@\a=\aA\0069\aB\0009\aC\a=\aD\0065\aE\0=\aF\6B\4\2\0019\4\5\0009\4G\4'\6H\0005\aK\0009\b\r\0009\b\14\b4\n\3\0005\vI\0>\v\1\n4\v\3\0005\fJ\0>\f\1\vB\b\3\2=\b\14\aB\4\3\0016\4\0\0'\6L\0B\4\2\0029\4\5\4B\4\1\0016\4\0\0'\6M\0B\4\2\0029\4\5\4B\4\1\0012\0\0�K\0\1\0\24plugins.cmp.cmdline\24plugins.cmp.copilot\1\0\0\1\0\1\tname\vbuffer\1\0\1\tname\24conventionalcommits\14gitcommit\rfiletype\tview\1\0\1\fentries\vcustom\14preselect\tItem\18PreselectMode\17experimental\15ghost_text\1\0\0\18documentation\1\0\1\17winhighlight7Normal:TelescopeNormal,FloatBorder:TelescopeBorder\15completion\1\0\0\1\0\4\17winhighlight7Normal:TelescopeNormal,FloatBorder:TelescopeBorder\vborder\frounded\17side_padding\3\0\15col_offset\3����\15\rbordered\vwindow\17confirm_opts\rbehavior\1\0\1\vselect\2\fReplace\20ConfirmBehavior\15formatting\vformat\vbefore\0\15symbol_map\16utils.icons\1\0\2\14max_width\0032\tmode\16symbol_text\15cmp_format\vfields\1\0\0\1\4\0\0\tkind\tabbr\tmenu\fsorting\16comparators\norder\14sort_text\tkind\voffset\nexact\nscore\fcompare\nunder\25cmp-under-comparator\24prioritizeVariables\"plugins.cmp.utils.comparators\15prioritize\28copilot_cmp.comparators\1\0\1\20priority_weight\3\2\15duplicates\1\0\4\rnvim_lsp\3\0\vbuffer\3\1\fluasnip\3\0\tpath\3\1\1\0\4\tname\tpath\rpriority\3�\1\16group_index\3\1\19max_item_count\3\4\1\0\5\16group_index\3\2\19keyword_length\3\4\rpriority\3�\3\tname\vbuffer\19max_item_count\3\5\1\0\5\16group_index\3\1\19keyword_length\3\2\rpriority\3�\5\tname\fluasnip\19max_item_count\3\5\1\0\4\tname\fcopilot\rpriority\3�\a\16group_index\3\1\19keyword_length\3\0\17entry_filter&plugins.cmp.utils.limit_lsp_types\1\0\3\tname\rnvim_lsp\rpriority\3�\a\16group_index\3\1\fsources\vconfig\fmapping\25plugins.cmp.mappings\fsnippet\1\0\0\vexpand\1\0\0\0\nsetup\fluasnip\flspkind\18cmp.types.cmp\bcmp\frequire\0", "config", "nvim-cmp")
time([[Config for nvim-cmp]], false)
-- Config for: smart-splits.nvim
time([[Config for smart-splits.nvim]], true)
try_loadstring("\27LJ\2\n�\3\0\0\5\0\16\0\0196\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0025\3\6\0=\3\a\0025\3\b\0005\4\t\0=\4\n\0035\4\v\0=\4\f\3=\3\r\0025\3\14\0=\3\15\2B\0\2\1K\0\1\0\19ignored_events\1\3\0\0\rBufEnter\rWinEnter\16resize_mode\nhooks\1\0\0\16resize_keys\1\5\0\0\6h\6j\6k\6l\1\0\2\vsilent\1\rquit_key\n<ESC>\21ignored_buftypes\1\2\0\0\rNvimTree\22ignored_filetypes\1\0\6 cursor_follows_swapped_bufs\2\14log_level\tinfo\19default_amount\3\3(disable_multiplexer_nav_when_zoomed\2\fat_edge\twrap\25move_cursor_same_row\1\1\4\0\0\vnofile\rquickfix\vprompt\nsetup\17smart-splits\frequire\0", "config", "smart-splits.nvim")
time([[Config for smart-splits.nvim]], false)
-- Config for: typescript-tools.nvim
time([[Config for typescript-tools.nvim]], true)
try_loadstring("\27LJ\2\n�\16\0\0\a\0\17\0\0246\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0B\0\2\0025\1\f\0005\2\4\0005\3\5\0=\3\6\0024\3\0\0=\3\a\0025\3\b\0=\3\t\0025\3\n\0=\3\v\2=\2\r\0016\2\14\0009\2\15\2'\4\16\0\18\5\0\0\18\6\1\0B\2\4\2L\2\2\0\nforce\20tbl_deep_extend\bvim\rsettings\1\0\0\28tsserver_format_options\1\0\18\15semicolons\vignore\21indentSwitchCase\2#insertSpaceAfterCommaDelimiter\2 insertSpaceAfterConstructor\1-insertSpaceAfterSemicolonInForStatements\2-insertSpaceBeforeAndAfterBinaryOperators\0024insertSpaceAfterKeywordsInControlFlowStatements\0029insertSpaceAfterFunctionKeywordForAnonymousFunctions\2)insertSpaceBeforeFunctionParenthesis\1?insertSpaceAfterOpeningAndBeforeClosingNonemptyParenthesis\1<insertSpaceAfterOpeningAndBeforeClosingNonemptyBrackets\1:insertSpaceAfterOpeningAndBeforeClosingNonemptyBraces\0027insertSpaceAfterOpeningAndBeforeClosingEmptyBraces\2@insertSpaceAfterOpeningAndBeforeClosingTemplateStringBraces\1?insertSpaceAfterOpeningAndBeforeClosingJsxExpressionBraces\1\"insertSpaceAfterTypeAssertion\1(placeOpenBraceOnNewLineForFunctions\1,placeOpenBraceOnNewLineForControlBlocks\1\30tsserver_file_preferences\1\0\25'provideRefactorNotApplicableReason\2 generateReturnInDocTemplate\2*includeCompletionsForImportStatements\2&includeCompletionsWithSnippetText\2.includeCompletionsWithClassMemberSnippets\0026includeCompletionsWithObjectLiteralMethodSnippets\2'useLabelDetailsInCompletionEntries\2\31allowIncompleteCompletions\2\25displayPartsForJSDoc\2 disableLineTextInReferences\2#includeInlayParameterNameHints\tnone:includeInlayParameterNameHintsWhenArgumentMatchesName\1+includeInlayFunctionParameterTypeHints\1\"includeInlayVariableTypeHints\0015includeInlayVariableTypeHintsWhenTypeMatchesName\1-includeInlayPropertyDeclarationTypeHints\1,includeInlayFunctionLikeReturnTypeHints\1%includeInlayEnumMemberValueHints\1\20quotePreference\tauto importModuleSpecifierEnding\tauto jsxAttributeCompletionStyle\tauto\31allowTextChangesInNewFiles\2(providePrefixAndSuffixTextForRename\2\28allowRenameOfImportPath\2-includeAutomaticOptionalChainCompletions\2\21tsserver_plugins\26expose_as_code_action\1\4\0\0\ffix_all\24add_missing_imports\18remove_unused\1\0\3\31separate_diagnostic_server\1\26publish_diagnostic_on\17insert_leave\24tsserver_max_memory\tauto\rtsserver\20get_configs_for\blsp\frequire\0", "config", "typescript-tools.nvim")
time([[Config for typescript-tools.nvim]], false)
-- Config for: lsp_signature.nvim
time([[Config for lsp_signature.nvim]], true)
try_loadstring("\27LJ\2\n�\3\0\0\4\0\a\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\0024\3\0\0=\3\6\2B\0\2\1K\0\1\0\24extra_trigger_chars\17handler_opts\1\0\1\vborder\frounded\1\0\22\19always_trigger\1\17transparency\3d\17shadow_blend\3$\17shadow_guibg\nBlack\19timer_interval\3�\1\15max_height\3\f\15toggle_key\n<A-q>\fpadding\5\16hint_prefix\n🐼 \20floating_window\2\14doc_lines\3\n#floating_window_above_cur_line\2\26floating_window_off_x\3\1\26floating_window_off_y\3\0\18close_timeout\3�\31\ffix_pos\1\16hint_enable\1\twrap\2\14max_width\3P\tbind\2\16hint_scheme\vString\17hi_parameter LspSignatureActiveParameter\nsetup\18lsp_signature\frequire\0", "config", "lsp_signature.nvim")
time([[Config for lsp_signature.nvim]], false)
-- Config for: nvim-neoclip.lua
time([[Config for nvim-neoclip.lua]], true)
try_loadstring("\27LJ\2\n�\4\0\0\a\0\21\0\0276\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\0025\3\6\0=\3\a\0025\3\b\0=\3\t\0025\3\n\0=\3\v\0025\3\18\0005\4\14\0005\5\f\0004\6\0\0=\6\r\5=\5\15\0045\5\16\0004\6\0\0=\6\r\5=\5\17\4=\4\19\3=\3\20\2B\0\2\1K\0\1\0\tkeys\14telescope\1\0\0\6n\1\0\6\npaste\6p\tedit\6e\vselect\t<cr>\vdelete\6d\17paste_behind\6P\vreplay\6q\6i\1\0\0\vcustom\1\0\6\npaste\n<c-p>\tedit\n<c-e>\vselect\t<cr>\vdelete\n<c-d>\17paste_behind\n<c-k>\vreplay\n<c-q>\21on_custom_action\1\0\1\20close_telescope\2\14on_replay\1\0\3\fset_reg\1\20close_telescope\2\18move_to_front\1\ron_paste\1\0\3\fset_reg\1\20close_telescope\2\18move_to_front\1\14on_select\1\0\2\20close_telescope\2\18move_to_front\1\1\0\6\fhistory\0032\24content_spec_column\1\fpreview\2\21default_register\6\"\28default_register_macros\6q\25enable_macro_history\2\nsetup\fneoclip\frequire\0", "config", "nvim-neoclip.lua")
time([[Config for nvim-neoclip.lua]], false)
-- Config for: tokyonight.nvim
time([[Config for tokyonight.nvim]], true)
try_loadstring("\27LJ\2\nd\0\2\t\0\4\0\f6\2\0\0006\4\1\0'\6\2\0B\4\2\0029\4\3\4B\4\1\0A\2\0\4H\5\1�<\6\5\0F\5\3\3R\5�\127K\0\1\0\23get_all_highlights\16colorscheme\frequire\npairs�\2\1\0\5\0\v\0\0156\0\0\0'\2\1\0B\0\2\0029\1\2\0005\3\3\0005\4\4\0=\4\5\0033\4\6\0=\4\a\3B\1\2\0016\1\b\0009\1\t\1'\3\n\0B\1\2\1K\0\1\0\27colorscheme tokyonight\bcmd\bvim\18on_highlights\0\vstyles\1\0\6\rsidebars\16transparent\rkeywords\vitalic\14functions\tbold\14variables\tNONE\rcomments\vitalic\vfloats\16transparent\1\0\3\20terminal_colors\1\nstyle\nnight\16transparent\2\nsetup\15tokyonight\frequire\0", "config", "tokyonight.nvim")
time([[Config for tokyonight.nvim]], false)
-- Config for: lsp-colors.nvim
time([[Config for lsp-colors.nvim]], true)
try_loadstring("\27LJ\2\n~\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\4\fWarning\f#e0af68\16Information\f#0db9d7\tHint\f#10B981\nError\f#db4b4b\nsetup\15lsp-colors\frequire\0", "config", "lsp-colors.nvim")
time([[Config for lsp-colors.nvim]], false)
-- Config for: vim-illuminate
time([[Config for vim-illuminate]], true)
try_loadstring("\27LJ\2\n�\3\0\0\4\0\14\0\0236\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0024\3\0\0=\3\6\0025\3\a\0=\3\b\0024\3\0\0=\3\t\0024\3\0\0=\3\n\0024\3\0\0=\3\v\0024\3\0\0=\3\f\0024\3\0\0=\3\r\2B\0\2\1K\0\1\0%providers_regex_syntax_allowlist$providers_regex_syntax_denylist\20modes_allowlist\19modes_denylist\24filetypes_allowlist\23filetypes_denylist\1\16\0\0\fdirvish\rfugitive\fdirvish\rfugitive\nalpha\rNvimTree\tlazy\17neogitstatus\fTrouble\blir\fOutline\18spectre_panel\15toggleterm\19DressingSelect\20TelescopePrompt\23filetype_overrides\14providers\1\0\2\17under_cursor\2\ndelay\3�\2\1\4\0\0\blsp\15treesitter\nregex\14configure\15illuminate\frequire\0", "config", "vim-illuminate")
time([[Config for vim-illuminate]], false)
-- Config for: vim-visual-multi
time([[Config for vim-visual-multi]], true)
try_loadstring("\27LJ\2\n�\3\0\0\4\0\f\0\0256\0\0\0009\0\1\0)\1\0\0=\1\2\0006\0\0\0009\0\1\0)\1\0\0=\1\3\0006\0\0\0009\0\4\0009\0\5\0'\2\6\0005\3\a\0B\0\3\0016\0\0\0009\0\4\0009\0\5\0'\2\b\0005\3\t\0B\0\3\0016\0\0\0009\0\1\0005\1\v\0=\1\n\0K\0\1\0\1\0\4\aç\6l\6k\6j\6j\6h\6l\6k\22VM_custom_motions\1\0\a\20Add Cursor Down\f<C-M-k>\tUndo\6u\18Add Cursor Up\f<C-M-l>\15Find Under\n<C-n>\tRedo\n<C-r>\23Find Subword Under\n<C-n>\15Select All\14<leader>A\fVM_maps\1\0\3\vvisual\6 \vbuffer\6z\fdefault\6 \14VM_leader\17nvim_set_var\bapi\21VM_show_warnings\24VM_default_mappings\6g\bvim\0", "config", "vim-visual-multi")
time([[Config for vim-visual-multi]], false)
-- Config for: leap.nvim
time([[Config for leap.nvim]], true)
try_loadstring("\27LJ\2\n�\3\0\0\6\0\14\0\0196\0\0\0'\2\1\0B\0\2\0029\1\2\0B\1\1\0019\1\3\0005\3\4\0004\4\0\0=\4\5\0035\4\6\0=\4\a\0035\4\b\0005\5\t\0=\5\n\0045\5\v\0=\5\f\4=\4\r\3B\1\2\1K\0\1\0\17special_keys\16prev_target\1\3\0\0\n<tab>\6,\16next_target\1\3\0\0\f<enter>\6;\1\0\6\15next_group\f<space>\17multi_accept\f<enter>\18repeat_search\f<enter>\26next_phase_one_target\f<enter>\15prev_group\n<tab>\17multi_revert\16<backspace>\vlabels\1\n\0\0\6a\6s\6d\6f\6n\6j\6k\6l\aç\16safe_labels\1\0\2\19case_sensitive\1&max_highlighted_traversal_targets\3\n\nsetup\25add_default_mappings\tleap\frequire\0", "config", "leap.nvim")
time([[Config for leap.nvim]], false)
-- Config for: readline.nvim
time([[Config for readline.nvim]], true)
try_loadstring("\27LJ\2\n�\4\0\0\a\0(\0C6\0\0\0'\2\1\0B\0\2\0026\1\2\0009\1\3\0019\1\4\1\18\2\1\0005\4\5\0'\5\6\0'\6\a\0B\2\4\1\18\2\1\0005\4\b\0'\5\t\0'\6\n\0B\2\4\1\18\2\1\0005\4\v\0'\5\f\0009\6\r\0B\2\4\1\18\2\1\0005\4\14\0'\5\15\0009\6\16\0B\2\4\1\18\2\1\0005\4\17\0'\5\18\0009\6\19\0B\2\4\1\18\2\1\0005\4\20\0'\5\21\0009\6\22\0B\2\4\1\18\2\1\0005\4\23\0'\5\24\0009\6\25\0B\2\4\1\18\2\1\0005\4\26\0'\5\27\0009\6\28\0B\2\4\1\18\2\1\0005\4\29\0'\5\30\0009\6\28\0B\2\4\1\18\2\1\0005\4\31\0'\5 \0009\6!\0B\2\4\1\18\2\1\0005\4\"\0'\5#\0009\6$\0B\2\4\1\18\2\1\0005\4%\0'\5&\0009\6'\0B\2\4\1K\0\1\0\23backward_kill_line\n<C-u>\1\3\0\0\6i\6c\14kill_line\n<C-k>\1\3\0\0\6i\6c\21unix_word_rubout\n<C-w>\1\3\0\0\6i\6c\v<M-BS>\1\3\0\0\6i\6c\23backward_kill_word\v<C-BS>\1\3\0\0\6i\6c\14kill_word\n<M-d>\1\3\0\0\6i\6c\16end_of_line\n<C-e>\1\3\0\0\6i\6c\22beginning_of_line\n<C-a>\1\3\0\0\6i\6c\18backward_word\n<M-b>\1\3\0\0\6i\6c\17forward_word\n<M-f>\1\3\0\0\6i\6c\v<Left>\n<C-b>\1\3\0\0\6i\6c\f<Right>\n<C-f>\1\3\0\0\6i\6c\vkeymap\bapi\nutils\rreadline\frequire\0", "config", "readline.nvim")
time([[Config for readline.nvim]], false)
-- Config for: nvim-scrollbar
time([[Config for nvim-scrollbar]], true)
try_loadstring("\27LJ\2\n\v\0\0\1\0\0\0\1K\0\1\0�\b\1\0\b\0/\0A6\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0029\1\3\1B\1\1\0026\2\0\0'\4\4\0B\2\2\0029\2\3\0025\4\6\0003\5\5\0=\5\a\4B\2\2\0016\2\0\0'\4\b\0B\2\2\0029\2\3\0025\4\t\0005\5\n\0=\5\v\0045\5\r\0005\6\f\0=\6\14\0055\6\16\0005\a\15\0=\a\17\0069\a\18\0=\a\19\6=\6\20\0055\6\22\0005\a\21\0=\a\17\6=\6\23\0055\6\25\0005\a\24\0=\a\17\6=\6\26\0055\6\28\0005\a\27\0=\a\17\6=\6\29\0055\6\31\0005\a\30\0=\a\17\6=\6 \0055\6\"\0005\a!\0=\a\17\6=\6#\5=\5$\0045\5%\0=\5&\0045\5'\0=\5(\0045\5*\0005\6)\0=\6+\5=\5,\0045\5-\0=\5.\4B\2\2\1K\0\1\0\rhandlers\1\0\3\vcursor\2\15diagnostic\2\vsearch\2\fautocmd\vrender\1\0\0\1\b\0\0\16BufWinEnter\rTabEnter\14TermEnter\rWinEnter\16CmdwinLeave\15VimResized\16WinScrolled\23excluded_filetypes\1\3\0\0\vprompt\20TelescopePrompt\22excluded_buftypes\1\2\0\0\rterminal\nmarks\tMisc\1\0\2\rpriority\3\6\14highlight\vNormal\1\3\0\0\6-\6=\tHint\1\0\2\rpriority\3\5\14highlight\30DiagnosticVirtualTextHint\1\3\0\0\6-\6=\tInfo\1\0\2\rpriority\3\4\14highlight\30DiagnosticVirtualTextInfo\1\3\0\0\6-\6=\tWarn\1\0\2\rpriority\3\3\14highlight\30DiagnosticVirtualTextWarn\1\3\0\0\6-\6=\nError\1\0\2\rpriority\3\2\14highlight\31DiagnosticVirtualTextError\1\3\0\0\6-\6=\vSearch\ncolor\14secondary\ttext\1\0\2\rpriority\3\1\14highlight\vSearch\1\2\0\0\6-\vCursor\1\0\0\1\0\3\ttext\b•\14highlight\vNormal\rpriority\3\0\vhandle\1\0\4\ttext\6 \14highlight\17CursorColumn\24hide_if_all_visible\2\nblend\3\30\1\0\2\tshow\2\19set_highlights\2\14scrollbar\18override_lens\1\0\0\0\30scrollbar.handlers.search\nsetup\22tokyonight.colors\17utils.colors\frequire\0", "config", "nvim-scrollbar")
time([[Config for nvim-scrollbar]], false)
-- Config for: todo-comments.nvim
time([[Config for todo-comments.nvim]], true)
try_loadstring("\27LJ\2\n�\t\0\0\a\0<\0Q6\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0029\1\3\0015\3\4\0005\4\v\0005\5\a\0009\6\5\0009\6\6\6=\6\b\0055\6\t\0=\6\n\5=\5\f\0045\5\14\0009\6\5\0009\6\r\6=\6\b\5=\5\15\0045\5\17\0009\6\5\0009\6\16\6=\6\b\5=\5\18\0045\5\21\0009\6\19\0009\6\20\6=\6\b\0055\6\22\0=\6\n\5=\5\23\0045\5\25\0009\6\5\0009\6\24\6=\6\b\0055\6\26\0=\6\n\5=\5\27\0045\5\29\0009\6\5\0009\6\28\6=\6\b\0055\6\30\0=\6\n\5=\5\31\0045\5!\0009\6\5\0009\6 \6=\6\b\0055\6\"\0=\6\n\5=\5#\4=\4$\0035\4%\0=\4&\0035\4'\0004\5\0\0=\5(\4=\4)\0035\4+\0005\5*\0=\5,\0045\5-\0=\5.\0045\5/\0=\0050\0045\0051\0=\0052\0045\0053\0=\0054\0045\0055\0=\0056\4=\0047\0035\0048\0005\0059\0=\5:\4=\4;\3B\1\2\1K\0\1\0\vsearch\targs\1\6\0\0\18--color=never\17--no-heading\20--with-filename\18--line-number\r--column\1\0\2\fcommand\arg\fpattern\18\\b(KEYWORDS):\vcolors\ttest\1\3\0\0\15Identifier\f#FF00FF\fdefault\1\3\0\0\15Identifier\f#7C3AED\thint\1\3\0\0\19DiagnosticHint\f#10B981\tinfo\1\3\0\0\19DiagnosticInfo\f#2563EB\fwarning\1\4\0\0\19DiagnosticWarn\15WarningMsg\f#FBBF24\nerror\1\0\0\1\4\0\0\20DiagnosticError\rErrorMsg\f#DC2626\14highlight\fexclude\1\0\t\nafter\afg\fpattern\22.*<(KEYWORDS)\\s*:\fkeyword\twide\vbefore\5\18comments_only\2\17max_line_len\3�\3\14multiline\2\22multiline_pattern\a^.\22multiline_context\3\n\14gui_style\1\0\2\afg\tNONE\abg\tBOLD\rkeywords\tTEST\1\4\0\0\fTESTING\vPASSED\vFAILED\1\0\1\ncolor\ttest\16Speedometer\tNOTE\1\2\0\0\tINFO\1\0\1\ncolor\thint\fComment\tPERF\1\4\0\0\nOPTIM\16PERFORMANCE\rOPTIMIZE\1\0\0\16Performance\tWARN\1\3\0\0\fWARNING\bXXX\1\0\1\ncolor\fwarning\fWarning\16diagnostics\tHACK\1\0\1\ncolor\fwarning\tFire\tTODO\1\0\1\ncolor\tinfo\rBookMark\bFIX\1\0\0\balt\1\5\0\0\nFIXME\bBUG\nFIXIT\nISSUE\ticon\1\0\1\ncolor\nerror\bBug\aui\1\0\3\19merge_keywords\2\18sign_priority\3\b\nsigns\2\nsetup\18todo-comments\16utils.icons\frequire\0", "config", "todo-comments.nvim")
time([[Config for todo-comments.nvim]], false)
-- Config for: flutter-tools.nvim
time([[Config for flutter-tools.nvim]], true)
try_loadstring("\27LJ\2\n�\1\0\0\b\0\b\0\0296\0\0\0009\0\1\0009\0\2\0006\2\0\0009\2\1\0029\2\3\2'\4\4\0+\5\2\0+\6\1\0+\a\2\0B\2\5\2'\3\5\0+\4\2\0B\0\4\0016\0\0\0009\0\1\0009\0\2\0'\2\6\0'\3\5\0+\4\2\0B\0\4\0016\0\0\0009\0\1\0009\0\2\0'\2\a\0'\3\5\0+\4\2\0B\0\4\1K\0\1\0\a<<\a>>\6n\n<Esc>\27nvim_replace_termcodes\18nvim_feedkeys\bapi\bvim�\5\1\2\t\1\26\00066\2\0\0'\4\1\0B\2\2\0029\2\2\2\18\4\0\0\18\5\1\0B\2\3\0016\2\0\0'\4\3\0B\2\2\0029\2\4\2'\4\5\0B\2\2\1-\2\0\0'\4\6\0'\5\a\0'\6\b\0005\a\t\0B\2\5\1-\2\0\0'\4\6\0'\5\n\0'\6\v\0005\a\f\0B\2\5\1-\2\0\0'\4\6\0'\5\r\0'\6\14\0005\a\15\0B\2\5\1-\2\0\0'\4\6\0'\5\16\0006\6\0\0'\b\3\0B\6\2\0029\6\17\0069\6\5\0069\6\18\0065\a\19\0B\2\5\1-\2\0\0'\4\6\0'\5\20\0'\6\21\0005\a\22\0B\2\5\0016\2\23\0009\2\24\0023\4\25\0)\5�\nB\2\3\1K\0\1\0\0�\0\rdefer_fn\bvim\1\0\1\tdesc!flutter: run code generation;:TermExec cmd='flutter pub run build_runner watch'<CR>\15<leader>br\1\0\1\tdesc\26Flutter: open pallete\rcommands\15extensions\22<leader><leader>o\1\0\1\tdesc\21Flutter: restart\24:FlutterRestart<CR>\22<leader><leader>r\1\0\1\tdesc\20Flutter: reload\23:FlutterReload<CR>\14<leader>r\1\0\1\tdesc\30Flutter: Open [D]ev [L]og%:tabedit __FLUTTER_DEV_LOG__<CR>\15<leader>dl\6n\fflutter\19load_extension\14telescope\21common_on_attach\blsp\frequire�\4\1\0\b\0\27\0)6\0\0\0009\0\1\0009\0\2\0006\1\3\0'\3\4\0B\1\2\0029\1\5\0014\3\0\0B\1\2\0016\1\3\0'\3\6\0B\1\2\0029\1\5\0015\3\b\0005\4\a\0=\4\t\0034\4\0\0=\4\n\0035\4\f\0005\5\v\0=\5\r\4=\4\14\0035\4\15\0=\4\16\0035\4\17\0=\4\18\0035\4\20\0005\5\19\0=\5\21\0043\5\22\0=\5\23\0046\5\3\0'\a\24\0B\5\2\0029\5\25\5B\5\1\2=\5\26\4=\4\24\3B\1\2\0012\0\0�K\0\1\0\17capabilities\24common_capabilities\blsp\14on_attach\0\rsettings\1\0\0\1\0\2\14showTodos\1\27renameFilesWithClasses\vprompt\fdev_log\1\0\3\18notify_errors\2\ropen_cmd\ftabedit\fenabled\2\18widget_guides\1\0\1\fenabled\2\16decorations\15statusline\1\0\0\1\0\2\16app_version\1\vdevice\1\rdebugger\aui\1\0\0\1\0\2\vborder\frounded\23notification_style\vplugin\18flutter-tools\nsetup\19pubspec-assist\frequire\vkeymap\bapi\nutils\0", "config", "flutter-tools.nvim")
time([[Config for flutter-tools.nvim]], false)
-- Config for: undotree
time([[Config for undotree]], true)
try_loadstring("\27LJ\2\n�\2\0\0\3\0\b\0\0176\0\0\0009\0\1\0)\1\1\0=\1\2\0006\0\0\0009\0\1\0'\1\4\0=\1\3\0006\0\0\0009\0\1\0)\1\3\0=\1\5\0006\0\0\0009\0\6\0'\2\a\0B\0\2\1K\0\1\0�\1        function! g:Undotree_CustomMap() abort\n\t\tnmap <buffer> L <plug>UndotreeNextState\n\t\tnmap <buffer> K <plug>UndotreePreviousState\n        endfunction\n      \bcmd\26undotree_WindowLayout\b◉\27undotree_TreeNodeShape undotree_SetFocusWhenToggle\6g\bvim\0", "config", "undotree")
time([[Config for undotree]], false)
-- Config for: indent-blankline.nvim
time([[Config for indent-blankline.nvim]], true)
try_loadstring("\27LJ\2\n�\4\0\0\4\0\b\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\0025\3\6\0=\3\a\2B\0\2\1K\0\1\0\21filetype_exclude\1\16\0\0\ndbout\19neo-tree-popup\blog\14gitcommit\btxt\thelp\rNvimTree\bgit\24flutterToolsOutline\rundotree\rmarkdown\tnorg\borg\14orgagenda\5\20buftype_exclude\1\4\0\0\rterminal\14telescope\vnofile\1\0\v\tchar\b│\25show_current_context\2\18show_foldtext\1\18char_priority\3\f#show_trailing_blankline_indent\1\25space_char_blankline\6 \28show_first_indent_level\2\21show_end_of_line\1/show_current_context_start_on_current_line\1\31show_current_context_start\2\17context_char\b│\nsetup\21indent_blankline\frequire\0", "config", "indent-blankline.nvim")
time([[Config for indent-blankline.nvim]], false)
-- Config for: flit.nvim
time([[Config for flit.nvim]], true)
try_loadstring("\27LJ\2\n�\1\0\0\4\0\a\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0024\3\0\0=\3\6\2B\0\2\1K\0\1\0\topts\tkeys\1\0\2\14multiline\1\18labeled_modes\6v\1\0\4\6T\6T\6F\6F\6f\6f\6t\6t\nsetup\tflit\frequire\0", "config", "flit.nvim")
time([[Config for flit.nvim]], false)
-- Config for: comment-box.nvim
time([[Config for comment-box.nvim]], true)
try_loadstring("\27LJ\2\n�\2\0\0\4\0\b\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\0025\3\6\0=\3\a\2B\0\2\1K\0\1\0\tline\1\0\3\15line_start\b─\rline_end\b─\tline\b─\fborders\1\0\b\17bottom_right\b╯\rtop_left\b╭\14top_right\b╮\tleft\b│\vbottom\b─\nright\b│\btop\b─\16bottom_left\b╰\1\0\a\22outer_blank_lines\1\22inner_blank_lines\1\26line_blank_line_above\1\26line_blank_line_below\1\14doc_width\3P\14box_width\3<\15line_width\3U\nsetup\16comment-box\frequire\0", "config", "comment-box.nvim")
time([[Config for comment-box.nvim]], false)

-- Command lazy-loads
time([[Defining lazy-load commands]], true)
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
pcall(vim.api.nvim_create_user_command, 'TermOpen', function(cmdargs)
          require('packer.load')({'toggleterm.nvim'}, { cmd = 'TermOpen', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'toggleterm.nvim'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('TermOpen ', 'cmdline')
      end})
time([[Defining lazy-load commands]], false)

vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Event lazy-loads
time([[Defining lazy-load event autocommands]], true)
vim.cmd [[au BufReadPre * ++once lua require("packer.load")({'lualine.nvim', 'gitsigns.nvim', 'marks.nvim', 'bufferline.nvim'}, { event = "BufReadPre *" }, _G.packer_plugins)]]
vim.cmd [[au VimEnter * ++once lua require("packer.load")({'telescope.nvim', 'noice.nvim'}, { event = "VimEnter *" }, _G.packer_plugins)]]
vim.cmd [[au BufRead * ++once lua require("packer.load")({'hlsearch.nvim'}, { event = "BufRead *" }, _G.packer_plugins)]]
vim.cmd [[au InsertEnter * ++once lua require("packer.load")({'nvim-autopairs'}, { event = "InsertEnter *" }, _G.packer_plugins)]]
time([[Defining lazy-load event autocommands]], false)
vim.cmd("augroup END")

_G._packer.inside_compile = false
if _G._packer.needs_bufread == true then
  vim.cmd("doautocmd BufRead")
end
_G._packer.needs_bufread = false

if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
