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
  ["ChatGPT.nvim"] = {
    config = { "\27LJ\2\nÉ\r\0\0\a\0-\0;6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0005\4\5\0=\4\6\3=\3\a\0025\3\b\0005\4\f\0005\5\t\0005\6\n\0=\6\v\5=\5\r\0045\5\14\0=\5\15\4=\4\16\0035\4\18\0005\5\17\0=\5\19\4=\4\6\3=\3\20\0025\3\21\0005\4\22\0=\4\23\3=\3\24\0025\3\25\0005\4\26\0005\5\27\0=\5\v\4=\4\r\0035\4\28\0=\4\15\3=\3\29\0025\3\30\0005\4\31\0005\5 \0=\5\v\4=\4\r\0035\4!\0=\4\15\3=\3\"\0025\3%\0005\4#\0005\5$\0=\5\v\4=\4\r\0035\4&\0=\4\15\3=\3'\0025\3(\0=\3)\0025\3*\0=\3+\0024\3\0\0=\3,\2B\0\2\1K\0\1\0\18actions_paths\23openai_edit_params\1\0\4\16temperature\3\0\ntop_p\3\1\6n\3\1\nmodel\26code-davinci-edit-001\18openai_params\1\0\a\16temperature\3\0\21presence_penalty\3\0\15max_tokens\3¨\2\6n\3\1\22frequency_penalty\3\0\ntop_p\3\1\nmodel\18gpt-3.5-turbo\20settings_window\1\0\1\17winhighlight*Normal:Normal,FloatBorder:FloatBorder\1\0\0\1\0\1\btop\15 Settings \1\0\1\nstyle\frounded\16popup_input\1\0\1\17winhighlight*Normal:Normal,FloatBorder:FloatBorder\1\0\2\btop\r Prompt \14top_align\vcenter\1\0\2\nstyle\frounded\14highlight\16FloatBorder\1\0\2\vsubmit\v<c-CR>\vprompt\n ÔÜí \17popup_window\1\0\1\17winhighlight*Normal:Normal,FloatBorder:FloatBorder\1\0\1\btop\14 ChatGPT \1\0\2\nstyle\frounded\14highlight\16FloatBorder\1\0\1\rfiletype\fchatgpt\17popup_layout\tsize\1\0\2\nwidth\b80%\vheight\b80%\1\0\2\rposition\b50%\rrelative\veditor\tchat\nclose\1\0\n\19rename_session\6r\19delete_session\6d\20toggle_settings\n<C-o>\14yank_last\n<C-y>\19yank_last_code\n<C-k>\18cycle_windows\n<Tab>\16new_session\n<C-n>\19select_session\f<Space>\14scroll_up\n<C-u>\16scroll_down\n<C-d>\1\2\0\0\n<C-c>\20sessions_window\16win_options\1\0\1\17winhighlight*Normal:Normal,FloatBorder:FloatBorder\vborder\1\0\0\ttext\1\0\1\btop\15 Sessions \1\0\1\nstyle\frounded\1\0\4\18question_sign\bÔÄá\17loading_text\29Loading, please wait ...\16answer_sign\bÔÆß\20max_line_length\3x\27edit_with_instructions\fkeymaps\1\0\5\20toggle_settings\n<C-o>\24use_output_as_input\n<C-i>\16toggle_diff\n<C-d>\18cycle_windows\n<Tab>\vaccept\n<C-y>\1\0\1\tdiff\1\1\0\2\18yank_register\6+ predefined_chat_gpt_promptsQhttps://raw.githubusercontent.com/f/awesome-chatgpt-prompts/main/prompts.csv\nsetup\fchatgpt\frequire\0" },
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/ChatGPT.nvim",
    url = "https://github.com/jackMort/ChatGPT.nvim"
  },
  ["Comment.nvim"] = {
    config = { "\27LJ\2\nÇ\2\0\0\6\0\f\0\0216\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0004\3\0\0=\3\4\0024\3\0\0=\3\5\0024\3\0\0=\3\6\0025\3\a\0=\3\b\0026\3\0\0'\5\t\0B\3\2\0029\3\n\3B\3\1\2=\3\v\2B\0\2\1K\0\1\0\rpre_hook\20create_pre_hook7ts_context_commentstring.integrations.comment_nvim\rmappings\1\0\2\nbasic\2\nextra\2\nextra\ropleader\ftoggler\1\0\2\vsticky\2\fpadding\2\nsetup\fComment\frequire\0" },
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/Comment.nvim",
    url = "https://github.com/numToStr/Comment.nvim"
  },
  LuaSnip = {
    config = { "\27LJ\2\né\1\0\1\3\1\5\0\20-\1\0\0009\1\0\1\15\0\1\0X\2\15Ä-\1\0\0009\1\0\0019\1\1\0019\2\2\0008\1\2\1\15\0\1\0X\2\bÄ-\1\0\0009\1\0\0019\1\3\1\14\0\1\0X\1\3Ä-\1\0\0009\1\4\1B\1\1\1K\0\1\0\0¿\19unlink_current\16jump_active\bbuf\18current_nodes\fsession™\4\1\0\a\0\25\0'6\0\0\0'\2\1\0B\0\2\0026\1\2\0009\1\3\0019\1\4\1'\3\5\0005\4\6\0B\1\3\0026\2\2\0009\2\3\0029\2\a\2'\4\b\0005\5\t\0=\1\n\0055\6\v\0=\6\f\0053\6\r\0=\6\14\5B\2\3\0019\2\15\0'\4\16\0005\5\17\0B\2\3\0019\2\15\0'\4\18\0005\5\19\0B\2\3\0016\2\0\0'\4\20\0B\2\2\0029\2\21\2B\2\1\0019\2\22\0009\2\23\0025\4\24\0B\2\2\0012\0\0ÄK\0\1\0\1\0\1\24region_check_events\16CursorMoved\15set_config\vconfig\14lazy_load luasnip.loaders.from_vscode\1\3\0\0\thtml\15javascript\20javascriptreact\1\3\0\0\thtml\15typescript\20typescriptreact\20filetype_extend\rcallback\0\fpattern\1\3\0\0\bs:n\bi:*\ngroup\1\0\1\tdesc<Forget the current snippet when leaving the insert mode\16ModeChanged\24nvim_create_autocmd\1\0\1\nclear\2\30UnlinkSnippetOnModeChange\24nvim_create_augroup\bapi\bvim\fluasnip\frequire\0" },
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
    config = { "\27LJ\2\nW\0\4\b\0\5\0\14\18\6\1\0009\4\0\1'\a\1\0B\4\3\2\15\0\4\0X\5\2Ä'\4\2\0X\5\1Ä'\4\3\0'\5\4\0\18\6\4\0\18\a\0\0&\5\a\5L\5\2\0\6 \tÔÅ± \tÔÅú \nerror\nmatch≥\a\1\0\a\0\20\0\0276\0\0\0'\2\1\0B\0\2\0029\1\2\0005\3\17\0005\4\3\0005\5\4\0=\5\5\0043\5\6\0=\5\a\0044\5\3\0005\6\b\0>\6\1\0055\6\t\0>\6\2\5=\5\n\0045\5\v\0=\5\f\0045\5\r\0005\6\14\0=\6\15\5=\5\16\4=\4\18\0034\4\0\0=\4\19\3B\1\2\1K\0\1\0\15highlights\foptions\1\0\0\nhover\vreveal\1\2\0\0\nclose\1\0\2\ndelay\3»\1\fenabled\2\20separator_style\1\3\0\0\6|\6|\foffsets\1\0\4\15text_align\vcenter\ttext\20Flutter Outline\14separator\2\rfiletype\24flutterToolsOutline\1\0\4\15text_align\vcenter\ttext\18File Explorer\14separator\2\rfiletype\rNvimTree\26diagnostics_indicator\0\14indicator\1\0\1\nstyle\14underline\1\0\25\25enforce_regular_tabs\1\22max_prefix_length\3\15\19truncate_names\1\fnumbers\tnone\18modified_icon\b‚óè\fsort_by\ttabs\23left_mouse_command\14buffer %d\20max_name_length\3\18\18close_command\16bdelete! %d\28show_buffer_close_icons\1\16diagnostics\rnvim_lsp\15close_icon\bÔÄç\16color_icons\2\22buffer_close_icon\bÔôï\20show_close_icon\1\tmode\ttabs\22show_buffer_icons\2\24right_mouse_command\16bdelete! %d!diagnostics_update_in_insert\1\rtab_size\3\18\26show_duplicate_prefix\1\24show_tab_indicators\1\22left_trunc_marker\bÔÇ®\23right_trunc_marker\bÔÇ©\27always_show_bufferline\2\nsetup\15bufferline\frequire\0" },
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
    config = { "\27LJ\2\n„\2\0\0\4\0\b\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\0025\3\6\0=\3\a\2B\0\2\1K\0\1\0\tline\1\0\3\rline_end\b‚îÄ\15line_start\b‚îÄ\tline\b‚îÄ\fborders\1\0\b\tleft\b‚îÇ\nright\b‚îÇ\16bottom_left\b‚ï∞\17bottom_right\b‚ïØ\rtop_left\b‚ï≠\14top_right\b‚ïÆ\vbottom\b‚îÄ\btop\b‚îÄ\1\0\a\22inner_blank_lines\1\22outer_blank_lines\1\26line_blank_line_below\1\14box_width\3<\14doc_width\3P\15line_width\3d\26line_blank_line_above\1\nsetup\16comment-box\frequire\0" },
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
    config = { "\27LJ\2\n\v\0\1\1\0\0\0\1L\0\2\0\v\0\1\1\0\0\0\1L\0\2\0ö\n\1\0\6\0001\0?6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\19\0005\3\3\0005\4\4\0=\4\5\0035\4\6\0=\4\a\0034\4\0\0=\4\b\0035\4\t\0=\4\n\0035\4\f\0005\5\v\0=\5\r\0045\5\14\0=\5\15\4=\4\16\0033\4\17\0=\4\18\3=\3\20\0025\3\21\0005\4\22\0=\4\23\0035\4\25\0005\5\24\0=\5\26\4=\4\27\0035\4\29\0005\5\28\0=\5\30\4=\4\31\0035\4 \0005\5!\0=\5\"\0045\5#\0=\5\b\0045\5$\0=\5\n\4=\4%\0035\4&\0004\5\0\0=\5\b\0045\5'\0=\5\n\0045\5(\0=\5\5\0045\5)\0=\5\a\0045\5*\0=\5+\0045\5,\0=\5\16\0043\5-\0=\5\18\4=\4.\0034\4\0\0=\4/\3=\0030\2B\0\2\1K\0\1\0\vselect\25format_item_override\fbuiltin\0\1\0\3\t<CR>\fConfirm\n<Esc>\nClose\n<C-c>\nClose\15min_height\1\3\0\0\3\n\4ö≥ÊÃ\tô≥¶˛\3\1\3\0\0\3(\4ö≥ÊÃ\tô≥¶˛\3\1\3\0\0\3å\1\4ö≥ÊÃ\tô≥¶ˇ\3\1\0\2\rwinblend\3\n\17winhighlight\"Normal:Normal,NormalNC:Normal\1\0\4\vanchor\aNW\rrelative\veditor\15max_height\4Õô≥Ê\fÃô≥ˇ\3\vborder\frounded\bnui\1\0\1\rwinblend\3\n\1\0\2\rswapfile\1\rfiletype\19DressingSelect\vborder\1\0\1\nstyle\frounded\1\0\6\15max_height\3(\14max_width\3P\14min_width\3(\15min_height\3\n\rrelative\veditor\rposition\b50%\ffzf_lua\fwinopts\1\0\0\1\0\2\nwidth\4\0ÄÄÄˇ\3\vheight\4ö≥ÊÃ\tô≥Ê˛\3\bfzf\vwindow\1\0\0\1\0\2\nwidth\4\0ÄÄÄˇ\3\vheight\4ö≥ÊÃ\tô≥Ê˛\3\fbackend\1\6\0\0\14telescope\ffzf_lua\bfzf\fbuiltin\bnui\1\0\2\fenabled\2\16trim_prompt\2\ninput\1\0\0\roverride\0\rmappings\6i\1\0\4\t<Up>\16HistoryPrev\t<CR>\fConfirm\v<Down>\16HistoryNext\n<C-c>\nClose\6n\1\0\0\1\0\2\n<Esc>\nClose\t<CR>\fConfirm\16win_options\1\0\3\rwinblend\3\0\twrap\1\17winhighlight7Normal:TelescopeNormal,FloatBorder:TelescopeBorder\16buf_options\14min_width\1\3\0\0\3\20\4ö≥ÊÃ\tô≥¶˛\3\14max_width\1\3\0\0\3å\1\4Õô≥Ê\fÃô≥ˇ\3\1\0\t\16insert_only\2\rrelative\vcursor\20start_in_insert\2\19default_prompt\vInput:\17prefer_width\3(\17prompt_align\tleft\vanchor\aSW\vborder\frounded\fenabled\2\nsetup\rdressing\frequire\0" },
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/dressing.nvim",
    url = "https://github.com/stevearc/dressing.nvim"
  },
  ["flutter-tools.nvim"] = {
    config = { "\27LJ\2\né\4\0\2\b\1\20\0(6\2\0\0'\4\1\0B\2\2\0029\2\2\2\18\4\0\0\18\5\1\0B\2\3\1-\2\0\0'\4\3\0'\5\4\0'\6\5\0005\a\6\0B\2\5\1-\2\0\0'\4\3\0'\5\a\0'\6\b\0005\a\t\0B\2\5\1-\2\0\0'\4\3\0'\5\n\0'\6\v\0005\a\f\0B\2\5\1-\2\0\0'\4\3\0'\5\r\0'\6\14\0005\a\15\0B\2\5\0016\2\16\0009\2\17\0026\4\0\0'\6\18\0B\4\2\0029\4\19\4B\4\1\0A\2\0\1K\0\1\0\0\0\24get_base_highlights\16colorscheme\fset_hls\nutils\1\0\1\tdesc!flutter: run code generation;:TermExec cmd='flutter pub run build_runner watch'<CR>\15<leader>br\1\0\1\tdesc\26Flutter: open pallete\17:Flutter<CR>\22<leader><leader>o\1\0\1\tdesc\21Flutter: restart\24:FlutterRestart<CR>\22<leader><leader>r\1\0\1\tdesc\20Flutter: reload\23:FlutterReload<CR>\14<leader>r\6n\21common_on_attach\blsp\frequireµ\3\1\0\b\1\23\0\0316\0\0\0'\2\1\0B\0\2\0029\1\2\0005\3\4\0005\4\3\0=\4\5\0034\4\0\0=\4\6\0035\4\b\0005\5\a\0=\5\t\4=\4\n\0035\4\v\0=\4\f\0035\4\r\0=\4\14\0035\4\16\0005\5\15\0=\5\17\0043\5\18\0=\5\19\0046\5\0\0'\a\20\0B\5\2\0029\5\21\5B\5\1\2=\5\22\4=\4\20\3B\1\2\1K\0\1\0\1¿\17capabilities\24common_capabilities\blsp\14on_attach\0\rsettings\1\0\0\1\0\2\14showTodos\2\27renameFilesWithClasses\vprompt\fdev_log\1\0\2\fenabled\2\ropen_cmd\ftabedit\18widget_guides\1\0\1\fenabled\2\16decorations\15statusline\1\0\0\1\0\2\16app_version\2\vdevice\2\rdebugger\aui\1\0\0\1\0\2\23notification_style\vplugin\vborder\frounded\nsetup\18flutter-tools\frequire\0" },
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
    config = { "\27LJ\2\nW\0\4\n\1\4\0\14\14\0\3\0X\4\1Ä4\3\0\0-\4\0\0=\4\0\0036\4\1\0009\4\2\0049\4\3\4\18\6\0\0\18\a\1\0\18\b\2\0\18\t\3\0B\4\5\1K\0\1\0\0¿\bset\vkeymap\bvim\vbuffer#\0\0\2\1\1\0\4-\0\0\0009\0\0\0B\0\1\1K\0\1\0\0\0\14next_hunkg\1\0\3\1\a\0\0156\0\0\0009\0\1\0009\0\2\0\15\0\0\0X\1\2Ä'\0\3\0002\0\aÄ6\0\0\0009\0\4\0003\2\5\0B\0\2\1'\0\6\0002\0\0ÄL\0\2\0L\0\2\0\1¿\r<Ignore>\0\rschedule\a]c\tdiff\awo\bvim#\0\0\2\1\1\0\4-\0\0\0009\0\0\0B\0\1\1K\0\1\0\0\0\14prev_hunkg\1\0\3\1\a\0\0156\0\0\0009\0\1\0009\0\2\0\15\0\0\0X\1\2Ä'\0\3\0002\0\aÄ6\0\0\0009\0\4\0003\2\5\0B\0\2\1'\0\6\0002\0\0ÄL\0\2\0L\0\2\0\1¿\r<Ignore>\0\rschedule\a[c\tdiff\awo\bvim1\0\0\3\1\2\0\5-\0\0\0009\0\0\0005\2\1\0B\0\2\1K\0\1\0\1¿\1\0\1\tfull\2\15blame_line(\0\0\3\1\2\0\5-\0\0\0009\0\0\0'\2\1\0B\0\2\1K\0\1\0\1¿\6~\rdiffthisÅ\b\1\1\t\0002\0Z6\1\0\0009\1\1\0019\1\2\0013\2\3\0\18\3\2\0'\5\4\0'\6\5\0003\a\6\0005\b\a\0B\3\5\1\18\3\2\0'\5\4\0'\6\b\0003\a\t\0005\b\n\0B\3\5\1\18\3\2\0005\5\v\0'\6\f\0'\a\r\0005\b\14\0B\3\5\1\18\3\2\0005\5\15\0'\6\16\0'\a\17\0005\b\18\0B\3\5\1\18\3\2\0'\5\4\0'\6\19\0009\a\20\0015\b\21\0B\3\5\1\18\3\2\0'\5\4\0'\6\22\0009\a\23\0015\b\24\0B\3\5\1\18\3\2\0'\5\4\0'\6\25\0009\a\26\0015\b\27\0B\3\5\1\18\3\2\0'\5\4\0'\6\28\0009\a\29\0015\b\30\0B\3\5\1\18\3\2\0'\5\4\0'\6\31\0003\a \0005\b!\0B\3\5\1\18\3\2\0'\5\4\0'\6\"\0009\a#\0015\b$\0B\3\5\1\18\3\2\0'\5\4\0'\6%\0009\a&\0015\b'\0B\3\5\1\18\3\2\0'\5\4\0'\6(\0003\a)\0005\b*\0B\3\5\1\18\3\2\0'\5\4\0'\6+\0009\a,\0015\b-\0B\3\5\1\18\3\2\0005\5.\0'\6/\0'\a0\0005\b1\0B\3\5\0012\0\0ÄK\0\1\0\1\0\1\tdesc\16Select Hunk#:<C-U>Gitsigns select_hunk<CR>\aih\1\3\0\0\6o\6x\1\0\1\tdesc\18Toggle Delete\19toggle_deleted\16<leader>gtd\1\0\1\tdesc\16Diff This ~\0\16<leader>ghD\1\0\1\tdesc\14Diff This\rdiffthis\16<leader>ghd\1\0\1\tdesc\22Toggle Line Blame\30toggle_current_line_blame\16<leader>gtb\1\0\1\tdesc\15Blame Line\0\16<leader>ghb\1\0\1\tdesc\17Preview Hunk\17preview_hunk\16<leader>ghp\1\0\1\tdesc\17Reset Buffer\17reset_buffer\16<leader>ghR\1\0\1\tdesc\20Undo Stage Hunk\20undo_stage_hunk\16<leader>ghu\1\0\1\tdesc\17Stage Buffer\17stage_buffer\16<leader>ghA\1\0\1\tdesc\15Reset Hunk\29:Gitsigns reset_hunk<CR>\16<leader>ghr\1\3\0\0\6n\6v\1\0\1\tdesc\23[G]it [H]unk [A]dd\29:Gitsigns stage_hunk<CR>\16<leader>gha\1\3\0\0\6n\6v\1\0\1\texpr\2\0\a[c\1\0\1\texpr\2\0\a]c\6n\0\rgitsigns\vloaded\fpackageÛ\a\1\0\6\0\26\0\0293\0\0\0006\1\1\0'\3\2\0B\1\2\0029\1\3\0015\3\15\0005\4\5\0005\5\4\0=\5\6\0045\5\a\0=\5\b\0045\5\t\0=\5\n\0045\5\v\0=\5\f\0045\5\r\0=\5\14\4=\4\16\0035\4\17\0=\4\18\0035\4\19\0=\4\20\0035\4\21\0=\4\22\0035\4\23\0=\4\24\3=\0\25\3B\1\2\1K\0\1\0\14on_attach\tyadm\1\0\1\venable\1\19preview_config\1\0\5\nstyle\fminimal\vborder\frounded\rrelative\vcursor\bcol\3\1\brow\3\0\28current_line_blame_opts\1\0\4\ndelay\3Ë\a\14virt_text\2\22ignore_whitespace\1\18virt_text_pos\beol\17watch_gitdir\1\0\2\rinterval\3Ë\a\17follow_files\2\nsigns\1\0\n!current_line_blame_formatter1<author>, <author_time:%Y-%m-%d> - <summary>\24attach_to_untracked\2\14word_diff\1\nnumhl\1\18sign_priority\3\6\20update_debounce\3»\1\15signcolumn\2\vlinehl\1\23current_line_blame\1\20max_file_length\3¿∏\2\17changedelete\1\0\4\vlinehl\21GitSignsChangeLn\ttext\b‚ñç\ahl\19GitSignsChange\nnumhl\21GitSignsChangeNr\14topdelete\1\0\4\vlinehl\21GitSignsDeleteLn\ttext\b‚ñæ\ahl\19GitSignsDelete\nnumhl\21GitSignsDeleteNr\vdelete\1\0\4\vlinehl\21GitSignsDeleteLn\ttext\b‚ñ∏\ahl\19GitSignsDelete\nnumhl\21GitSignsDeleteNr\vchange\1\0\4\vlinehl\21GitSignsChangeLn\ttext\b‚ñç\ahl\19GitSignsChange\nnumhl\21GitSignsChangeNr\badd\1\0\0\1\0\4\vlinehl\18GitSignsAddLn\ttext\b‚ñç\ahl\16GitSignsAdd\nnumhl\18GitSignsAddNr\nsetup\rgitsigns\frequire\0\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/opt/gitsigns.nvim",
    url = "https://github.com/lewis6991/gitsigns.nvim"
  },
  ["hop.nvim"] = {
    config = { "\27LJ\2\nO\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\tkeys\22√ßalskdjfwoeicmvn\nsetup\bhop\frequire\0" },
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
    config = { "\27LJ\2\nî\4\0\0\4\0\b\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\0025\3\6\0=\3\a\2B\0\2\1K\0\1\0\21filetype_exclude\1\16\0\0\ndbout\19neo-tree-popup\blog\14gitcommit\btxt\thelp\rNvimTree\bgit\24flutterToolsOutline\rundotree\rmarkdown\tnorg\borg\14orgagenda\5\20buftype_exclude\1\4\0\0\rterminal\14telescope\vnofile\1\0\f\21show_end_of_line\1\18char_priority\3\f\18show_foldtext\1\tchar\b‚îÇ/show_current_context_start_on_current_line\1\28show_first_indent_level\2\31show_current_context_start\2\25space_char_blankline\6 \17context_char\b‚îÇ\25show_current_context\2\19use_treesitter\2#show_trailing_blankline_indent\1\nsetup\21indent_blankline\frequire\0" },
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/indent-blankline.nvim",
    url = "https://github.com/lukas-reineke/indent-blankline.nvim"
  },
  ["kanagawa.nvim"] = {
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/kanagawa.nvim",
    url = "https://github.com/rebelot/kanagawa.nvim"
  },
  ["lsp-colors.nvim"] = {
    config = { "\27LJ\2\n~\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\4\tHint\f#10B981\16Information\f#0db9d7\fWarning\f#e0af68\nError\f#db4b4b\nsetup\15lsp-colors\frequire\0" },
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/lsp-colors.nvim",
    url = "https://github.com/folke/lsp-colors.nvim"
  },
  ["lsp_signature.nvim"] = {
    config = { "\27LJ\2\nÄ\4\0\0\4\0\a\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\0024\3\0\0=\3\6\2B\0\2\1K\0\1\0\24extra_trigger_chars\17handler_opts\1\0\1\vborder\frounded\1\0\23\26floating_window_off_x\3\1\26floating_window_off_y\3\0\18close_timeout\3†\31\ffix_pos\1\16hint_enable\1\twrap\2\16hint_prefix\nüêº \17shadow_blend\3$\16hint_scheme\vString\17hi_parameter LspSignatureActiveParameter\19always_trigger\1\17transparency\3d\17shadow_guibg\nBlack\19timer_interval\3»\1\nnoice\2\15toggle_key\n<A-q>\tbind\1\15max_height\3\f\14max_width\3P\fpadding\5\14doc_lines\3\n\20floating_window\1#floating_window_above_cur_line\2\nsetup\18lsp_signature\frequire\0" },
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
    config = { "\27LJ\2\nŸ\6\0\0\6\0\27\0!6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0025\3\6\0004\4\0\0=\4\a\3=\3\b\0025\3\t\0004\4\0\0=\4\n\3=\3\v\0025\3\f\0=\3\r\0025\3\14\0=\3\15\0025\3\16\0005\4\17\0=\4\18\3=\3\19\0025\3\20\0005\4\21\0005\5\22\0=\5\23\0045\5\24\0=\5\25\4=\4\18\3=\3\26\2B\0\2\1K\0\1\0\vfinder\tquit\1\3\0\0\6q\n<ESC>\tedit\1\3\0\0\6o\t<CR>\1\0\6\nsplit\6i\vvsplit\6s\vtabnew\6r\21close_in_preview\n<ESC>\ttabe\6t\fjump_to\6p\1\0\2\15max_height\4\0ÄÄÄˇ\3\21force_max_height\1\16code_action\tkeys\1\0\2\tquit\6q\texec\t<CR>\1\0\3\17num_shortcut\2\21show_server_name\1\20extend_gitsigns\2\14lightbulb\1\0\5\17virtual_text\2\venable\1\18sign_priority\3(\tsign\1\21enable_in_insert\2\vrename\1\0\5\texec\t<CR>\fconfirm\t<CR>\14in_select\2\tquit\n<C-c>\tmark\6x\21symbol_in_winbar\20ignore_patterns\1\0\a\14show_file\2\venable\1\17respect_root\1\17folder_level\3\1\15color_mode\2\14separator\t Ôëä\17hide_keyword\2\aui\tkind\1\0\t\nhover\tÔáò \rcollapse\bÔÅ∏\vborder\vsingle\rincoming\tÔ£∂ \routgoing\tÔ£∫ \rwinblend\3\0\ntitle\2\vexpand\bÔÅî\16code_action\tüí°\19scroll_preview\1\0\1\20request_timeout\3–\15\1\0\2\16scroll_down\n<C-d>\14scroll_up\n<C-u>\nsetup\flspsaga\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/opt/lspsaga.nvim",
    url = "https://github.com/glepnir/lspsaga.nvim"
  },
  ["lualine.nvim"] = {
    config = { "\27LJ\2\nL\0\0\1\0\1\0\2'\0\0\0L\0\2\0A        asdasd                                              L\0\0\1\0\1\0\2'\0\0\0L\0\2\0A        asdasd                                              1\0\0\3\2\3\0\a-\0\0\0009\0\0\0009\0\1\0'\1\2\0-\2\1\0&\0\2\0L\0\2\0\0¿\3¿\6 \bGit\bgité\b\1\0\14\0008\0i6\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0026\2\0\0'\4\3\0B\2\2\0026\3\0\0'\5\4\0B\3\2\0029\3\5\3B\3\1\0029\4\6\0015\6\14\0005\a\b\0006\b\0\0'\n\a\0B\b\2\2=\b\t\a5\b\n\0=\b\v\a5\b\f\0=\b\r\a=\a\15\0065\a\16\0=\a\17\0064\a\0\0=\a\18\0066\a\0\0'\t\19\0B\a\2\2=\a\20\0064\a\0\0=\a\21\0065\a\22\0004\b\0\0=\b\23\a4\b\3\0005\t\24\0>\t\1\b5\t\25\0>\t\2\b=\b\26\a=\a\27\0065\a/\0005\b\29\0005\t\28\0=\t\30\b4\t\0\0=\t\20\b5\t(\0004\n\3\0005\v\31\0>\v\1\n5\v&\0003\f \0>\f\1\v5\f\"\0009\r!\2=\r#\f9\r$\2=\r%\f=\f'\v>\v\2\n=\n)\t4\n\3\0005\v*\0>\v\1\n5\v-\0003\f+\0>\f\1\v5\f,\0009\r!\2=\r#\f9\r$\2=\r%\f=\f'\v>\v\2\n=\n.\t=\t\21\b>\b\1\a5\b1\0005\t0\0=\t\30\b4\t\0\0=\t\20\b5\t6\0004\n\3\0005\v5\0003\f2\0>\f\1\v5\f3\0009\r4\2=\r%\f=\f'\v>\v\1\n=\n.\t=\t\21\b>\b\3\a=\a7\6B\4\2\0012\0\0ÄK\0\1\0\15extensions\1\0\0\1\0\0\tcyan\1\0\2\abg\tNone\bgui\19underline,bold\0\1\0\0\1\2\0\0\rNvimTree\1\3\0\0\0\rquickfix\14lualine_b\1\0\0\1\0\1\bgui\14underline\0\1\2\0\0\rfilename\14lualine_a\1\0\0\ncolor\1\0\0\afg\tgray\abg\1\0\1\bgui\14underline\fouterbg\0\1\2\0\0\rfilename\14filetypes\1\0\0\1\2\0\0\15toggleterm\22inactive_sections\14lualine_c\1\2\0\0\rfilename\1\2\0\0\a%=\14lualine_x\1\0\0\vwinbar\rsections\"plugins.ui.lualine.statusline\23disabled_filetypes\frefresh\1\0\3\ftabline\3Ë\a\15statusline\3Ë\a\vwinbar\3d\foptions\1\0\2\18icons_enabled\2\17globalstatus\2\23section_separators\1\0\2\nright\5\tleft\5\25component_separators\1\0\2\nright\5\tleft\5\ntheme\1\0\0\29plugins.ui.lualine.theme\nsetup\18get_repo_name\nutils\17utils.colors\flualine\16utils.icons\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/opt/lualine.nvim",
    url = "https://github.com/nvim-lualine/lualine.nvim"
  },
  ["marks.nvim"] = {
    config = { "\27LJ\2\n«\1\0\0\4\0\a\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0004\3\0\0=\3\4\0025\3\5\0=\3\6\2B\0\2\1K\0\1\0\rmappings\1\0\6\fpreview\am:\15delete_buf\adM\tprev\am[\bset\6m\tnext\am]\16delete_line\adm\18builtin_marks\1\0\2\22force_write_shada\1\21default_mappings\1\nsetup\nmarks\frequire\0" },
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
    config = { "\27LJ\2\nò\1\0\1\t\1\a\0\19-\1\0\0009\1\0\1B\1\1\0026\2\1\0006\4\2\0'\5\3\0\18\6\0\0&\5\6\5B\2\3\3\15\0\2\0X\4\aÄ6\4\4\0009\4\5\4'\6\6\0\18\a\1\0\18\b\3\0B\4\4\2\18\1\4\0L\1\2\0\4¿\nforce\15tbl_extend\bvim\17lsp.servers.\frequire\npcall\23get_commom_configs5\0\1\5\2\1\0\t-\1\0\0\18\3\0\0B\1\2\2-\2\1\0008\2\0\0029\2\0\2\18\4\1\0B\2\2\1K\0\1\0\6¿\1¿\nsetupJ\0\0\4\3\2\0\f-\0\0\0009\0\0\0B\0\1\1-\0\1\0'\2\1\0B\0\2\2-\1\2\0009\1\1\0019\1\0\1\18\3\0\0B\1\2\1K\0\1\0\2¿\6¿\1¿\vlua_ls\nsetupz\0\0\6\1\6\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0-\3\0\0'\5\4\0B\3\2\2=\3\5\2B\0\2\1K\0\1\0\6¿\vserver\rtsserver\1\0\2\ndebug\1\21disable_commands\1\nsetup\15typescript\frequire∏\4\1\0\v\0\30\00056\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0026\2\0\0'\4\3\0B\2\2\0026\3\0\0'\5\4\0B\3\2\0026\4\0\0'\6\5\0B\4\2\0026\5\0\0'\a\6\0B\5\2\0029\6\a\0005\b\v\0005\t\b\0005\n\t\0=\n\n\t=\t\f\bB\6\2\0019\6\a\0055\b\14\0005\t\r\0=\t\15\bB\6\2\0019\6\a\0035\b\17\0009\t\16\4=\t\15\bB\6\2\0013\6\18\0009\a\19\0035\t\22\0003\n\20\0>\n\1\t3\n\21\0=\n\23\t3\n\24\0=\n\25\tB\a\2\0016\a\0\0'\t\26\0B\a\2\0029\a\27\a'\b\29\0=\b\28\a2\0\0ÄK\0\1\0\vsingle\vborder\20default_options\25lspconfig.ui.windows\rtsserver\0\vlua_ls\1\0\0\0\0\19setup_handlers\0\1\0\1\27automatic_installation\2\fservers\21ensure_installed\1\0\1\20automatic_setup\2\1\3\0\0\truff\ryamllint\aui\1\0\0\nicons\1\0\3\24package_uninstalled\b‚úó\22package_installed\b‚úì\20package_pending\b‚ü≥\1\0\1\vborder\frounded\nsetup\18mason-null-ls\blsp\20mason-lspconfig\vneodev\14lspconfig\nmason\frequire\0" },
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
    config = { "\27LJ\2\nº\v\0\0\t\0009\0O5\0\1\0005\1\0\0=\1\2\0005\1\3\0=\1\4\0005\1\6\0005\2\5\0=\2\2\0015\2\a\0=\2\4\0016\2\b\0'\4\t\0B\2\2\0029\2\n\0025\4\28\0005\5\v\0004\6\0\0=\6\4\0055\6\r\0005\a\f\0=\a\14\0065\a\15\0=\a\16\0065\a\17\0=\a\18\0065\a\19\0=\a\2\0065\a\21\0005\b\20\0=\b\22\a=\a\23\0065\a\24\0=\a\25\0064\a\0\0=\a\26\6=\6\27\5=\5\14\0045\5\29\0=\5\30\0045\5\31\0004\6\0\0=\6 \5=\5!\0044\5\3\0>\0\1\5>\1\2\5=\5\"\0045\5$\0005\6#\0=\6%\0055\6&\0=\6'\0055\6(\0004\a\0\0=\a\4\6=\6)\0055\6*\0005\a+\0=\a,\0064\a\0\0=\a\4\6=\6-\0055\6.\0004\a\0\0=\a\4\6=\6/\0055\0060\0005\a1\0005\b2\0=\b\27\a5\b3\0=\b4\a=\a\4\6=\0065\5=\0056\0045\0057\0=\0058\4B\2\2\1K\0\1\0\fpresets\1\0\5\26long_message_to_split\2\15inc_rename\1\19lsp_doc_border\2\18bottom_search\2\20command_palette\1\blsp\18documentation\16win_options\1\0\2\17conceallevel\3\3\18concealcursor\6n\1\2\0\0\14{message}\1\0\3\vrender\nplain\tlang\rmarkdown\freplace\2\1\0\1\tview\nhover\fmessage\1\0\2\fenabled\2\tview\vnotify\14signature\14auto_open\1\0\4\rthrottle\0032\fenabled\2\fluasnip\2\ftrigger\2\1\0\1\fenabled\2\nhover\1\0\1\fenabled\2\roverride\1\0\3 cmp.entry.get_documentation\0021vim.lsp.util.convert_input_to_markdown_lines\2\"vim.lsp.util.stylize_markdown\2\rprogress\1\0\0\1\0\1\fenabled\1\vroutes\14popupmenu\15kind_icons\1\0\2\fbackend\bnui\fenabled\2\rmessages\1\0\6\14view_warn\vnotify\tview\vnotify\fenabled\2\16view_search\16virtualtext\17view_history\rmessages\15view_error\vnotify\1\0\0\vformat\ninput\thelp\1\0\2\fpattern\20^:%s*he?l?p?%s+\ticon\bÔüï\blua\fpattern\1\0\2\tlang\blua\ticon\bÓò†\1\4\0\0\16^:%s*lua%s+\20^:%s*lua%s*=%s*\14^:%s*=%s*\1\0\3\fpattern\v^:%s*!\tlang\tbash\ticon\bÓûï\14search_up\1\0\4\tkind\vsearch\fpattern\b^%?\tlang\nregex\ticon\fÔÄÇ ÔÑÇ\16search_down\1\0\4\tkind\vsearch\fpattern\a^/\tlang\nregex\ticon\fÔÄÇ ÔÑÉ\fcmdline\1\0\0\1\0\3\fpattern\a^:\tlang\bvim\ticon\bÔÅî\1\0\2\fenabled\2\tview\fcmdline\nsetup\nnoice\frequire\1\0\1\tskip\2\1\0\0\1\0\2\nevent\rmsg_show\tkind\17search_count\topts\1\0\1\tskip\2\vfilter\1\0\0\1\0\3\tkind\5\nevent\rmsg_show\tfind\fwritten\0" },
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
    config = { "\27LJ\2\nz\0\0\5\0\b\0\f6\0\0\0009\0\1\0009\0\2\0009\0\3\0005\2\6\0006\3\0\0009\3\4\0039\3\5\3B\3\1\2=\3\a\2B\0\2\1K\0\1\0\nbufnr\1\0\1\15timeout_ms\3∏\23\25nvim_get_current_buf\bapi\vformat\bbuf\blsp\bvim§\1\1\2\b\0\n\0\0159\2\0\0'\4\1\0B\2\2\2\15\0\2\0X\3\tÄ6\2\2\0009\2\3\0029\2\4\2'\4\5\0'\5\6\0003\6\a\0005\a\b\0=\1\t\aB\2\5\1K\0\1\0\vbuffer\1\0\1\tdesc\17[lsp] format\0\15<Leader>ff\6n\bset\vkeymap\bvim\28textDocument/formatting\20supports_methodÂ\4\1\0\r\0!\2?6\0\0\0'\2\1\0B\0\2\0029\1\2\0009\2\3\0005\4\29\0004\5\14\0009\6\4\0019\6\5\0069\6\6\0065\b\f\0005\t\a\0006\n\b\0009\n\t\n9\n\n\n'\f\v\0B\n\2\0?\n\0\0=\t\r\bB\6\2\2>\6\1\0059\6\4\0019\6\14\6>\6\2\0059\6\4\0019\6\15\6>\6\3\0059\6\4\0019\6\16\6>\6\4\0059\6\4\0019\6\17\6>\6\5\0059\6\4\0019\6\18\6>\6\6\0059\6\4\0019\6\19\6>\6\a\0059\6\20\0019\6\21\6>\6\b\0059\6\20\0019\6\22\6>\6\t\0059\6\20\0019\6\23\6>\6\n\0059\6\24\0019\6\25\6>\6\v\0059\6\26\0019\6\27\6>\6\f\0056\6\0\0'\b\28\0B\6\2\0?\6\1\0=\5\30\0043\5\31\0=\5 \4B\2\2\1K\0\1\0\14on_attach\0\fsources\1\0\0/typescript.extensions.null-ls.code-actions\reslint_d\17code_actions\fluasnip\15completion\ryamllint\truff\tfish\16diagnostics\16fish_indent\16dart_format\fyamlfmt\ffixjson\14prettierd\nblack\15extra_args\1\0\0005~/.config/nvim/lua/lsp/linter-config/stylua.toml\vexpand\afn\bvim\1\2\0\0\18--config-path\twith\vstylua\15formatting\nsetup\rbuiltins\fnull-ls\frequire\5ÄÄ¿ô\4\27ÄÄ¿ô\4\0" },
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/null-ls.nvim",
    url = "https://github.com/jose-elias-alvarez/null-ls.nvim"
  },
  ["nvim-autopairs"] = {
    config = { "\27LJ\2\nÄ\2\0\0\5\0\f\0\0156\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\5\0005\4\4\0=\4\6\0035\4\a\0=\4\b\3=\3\t\0025\3\n\0=\3\v\2B\0\2\1K\0\1\0\21disable_filetype\1\3\0\0\20TelescopePrompt\bvim\14ts_config\15javascript\1\3\0\0\vstring\20template_string\blua\1\0\1\tjava\1\1\3\0\0\vstring\vsource\1\0\2\rcheck_ts\2\30enable_check_bracket_line\1\nsetup\19nvim-autopairs\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/opt/nvim-autopairs",
    url = "https://github.com/windwp/nvim-autopairs"
  },
  ["nvim-cmp"] = {
    config = { "\27LJ\2\n-\0\1\4\1\2\0\5-\1\0\0009\1\0\0019\3\1\0B\1\2\1K\0\1\0\3¿\tbody\15lsp_expand£\3\0\2\a\0\19\0.5\2\1\0009\3\2\0009\3\3\0038\2\3\2\14\0\2\0X\3\1Ä)\2\0\0=\2\0\0019\2\4\1\a\2\5\0X\2\fÄ9\2\6\0009\2\a\2\15\0\2\0X\3\bÄ6\2\b\0'\4\t\0B\2\2\0029\2\n\2\18\4\0\0\18\5\1\0B\2\3\2\18\1\2\0006\2\v\0009\2\f\0025\4\r\0009\5\2\0009\5\3\5B\2\3\2\15\0\2\0X\3\14Ä6\2\b\0'\4\14\0B\2\2\0029\2\15\2\18\6\0\0009\4\16\0B\4\2\0029\4\17\4B\2\2\3\15\0\2\0X\4\3Ä=\2\4\1=\3\18\1L\1\2\0L\1\2\0\18kind_hl_group\nlabel\24get_completion_item\rget_icon\22nvim-web-devicons\1\2\0\0\tpath\17tbl_contains\bvim\20format_tailwind%plugins.cmp.utils.custom_formats\frequire\18documentation\20completion_item\nColor\tkind\tname\vsource\1\0\2\tpath\3\0\rnvim_lsp\3\0\bdupπ\14\1\0\14\0L\0†\0016\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0026\2\0\0'\4\3\0B\2\2\0026\3\0\0'\5\4\0B\3\2\0029\4\5\0005\6\t\0005\a\a\0003\b\6\0=\b\b\a=\a\n\0066\a\0\0'\t\v\0B\a\2\2=\a\f\0069\a\r\0009\a\14\a4\t\6\0005\n\15\0>\n\1\t5\n\16\0>\n\2\t5\n\17\0>\n\3\t5\n\18\0>\n\4\t5\n\19\0>\n\5\tB\a\2\2=\a\14\0065\a\20\0=\a\21\0065\a$\0004\b\f\0009\t\r\0009\t\22\t9\t\23\t>\t\1\b9\t\r\0009\t\22\t9\t\24\t>\t\2\b6\t\0\0'\v\25\0B\t\2\0029\t\26\t>\t\3\b6\t\0\0'\v\27\0B\t\2\0029\t\28\t>\t\4\b6\t\0\0'\v\27\0B\t\2\0029\t\29\t>\t\5\b9\t\r\0009\t\22\t9\t\30\t>\t\6\b9\t\r\0009\t\22\t9\t\29\t>\t\a\b9\t\r\0009\t\22\t9\t\31\t>\t\b\b6\t\0\0'\v \0B\t\2\0029\t!\t>\t\t\b9\t\r\0009\t\22\t9\t\"\t>\t\n\b9\t\r\0009\t\22\t9\t#\t>\t\v\b=\b%\a=\a&\0065\a(\0005\b'\0=\b)\a9\b*\0025\n+\0006\v\0\0'\r,\0B\v\2\0029\v\3\v=\v-\n3\v.\0=\v/\nB\b\2\2=\b0\a=\a1\0065\a4\0009\b2\0019\b3\b=\b5\a=\a6\0065\a:\0009\b\r\0009\b7\b9\b8\b5\n9\0B\b\2\2=\b;\a9\b\r\0009\b7\b9\b8\b5\n<\0B\b\2\2=\b=\a=\a7\0065\a>\0=\a?\0069\a@\0009\aA\a=\aB\0065\aC\0=\aD\6B\4\2\0019\4\5\0009\4E\4'\6F\0005\aI\0009\b\r\0009\b\14\b4\n\3\0005\vG\0>\v\1\n4\v\3\0005\fH\0>\f\1\vB\b\3\2=\b\14\aB\4\3\0016\4\0\0'\6J\0B\4\2\0029\4\5\4B\4\1\0016\4\0\0'\6K\0B\4\2\0029\4\5\4B\4\1\0012\0\0ÄK\0\1\0\24plugins.cmp.cmdline\24plugins.cmp.copilot\1\0\0\1\0\1\tname\vbuffer\1\0\1\tname\24conventionalcommits\14gitcommit\rfiletype\tview\1\0\1\fentries\vcustom\14preselect\tItem\18PreselectMode\17experimental\1\0\1\15ghost_text\2\18documentation\1\0\1\17winhighlight7Normal:TelescopeNormal,FloatBorder:TelescopeBorder\15completion\1\0\0\1\0\4\vborder\frounded\15col_offset\3˝ˇˇˇ\15\17winhighlight7Normal:TelescopeNormal,FloatBorder:TelescopeBorder\17side_padding\3\1\rbordered\vwindow\17confirm_opts\rbehavior\1\0\1\vselect\1\fReplace\20ConfirmBehavior\15formatting\vformat\vbefore\0\15symbol_map\16utils.icons\1\0\2\tmode\vsymbol\14max_width\0032\15cmp_format\vfields\1\0\0\1\4\0\0\tkind\tabbr\tmenu\fsorting\16comparators\1\0\0\norder\14sort_text\nunder\25cmp-under-comparator\rlocality\voffset\nscore\15prioritize\28copilot_cmp.comparators\25deprioritize_snippet\"plugins.cmp.utils.comparators\nexact\tkind\fcompare\15duplicates\1\0\4\tpath\3\1\vbuffer\3\1\fluasnip\3\0\rnvim_lsp\3\0\1\0\4\tname\vbuffer\19keyword_length\3\4\16group_index\3\2\19max_item_count\3\5\1\0\3\tname\fcopilot\19keyword_length\3\0\16group_index\3\1\1\0\3\tname\tpath\16group_index\3\1\19max_item_count\3\4\1\0\2\tname\rnvim_lsp\16group_index\3\1\1\0\5\16group_index\3\1\19keyword_length\3\2\rpriority\3\a\19max_item_count\3\5\tname\fluasnip\fsources\vconfig\fmapping\25plugins.cmp.mappings\fsnippet\1\0\0\vexpand\1\0\0\0\nsetup\fluasnip\flspkind\18cmp.types.cmp\bcmp\frequire\0" },
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-colorizer.lua"] = {
    config = { "\27LJ\2\nõ\1\0\0\4\0\b\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0025\3\6\0=\3\a\2B\0\2\1K\0\1\0\25user_default_options\1\0\3\tmode\15background\rtailwind\tboth\nnames\1\14filetypes\1\0\0\1\2\0\0\6*\nsetup\14colorizer\frequire\0" },
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/nvim-colorizer.lua",
    url = "https://github.com/norcalli/nvim-colorizer.lua"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-navbuddy"] = {
    config = { "\27LJ\2\nk\0\0\t\0\5\0\0166\0\0\0'\2\1\0B\0\2\0029\0\2\0004\1\0\0006\2\3\0\18\4\0\0B\2\2\4H\5\4Ä\18\a\5\0'\b\4\0&\a\b\a<\6\a\1F\5\3\3R\5˙\127L\1\2\0\6 \npairs\flspkind\16utils.icons\frequire\b\1\0\v\0M\0X6\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0023\2\3\0009\3\4\0005\5\14\0005\6\5\0005\a\a\0005\b\6\0=\b\b\a5\b\t\0=\b\n\a5\b\v\0=\b\f\a=\a\r\6=\6\15\0055\6\16\0005\a\17\0=\a\18\6=\6\19\5\18\6\2\0B\6\1\2=\6\18\0055\6\21\0009\a\20\1=\a\22\0069\a\20\1=\a\23\0069\a\24\1=\a\25\0069\a\26\1=\a\27\0069\a\28\1=\a\29\0069\a\30\1=\a\31\0069\a \1=\a!\0069\a\"\1=\a#\0069\a$\1=\a%\0069\a&\1=\a'\0069\a(\1=\a)\0069\a*\1=\a+\0069\a,\1=\a-\0069\a.\1=\a/\0069\a0\1=\a1\0069\a2\1=\a3\0069\a4\1=\a5\0069\a6\1=\a7\0069\a8\1=\a9\0069\a:\1=\a;\0069\a<\1=\a=\0069\a<\1=\a>\0069\a?\1=\a@\0069\aA\1=\aB\0069\aC\0015\tE\0005\nD\0=\nF\tB\a\2\2=\aG\6=\6H\0055\6I\0=\6J\0055\6K\0=\6L\5B\3\2\1K\0\1\0\18source_buffer\1\0\3\14highlight\2\rreorient\nsmart\16follow_node\2\blsp\1\0\1\16auto_attach\1\rmappings\6t\18layout_config\1\0\1\20layout_strategy\15horizontal\1\0\4\20prompt_position\btop\18preview_width\4\0ÄÄÄˇ\3\nwidth\4≥ÊÃô\3≥Êåˇ\3\vheight\4≥ÊÃô\3≥Êåˇ\3\14telescope\n<A-l>\fmove_up\n<A-k>\14move_down\6o\f<enter>\vselect\6c\fcomment\6F\16fold_delete\6f\16fold_create\6d\vdelete\6r\vrename\6A\17append_scope\6a\16append_name\6I\17insert_scope\6i\16insert_name\6Y\15yank_scope\6y\14yank_name\6V\17visual_scope\6v\16visual_name\0060\troot\a√ß\rchildren\6j\vparent\6l\21previous_sibling\6k\17next_sibling\6q\n<esc>\1\0\0\nclose\17node_markers\nicons\1\0\3\18leaf_selected\n ‚Üí \tleaf\a  \vbranch\t Ôë†\1\0\1\fenabled\2\vwindow\1\0\1\25use_default_mappings\2\rsections\nright\1\0\1\fpreview\tleaf\bmid\1\0\1\tsize\b40%\tleft\1\0\0\1\0\1\tsize\b20%\1\0\3\tsize\b60%\rposition\b50%\vborder\vsingle\nsetup\0\26nvim-navbuddy.actions\18nvim-navbuddy\frequire\0" },
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/nvim-navbuddy",
    url = "https://github.com/SmiteshP/nvim-navbuddy"
  },
  ["nvim-navic"] = {
    config = { "\27LJ\2\nı\a\0\0\b\0.\0ô\0016\0\0\0'\2\1\0B\0\2\0029\1\2\0006\2\0\0'\4\3\0B\2\2\0029\2\4\0025\4)\0005\5\a\0009\6\5\1'\a\6\0&\6\a\6=\6\5\0059\6\b\1=\6\b\0059\6\t\1'\a\6\0&\6\a\6=\6\t\0059\6\n\1'\a\6\0&\6\a\6=\6\n\0059\6\v\1'\a\6\0&\6\a\6=\6\v\0059\6\f\1'\a\6\0&\6\a\6=\6\f\0059\6\r\1'\a\6\0&\6\a\6=\6\r\0059\6\14\1'\a\6\0&\6\a\6=\6\14\0059\6\15\1'\a\6\0&\6\a\6=\6\15\0059\6\16\1'\a\6\0&\6\a\6=\6\16\0059\6\17\1'\a\6\0&\6\a\6=\6\17\0059\6\18\1'\a\6\0&\6\a\6=\6\18\0059\6\19\1'\a\6\0&\6\a\6=\6\19\0059\6\20\1'\a\6\0&\6\a\6=\6\20\0059\6\21\1'\a\6\0&\6\a\6=\6\21\0059\6\22\1'\a\6\0&\6\a\6=\6\22\0059\6\23\1'\a\6\0&\6\a\6=\6\23\0059\6\24\1'\a\6\0&\6\a\6=\6\24\0059\6\25\1'\a\6\0&\6\a\6=\6\25\0059\6\26\1'\a\6\0&\6\a\6=\6\26\0059\6\27\1'\a\6\0&\6\a\6=\6\27\0059\6\28\1'\a\6\0&\6\a\6=\6\28\0059\6\29\1'\a\6\0&\6\a\6=\6\29\0059\6\30\1'\a\6\0&\6\a\6=\6\30\0059\6\31\1'\a\6\0&\6\a\6=\6\31\0059\6 \1'\a\6\0&\6\a\6=\6 \0059\6!\1'\a\6\0&\6\a\6=\6!\0059\6\"\1'\a\6\0&\6\a\6=\6\"\0059\6#\1'\a\6\0&\6\a\6=\6#\0059\6$\1'\a\6\0&\6\a\6=\6$\0059\6%\1'\a\6\0&\6\a\6=\6%\0059\6&\1'\a\6\0&\6\a\6=\6&\0059\6'\1'\a\6\0&\6\a\6=\6'\0059\6(\1'\a\6\0&\6\a\6=\6(\5=\5*\4'\5\6\0009\6+\0009\6,\6'\a\6\0&\5\a\5=\5-\4B\2\2\1K\0\1\0\14separator\17ChevronRight\aui\nicons\1\0\3\14highlight\2\16depth_limit\3\4\26depth_limit_indicator\a..\rVariable\nValue\tUnit\18TypeParameter\tText\vStruct\vString\fSnippet\14Reference\rProperty\fPackage\rOperator\vObject\vNumber\tNull\14Namespace\vModule\vMethod\fKeyword\bKey\14Interface\rFunction\vFolder\tFile\nField\nEvent\15EnumMember\tEnum\16Constructor\rConstant\nColor\nClass\fBoolean\1\0\0\6 \nArray\nsetup\15nvim-navic\flspkind\16utils.icons\frequire\0" },
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/nvim-navic",
    url = "https://github.com/SmiteshP/nvim-navic"
  },
  ["nvim-notify"] = {
    config = { "\27LJ\2\n·\2\0\0\a\0\19\0\0276\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0029\2\3\0005\4\4\0005\5\a\0009\6\5\0019\6\6\6=\6\b\0059\6\5\0019\6\t\6=\6\n\0059\6\5\0019\6\v\6=\6\f\0059\6\r\0019\6\14\6=\6\15\0059\6\r\0019\6\16\6=\6\17\5=\5\18\4B\2\2\1K\0\1\0\nicons\nTRACE\vPencil\nDEBUG\bBug\aui\tINFO\16Information\tWARN\fWarning\nERROR\1\0\0\nError\16diagnostics\1\0\b\nlevel\3\2\ftimeout\3–\15\rtop_down\2\14max_width\3x\vrender\fdefault\22background_colour\f#121212\vstages\22fade_in_slide_out\bfpg\3\30\nsetup\16utils.icons\vnotify\frequire\0" },
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/nvim-notify",
    url = "https://github.com/rcarriga/nvim-notify"
  },
  ["nvim-numbertoggle"] = {
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/nvim-numbertoggle",
    url = "https://github.com/sitiom/nvim-numbertoggle"
  },
  ["nvim-tree.lua"] = {
    config = { "\27LJ\2\n7\0\1\5\0\4\0\a6\1\0\0009\1\1\1'\3\2\0009\4\3\0&\3\4\3B\1\2\1K\0\1\0\nfname\nedit \bcmd\bvimµ\3\0\1\t\1\19\1J5\1\0\0006\2\1\0009\2\2\0029\2\3\0029\4\4\0B\2\2\2\b\2\0\0X\2\2Ä+\2\1\0X\3\1Ä+\2\2\0009\3\4\0\a\3\5\0X\3\aÄ6\3\1\0009\3\6\0039\4\a\0008\3\4\0039\3\b\3\6\3\5\0X\3\2Ä+\3\1\0X\4\1Ä+\3\2\0006\4\1\0009\4\6\0049\5\a\0008\4\5\0049\4\t\4\14\0\2\0X\5\3Ä\14\0\3\0X\5\1ÄK\0\1\0006\5\1\0009\5\n\5\18\a\1\0\18\b\4\0B\5\3\2\15\0\5\0X\6\1ÄK\0\1\0006\5\1\0009\5\2\0059\5\v\0059\a\4\0B\5\2\2\b\5\0\0X\5\2Ä+\5\1\0X\6\1Ä+\5\2\0\15\0\5\0X\6\14Ä6\6\1\0009\6\f\0069\6\r\6B\6\1\0016\6\1\0009\6\f\0069\6\14\0069\b\a\0B\6\2\0016\6\1\0009\6\f\0069\6\15\0069\b\4\0B\6\2\1-\6\0\0009\6\16\0069\6\17\0065\b\18\0B\6\2\1K\0\1\0\2¿\1\0\2\nfocus\1\14find_file\2\vtoggle\ttree\acd\abw\tenew\bcmd\16isdirectory\17tbl_contains\aft\fbuftype\bbuf\abo\5\tfile\17filereadable\afn\bvim\1\2\0\0\14gitcommit\2%\0\1\2\1\0\0\a-\1\0\0\5\0\1\0X\1\2Ä+\1\1\0X\2\1Ä+\1\2\0L\1\2\0\0¿ë\1\0\0\4\1\6\1\0206\0\0\0009\0\1\0009\0\2\0B\0\1\2\21\0\0\0\t\0\0\0X\0\1ÄX\0\vÄ6\0\0\0009\0\3\0'\2\4\0B\0\2\0016\0\0\0009\0\1\0009\0\5\0-\2\0\0:\2\1\2+\3\2\0B\0\3\1K\0\1\0\4¿\19nvim_win_close\17NvimTreeOpen\bcmd\19nvim_list_wins\bapi\bvim\2Õ\3\1\1\v\1\18\1H6\1\0\0009\1\1\0019\1\2\1\18\3\0\0B\1\2\0026\2\0\0009\2\1\0029\2\3\2\18\4\0\0B\2\2\0026\3\0\0009\3\4\0039\3\5\3\18\5\2\0B\3\2\2:\3\1\0036\4\0\0009\4\6\0043\6\a\0006\a\0\0009\a\1\a9\a\b\a\18\t\1\0B\a\2\0A\4\1\0026\5\0\0009\5\t\0056\a\0\0009\a\1\a9\a\3\a\18\b\4\0B\5\3\0029\6\n\3\18\b\6\0009\6\v\6'\t\f\0B\6\3\2\15\0\6\0X\a\vÄ6\6\0\0009\6\r\6\18\b\5\0B\6\2\2\14\0\6\0X\6\25Ä-\6\0\0009\6\14\0069\6\15\6B\6\1\1X\6\20Ä\21\6\5\0\t\6\0\0X\6\17Ä6\6\0\0009\6\4\0069\6\5\6:\b\1\5B\6\2\2:\6\1\0069\a\n\6\18\t\a\0009\a\v\a'\n\f\0B\a\3\2\15\0\a\0X\b\4Ä6\a\0\0009\a\16\a3\t\17\0B\a\2\0012\0\0ÄK\0\1\0\2¿\0\rschedule\nclose\ttree\16tbl_isempty\20.*NvimTree_%d*$\nmatch\tname\ftbl_map\27nvim_tabpage_list_wins\0\15tbl_filter\15getbufinfo\afn\21nvim_win_get_buf\25nvim_win_get_tabpage\bapi\bvim\2y\0\0\a\1\a\0\0156\0\0\0006\2\1\0009\2\2\0029\2\3\2'\4\4\0B\2\2\0A\0\0\0026\1\1\0009\1\5\0016\3\6\0-\5\0\0\18\6\0\0B\3\3\0A\1\0\1K\0\1\0\4¿\npcall\18schedule_wrap\r<amatch>\vexpand\afn\bvim\rtonumberÅ\1\0\0\4\2\a\0\17-\0\0\0009\0\0\0B\0\1\2\v\0\0\0X\1\1ÄK\0\1\0006\1\1\0009\1\2\1'\3\3\0B\1\2\1-\1\1\0009\1\4\0019\1\5\0019\1\6\1\18\3\0\0B\1\2\1K\0\1\0\1¿\2¿\btab\topen\tnode\rwincmd l\bcmd\bvim\23get_node_at_cursorX\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\afn2nvim-tree.actions.tree-modifiers.collapse-all\frequirem\0\0\4\1\3\0\14-\0\0\0009\0\0\0B\0\1\2\v\0\0\0X\1\1ÄK\0\1\0009\1\1\0\n\1\0\0X\1\4Ä-\1\0\0009\1\2\1\18\3\0\0B\1\2\1K\0\1\0\1¿\23expand_or_collapse\nnodes\23get_node_at_cursorˇ\1\0\0\6\1\14\0\31-\0\0\0009\0\0\0B\0\1\0029\1\1\0009\1\2\1\6\1\3\0X\2\6Ä\6\1\4\0X\2\4Ä\6\1\5\0X\2\2Ä\a\1\6\0X\2\aÄ6\2\a\0009\2\b\2'\4\t\0009\5\n\0&\4\5\4B\2\2\1X\2\nÄ\6\1\v\0X\2\2Ä\a\1\f\0X\2\6Ä6\2\a\0009\2\b\2'\4\r\0009\5\n\0&\4\5\4B\2\2\1K\0\1\0\1¿\"silent !git restore --staged \aA \aM \18absolute_path\21silent !git add \bcmd\bvim\a M\aAM\aMM\a??\tfile\15git_status\23get_node_at_cursorS\0\1\4\1\6\0\v-\1\0\0009\1\0\0019\1\1\0019\1\2\1\18\3\0\0B\1\2\0016\1\3\0009\1\4\0019\1\5\1B\1\1\1K\0\1\0\2¿\ftabprev\bcmd\bvim\btab\topen\tnode]\0\1\4\1\4\0\b5\1\1\0'\2\0\0\18\3\0\0&\2\3\2=\2\2\1-\2\0\0=\2\3\1L\1\2\0\0¿\vbuffer\tdesc\1\0\3\vnowait\2\vsilent\2\fnoremap\2\16nvim-tree: ü\16\1\1\n\6[\0€\0023\1\0\0006\2\1\0009\2\2\0029\2\3\2'\4\4\0'\5\5\0-\6\0\0009\6\6\0069\6\a\0069\6\b\6\18\a\1\0'\t\t\0B\a\2\0A\2\3\0016\2\1\0009\2\2\0029\2\3\2'\4\4\0'\5\n\0-\6\1\0\18\a\1\0'\t\v\0B\a\2\0A\2\3\0016\2\1\0009\2\2\0029\2\3\2'\4\4\0'\5\f\0-\6\2\0\18\a\1\0'\t\r\0B\a\2\0A\2\3\0016\2\1\0009\2\2\0029\2\3\2'\4\4\0'\5\14\0-\6\0\0009\6\6\0069\6\15\0069\6\16\6\18\a\1\0'\t\17\0B\a\2\0A\2\3\0016\2\1\0009\2\2\0029\2\3\2'\4\4\0'\5\18\0-\6\3\0\18\a\1\0'\t\19\0B\a\2\0A\2\3\0016\2\1\0009\2\2\0029\2\3\2'\4\4\0'\5\20\0-\6\4\0\18\a\1\0'\t\21\0B\a\2\0A\2\3\0016\2\1\0009\2\2\0029\2\3\2'\4\4\0'\5\22\0-\6\5\0\18\a\1\0'\t\23\0B\a\2\0A\2\3\0016\2\1\0009\2\2\0029\2\3\2'\4\4\0'\5\24\0-\6\0\0009\6\6\0069\6\a\0069\6\25\6\18\a\1\0'\t\26\0B\a\2\0A\2\3\0016\2\1\0009\2\2\0029\2\3\2'\4\4\0'\5\27\0-\6\0\0009\6\6\0069\6\a\0069\6\28\6\18\a\1\0'\t\29\0B\a\2\0A\2\3\0016\2\1\0009\2\2\0029\2\3\2'\4\4\0'\5\30\0-\6\0\0009\6\6\0069\6\15\0069\6\31\6\18\a\1\0'\t \0B\a\2\0A\2\3\0016\2\1\0009\2\2\0029\2\3\2'\4\4\0'\5!\0-\6\0\0009\6\6\0069\6\a\0069\6\"\6\18\a\1\0'\t#\0B\a\2\0A\2\3\0016\2\1\0009\2\2\0029\2\3\2'\4\4\0'\5$\0-\6\0\0009\6\6\0069\6\15\0069\6%\0069\6&\6\18\a\1\0'\t'\0B\a\2\0A\2\3\0016\2\1\0009\2\2\0029\2\3\2'\4\4\0'\5(\0-\6\0\0009\6\6\0069\6\15\0069\6%\0069\6)\6\18\a\1\0'\t*\0B\a\2\0A\2\3\0016\2\1\0009\2\2\0029\2\3\2'\4\4\0'\5+\0-\6\0\0009\6,\0069\6-\6\18\a\1\0'\t.\0B\a\2\0A\2\3\0016\2\1\0009\2\2\0029\2\3\2'\4\4\0'\5/\0-\6\0\0009\6,\0069\0060\6\18\a\1\0'\t1\0B\a\2\0A\2\3\0016\2\1\0009\2\2\0029\2\3\2'\4\4\0'\0052\0-\6\0\0009\0063\0069\0064\6\18\a\1\0'\t5\0B\a\2\0A\2\3\0016\2\1\0009\2\2\0029\2\3\2'\4\4\0'\0056\0-\6\0\0009\0063\0069\0067\6\18\a\1\0'\t8\0B\a\2\0A\2\3\0016\2\1\0009\2\2\0029\2\3\2'\4\4\0'\0059\0-\6\0\0009\0063\0069\6:\6\18\a\1\0'\t;\0B\a\2\0A\2\3\0016\2\1\0009\2\2\0029\2\3\2'\4\4\0'\5<\0-\6\0\0009\0063\0069\6=\6\18\a\1\0'\t>\0B\a\2\0A\2\3\0016\2\1\0009\2\2\0029\2\3\2'\4\4\0'\5?\0-\6\0\0009\0063\0069\6@\0069\6\6\6\18\a\1\0'\tA\0B\a\2\0A\2\3\0016\2\1\0009\2\2\0029\2\3\2'\4\4\0'\5B\0-\6\0\0009\0063\0069\6C\6\18\a\1\0'\tD\0B\a\2\0A\2\3\0016\2\1\0009\2\2\0029\2\3\2'\4\4\0'\5E\0-\6\0\0009\0063\0069\6@\0069\6F\6\18\a\1\0'\tG\0B\a\2\0A\2\3\0016\2\1\0009\2\2\0029\2\3\2'\4\4\0'\5H\0-\6\0\0009\0063\0069\6@\0069\6I\6\18\a\1\0'\tJ\0B\a\2\0A\2\3\0016\2\1\0009\2\2\0029\2\3\2'\4\4\0'\5K\0-\6\0\0009\0063\0069\6@\0069\6L\6\18\a\1\0'\tM\0B\a\2\0A\2\3\0016\2\1\0009\2\2\0029\2\3\2'\4\4\0'\5N\0-\6\0\0009\6\6\0069\6\15\0069\6O\0069\6P\6\18\a\1\0'\tQ\0B\a\2\0A\2\3\0016\2\1\0009\2\2\0029\2\3\2'\4\4\0'\5R\0-\6\0\0009\6\6\0069\6\15\0069\6O\0069\6S\6\18\a\1\0'\tT\0B\a\2\0A\2\3\0016\2\1\0009\2\2\0029\2\3\2'\4\4\0'\5U\0-\6\0\0009\6,\0069\6V\6\18\a\1\0'\tW\0B\a\2\0A\2\3\0016\2\1\0009\2\2\0029\2\3\2'\4\4\0'\5X\0-\6\0\0009\6,\0069\6Y\6\18\a\1\0'\tZ\0B\a\2\0A\2\3\0012\0\0ÄK\0\1\0\2¿\5¿\a¿\6¿\b¿\t¿\tHelp\16toggle_help\6?\nClose\nclose\6q\rNext Git\tnext\a]c\rPrev Git\tprev\bgit\a[c\23Copy Absolute Path\18absolute_path\agy\23Copy Relative Path\18relative_path\6Y\14Copy Name\rfilename\6y\nPaste\npaste\6p\tCopy\tcopy\6c\bCut\bcut\6x\vRename\vrename\6r\vDelete\vremove\6d\vCreate\vcreate\afs\6a\fRefresh\vreload\6R\20Toggle Dotfiles\25toggle_hidden_filter\ttree\6H\17Last Sibling\tlast\6K\18First Sibling\nfirst\fsibling\6L\17Open Preview\fpreview\n<Tab>\21Parent Directory\vparent\6P\27Open: Horizontal Split\15horizontal\n<C-x>\25Open: Vertical Split\rvertical\n<C-v>\20open_tab_silent\6T\fgit_add\aga\rCollapse\6J\20Close Directory\17parent_close\rnavigate\6j\vexpand\a√ß\23swap_then_open_tab\6t\27Open: No Window Picker\21no_window_picker\topen\tnode\6o\6n\bset\vkeymap\bvim\0Ç\17\1\0\19\0|\0´\0016\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0026\2\0\0'\4\3\0B\2\2\0029\3\4\0029\3\5\0039\5\4\0029\5\6\0059\5\a\0053\6\b\0B\3\3\0013\3\t\0006\4\n\0009\4\v\0049\4\f\4'\6\r\0005\a\14\0=\3\15\aB\4\3\0013\4\16\0006\5\n\0009\5\v\0059\5\f\5'\a\17\0005\b\19\0003\t\18\0=\t\15\bB\5\3\0013\5\20\0003\6\21\0003\a\22\0003\b\23\0003\t\24\0006\n\0\0'\f\25\0B\n\2\0029\v\26\0005\r \0005\14\30\0005\15\27\0005\16\28\0=\16\29\15=\15\31\14=\14!\r5\14%\0006\15\n\0009\15\"\0159\15#\0159\15$\15=\15&\14=\14'\r5\14(\0005\15+\0009\16)\n9\16*\16=\16,\0159\16)\n9\16-\16=\16.\0159\16)\n9\16/\16=\0160\0159\16)\n9\0161\16=\0162\15=\0153\14=\14)\r3\0144\0=\0145\r5\0146\0005\0157\0=\0158\0145\15`\0005\16;\0009\0179\n9\17:\17=\17<\0169\0179\n9\17=\17=\17>\0169\0179\n9\17?\17=\17@\0165\17B\0009\0189\n9\18A\18=\18C\0179\0189\n9\18D\18=\18E\0179\0189\n9\18F\18=\18<\0179\0189\n9\18G\18=\18H\0179\0189\n9\18I\18=\18J\0179\0189\n9\18K\18=\18L\0179\0189\n9\18M\18=\18>\0179\0189\n9\18G\18=\18N\17=\17O\0165\17R\0009\18P\n9\18Q\18=\18S\0179\18P\n9\18T\18=\18U\0179\18P\n9\18V\18=\18W\0179\18P\n9\18X\18=\18Y\0179\18P\n9\18Z\18=\18[\0179\18P\n9\18\\\18=\18]\0179\18P\n9\18^\18=\18_\17=\17P\16=\16a\15=\0153\14=\14b\r5\14c\0=\14d\r5\14e\0005\15f\0=\15g\14=\14h\r5\14i\0004\15\0\0=\15j\14=\14k\r5\14l\0005\15m\0=\15n\0144\15\0\0=\15o\14=\14p\r5\14q\0=\14P\r5\14r\0005\15s\0=\15t\0145\15u\0=\15v\14=\14w\r5\14x\0=\14y\r5\14z\0=\14{\rB\v\2\0012\0\0ÄK\0\1\0\ntrash\1\0\2\20require_confirm\2\bcmd\ntrash\tview\1\0\4\vnumber\1\nwidth\3\30\19relativenumber\1\tside\tleft\factions\14open_file\1\0\2\18resize_window\2\17quit_on_open\1\15change_dir\1\0\3\vglobal\1\venable\2\23restrict_above_cwd\1\1\0\1\25use_system_clipboard\2\1\0\3\venable\2\ftimeout\3Ù\3\vignore\2\ffilters\fexclude\vcustom\1\3\0\0\17node_modules\f\\.cache\1\0\3\rdotfiles\1\14git_clean\1\14no_buffer\1\16system_open\targs\1\0\1\bcmd\5\24update_focused_file\16ignore_list\1\2\0\0\14gitcommit\1\0\2\15update_cwd\2\venable\2\23hijack_directories\1\0\2\venable\2\14auto_open\2\rrenderer\vglyphs\1\0\0\fignored\vIgnore\fdeleted\vRemove\14untracked\14Untracked\frenamed\vRename\runmerged\rUnmerged\vstaged\vStaged\runstaged\1\0\0\rUnstaged\bgit\vfolder\17symlink_open\18FolderSymlink\15empty_open\20EmptyFolderOpen\nempty\16EmptyFolder\topen\15FolderOpen\vFolder\15arrow_open\27TriangleShortArrowDown\17arrow_closed\1\0\0\28TriangleShortArrowRight\rbookmark\rBookMark\fsymlink\16FileSymlink\fdefault\1\0\0\tText\aui\19indent_markers\1\0\1\venable\1\1\0\6\22root_folder_label\16:~:s?$?/..?\17add_trailing\1\16group_empty\1\18highlight_git\2\27highlight_opened_files\tnone\25root_folder_modifier\a:~\14on_attach\0\nicons\nerror\nError\fwarning\fWarning\tinfo\16Information\thint\1\0\0\tHint\16diagnostics\1\0\2\venable\1\17show_on_dirs\1\vnotify\14threshold\1\0\0\tINFO\vlevels\blog\btab\1\0\a\20respect_buf_cwd\1\18disable_netrw\1\15update_cwd\2\17hijack_netrw\2\18hijack_cursor\1'hijack_unnamed_buffer_when_opening\2\16open_on_tab\1\tsync\1\0\0\vignore\1\2\0\0\14gitcommit\1\0\2\nclose\2\topen\2\nsetup\16utils.icons\0\0\0\0\0\1\0\1\vnested\2\0\14WinClosed\0\rcallback\1\0\0\rVimEnter\24nvim_create_autocmd\bapi\bvim\0\0\16FileCreated\nEvent\14subscribe\vevents\18nvim-tree.api\18nvim-tree.lib\14nvim-tree\frequire\0" },
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/nvim-tree.lua",
    url = "https://github.com/nvim-tree/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    config = { "\27LJ\2\nÇ\n\0\0\a\0001\00076\0\0\0'\2\1\0B\0\2\0029\1\2\0005\3\4\0005\4\3\0=\4\5\0035\4\6\0=\4\a\0035\4\t\0005\5\b\0=\5\n\0045\5\v\0=\5\f\4=\4\r\0035\4\14\0005\5\15\0=\5\16\4=\4\17\0035\4\18\0=\4\19\0035\4\20\0004\5\0\0=\5\21\4=\4\22\0035\4\23\0=\4\24\0035\4\25\0=\4\26\0035\4\29\0005\5\27\0005\6\28\0=\6\16\5=\5\30\0045\5\31\0005\6 \0=\6!\0055\6\"\0=\6#\0055\6$\0=\6%\0055\6&\0=\6'\5=\5(\0045\5)\0004\6\0\0=\6*\5=\5+\4=\4,\0035\4-\0=\4.\0035\4/\0=\0040\3B\1\2\1K\0\1\0\fendwise\1\0\1\venable\2\fmatchup\1\0\1\venable\1\16textobjects\tswap\14swap_next\1\0\1\venable\1\tmove\22goto_previous_end\1\0\2\a[M\17@class.outer\a[]\20@function.outer\18goto_next_end\1\0\2\a]M\17@class.outer\a][\20@function.outer\24goto_previous_start\1\0\2\a[m\17@class.outer\a[[\20@function.outer\20goto_next_start\1\0\2\a]m\17@class.outer\a]]\20@function.outer\1\0\2\14set_jumps\2\venable\2\vselect\1\0\0\1\0\4\aic\17@class.inner\aaf\20@function.outer\aac\17@class.outer\aif\20@function.inner\1\0\3\14lookahead\2#include_surrounding_whitespace\1\venable\2\26context_commentstring\1\0\2\19enable_autocmd\1\venable\2\frainbow\1\0\2\venable\2\18extended_mode\1\vindent\fdisable\1\0\1\venable\2\14highlight\1\0\3\21use_languagetree\2\venable\2&additional_vim_regex_highlighting\1\26incremental_selection\fkeymaps\1\0\2\19init_selection\14<C-space>\21node_incremental\14<C-space>\1\0\1\venable\2\rrefactor\28highlight_current_scope\1\0\1\venable\1\26highlight_definitions\1\0\0\1\0\1\venable\2\fautotag\1\0\1\venable\2\21ensure_installed\1\0\1\17auto_install\2\1\23\0\0\bvim\vvimdoc\rmarkdown\20markdown_inline\tbash\nregex\15javascript\15typescript\vprisma\truby\btsx\vpython\tdart\tjson\thtml\blua\bcss\tscss\ttoml\tfish\njsdoc\tyaml\nsetup\28nvim-treesitter.configs\frequire\0" },
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
  ["nvim-ts-rainbow"] = {
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/nvim-ts-rainbow",
    url = "https://github.com/p00f/nvim-ts-rainbow"
  },
  ["nvim-ufo"] = {
    config = { "\27LJ\2\n˘\2\0\5\23\0\v\0I4\5\0\0'\6\0\0\18\b\6\0009\6\1\6!\t\1\2B\6\3\0026\a\2\0009\a\3\a9\a\4\a\18\t\6\0B\a\2\2!\b\a\3)\t\0\0006\n\5\0\18\f\0\0B\n\2\4X\r/Ä:\15\1\0146\16\2\0009\16\3\0169\16\4\16\18\18\15\0B\16\2\2 \17\16\t\1\17\b\0X\17\6Ä6\17\6\0009\17\a\17\18\19\5\0\18\20\14\0B\17\3\1X\17\31Ä\18\17\4\0\18\19\15\0!\20\t\bB\17\3\2\18\15\17\0:\17\2\0146\18\6\0009\18\a\18\18\20\5\0004\21\3\0>\15\1\21>\17\2\21B\18\3\0016\18\2\0009\18\3\0189\18\4\18\18\20\15\0B\18\2\2\18\16\18\0 \18\16\t\1\18\b\0X\18\fÄ\18\18\6\0'\19\b\0\18\21\19\0009\19\t\19!\22\t\b!\22\16\22B\19\3\2&\6\19\18X\n\3Ä \t\16\tE\r\3\3R\rœ\1276\n\6\0009\n\a\n\18\f\5\0005\r\n\0>\6\1\rB\n\3\1L\5\2\0\1\3\0\0\0\fMoreMsg\brep\6 \vinsert\ntable\vipairs\20strdisplaywidth\afn\bvim\vformat\r ÔïÅ %d ∫\1\0\3\a\0\t\0\0266\3\0\0\18\5\1\0B\3\2\2\a\3\1\0X\3\14Ä\18\5\1\0009\3\2\1'\6\3\0B\3\3\2\15\0\3\0X\4\bÄ6\3\4\0'\5\5\0B\3\2\0029\3\6\3\18\5\0\0\18\6\2\0D\3\3\0X\3\6Ä6\3\4\0'\5\a\0B\3\2\0029\3\b\3\18\5\1\0D\3\2\0K\0\1\0\vreject\fpromise\rgetFolds\bufo\frequire\25UfoFallbackException\nmatch\vstring\ttype*\0\1\6\2\1\0\5-\1\0\0-\3\1\0\18\4\0\0'\5\0\0D\1\4\0\0\0\0¿\15treesitter&\0\1\6\2\1\0\5-\1\0\0-\3\1\0\18\4\0\0'\5\0\0D\1\4\0\0\0\0¿\vindentj\1\1\5\1\a\0\0166\1\0\0'\3\1\0B\1\2\0029\1\2\1\18\3\0\0'\4\3\0B\1\3\2\18\3\1\0009\1\4\0013\4\5\0B\1\3\2\18\3\1\0009\1\4\0013\4\6\0002\0\0ÄD\1\3\0\3¿\0\0\ncatch\blsp\rgetFolds\bufo\frequire@\1\3\5\0\5\0\n3\3\0\0\6\1\1\0X\4\2Ä\a\2\2\0X\4\2Ä'\4\3\0X\5\1Ä3\4\4\0002\0\0ÄL\4\2\0\0\vindent\vnofile\5\0Õ\1\1\0\6\0\r\0\0236\0\0\0'\2\1\0B\0\2\0023\1\2\0006\2\3\0009\2\4\2)\3c\0=\3\5\0026\2\3\0009\2\4\2)\3c\0=\3\6\0026\2\3\0009\2\4\2+\3\2\0=\3\a\0029\2\b\0005\4\t\0=\1\n\0043\5\v\0=\5\f\4B\2\2\1K\0\1\0\22provider_selector\0\27fold_virt_text_handler\1\0\0\nsetup\15foldenable\19foldlevelstart\14foldlevel\6o\bvim\0\bufo\frequire\0" },
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
    config = { "\27LJ\2\n\15\0\0\1\0\0\0\2+\0\2\0L\0\2\0\15\0\1\2\0\0\0\2+\1\2\0L\1\2\0\4\1\0\5\0\14\0\0176\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\0025\3\6\0=\3\a\0025\3\t\0003\4\b\0=\4\n\0033\4\v\0=\4\f\3=\3\r\2B\0\2\1K\0\1\0\fnull-ls\22runtime_condition\0\14condition\1\0\1\ftimeout\3à'\0\14filetypes\1\r\0\0\bcss\fgraphql\thtml\15javascript\20javascriptreact\tjson\tless\rmarkdown\tscss\15typescript\20typescriptreact\tyaml\16cli_options\1\0\17\16quote_props\14as-needed\15prose_wrap\rpreserve\16print_width\3P\21jsx_single_quote\1 html_whitespace_sensitivity\bcss\16end_of_line\alf!embedded_language_formatting\tauto\22bracket_same_line\1\20bracket_spacing\2\17arrow_parens\valways vue_indent_script_and_style\1\ruse_tabs\1\19trailing_comma\bes5\14tab_width\3\2\17single_quote\2\30single_attribute_per_line\1\tsemi\2\1\0\1\bbin\14prettierd\nsetup\rprettier\frequire\0" },
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
    config = { "\27LJ\2\n\15\0\1\2\0\0\0\2)\1\1\0L\1\2\0æ\2\1\0\5\0\21\0$3\0\0\0006\1\1\0'\3\2\0B\1\2\0029\1\3\0015\3\4\0005\4\5\0=\0\6\4=\0\a\4=\0\b\4=\0\t\4=\0\n\4=\0\v\4=\0\f\4=\0\r\4=\0\14\4=\0\15\4=\0\16\4=\0\17\4=\4\18\0035\4\19\0=\0\6\4=\0\a\4=\0\b\4=\0\t\4=\0\n\4=\0\v\4=\0\f\4=\0\r\4=\0\14\4=\0\15\4=\0\16\4=\0\17\4=\4\20\3B\1\2\1K\0\1\0\24backward_characters\1\0\0\23forward_characters\6`\6'\6\"\6;\6.\6,\6{\6}\6[\6]\6(\6)\1\0\0\1\0\4\25evil_backward_tabkey\5\vtabkey\n<Tab>\20backward_tabkey\f<S-Tab>\16evil_tabkey\5\nsetup\ftabhula\frequire\0\0" },
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
  ["telescope-live-grep-args.nvim"] = {
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/telescope-live-grep-args.nvim",
    url = "https://github.com/nvim-telescope/telescope-live-grep-args.nvim"
  },
  ["telescope-media-files.nvim"] = {
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/telescope-media-files.nvim",
    url = "https://github.com/nvim-telescope/telescope-media-files.nvim"
  },
  ["telescope.nvim"] = {
    config = { "\27LJ\2\n∆\t\0\0\t\0003\0M6\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0025\2\5\0009\3\3\0019\3\4\3=\3\6\0029\3\3\0019\3\a\3=\3\b\0029\3\3\0019\3\t\3=\3\n\0029\3\3\0019\3\v\3=\3\f\0029\3\3\0019\3\r\3=\3\14\0029\3\3\0019\3\15\3=\3\16\0029\3\17\0005\5\27\0005\6\19\0005\a\18\0=\a\20\0065\a\22\0005\b\21\0=\b\23\a5\b\24\0=\b\25\a=\a\26\6=\6\28\0055\6\30\0005\a\29\0=\a\31\6=\6 \0055\6\"\0005\a!\0=\a#\6=\6$\0056\6\0\0'\b%\0B\6\2\0029\6&\6=\6'\5=\2(\0056\6\0\0'\b)\0B\6\2\0029\6*\0069\6+\6=\6,\0056\6\0\0'\b)\0B\6\2\0029\6-\0069\6+\6=\6.\0056\6\0\0'\b)\0B\6\2\0029\6/\0069\6+\6=\0060\5B\3\2\0019\0031\0'\5\31\0B\3\2\0019\0031\0'\0052\0B\3\2\1K\0\1\0\16media_files\19load_extension\21qflist_previewer\22vim_buffer_qflist\19grep_previewer\23vim_buffer_vimgrep\19file_previewer\bnew\19vim_buffer_cat\25telescope.previewers\14git_icons\16file_sorter\19get_fzy_sorter\22telescope.sorters\18layout_config\15horizontal\1\0\1\20prompt_position\btop\1\0\1\19preview_cutoff\3x\15extensions\bfzf\1\0\0\1\0\4\28override_generic_sorter\2\25override_file_sorter\2\14case_mode\15smart_case\nfuzzy\2\rdefaults\1\0\3\19color_devicons\2\18prompt_prefix\n ÔÄÇ \21sorting_strategy\14ascending\rmappings\6n\1\0\a\n<C-c>\nclose\6l\28move_selection_previous\6k\24move_selection_next\n<C-l>\28move_selection_previous\6t\15select_tab\6v\20select_vertical\n<C-k>\24move_selection_next\6i\1\0\0\1\0\5\n<C-c>\nclose\n<C-l>\28move_selection_previous\t<CR>\19select_default\n<C-h>\14which_key\n<C-k>\24move_selection_next\25file_ignore_patterns\1\0\0\1\3\0\0\17node_modules\n.venv\nsetup\14untracked\14Untracked\runmerged\rUnmerged\frenamed\vRename\fdeleted\vRemove\fchanged\bMod\nadded\1\0\1\vcopied\6>\bAdd\bgit\16utils.icons\14telescope\frequire\0" },
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
    config = { "\27LJ\2\në\1\0\1\2\0\a\2\0189\1\0\0\a\1\1\0X\1\6Ä6\1\2\0009\1\3\0019\1\4\1\24\1\0\1L\1\2\0X\1\bÄ9\1\0\0\a\1\5\0X\1\5Ä6\1\2\0009\1\3\0019\1\6\1\24\1\1\1L\1\2\0K\0\1\0\fcolumns\rvertical\nlines\6o\bvim\15horizontal\14directionÁÃô≥\6≥ÊÃ˛\3\1ÄÄ¿˛\3Ø\1\0\1\a\0\n\0\0209\1\0\0\a\1\1\0X\1\16Ä6\1\2\0006\3\3\0'\4\4\0B\1\3\0039\3\5\2\15\0\1\0X\4\tÄ9\4\6\3B\4\1\2\15\0\4\0X\5\5Ä9\4\a\3B\4\1\0019\4\b\0035\6\t\0B\4\2\1K\0\1\0\1\0\1\nfocus\1\vtoggle\nclose\15is_visible\ttree\18nvim-tree.api\frequire\npcall\15horizontal\14direction\v\0\1\1\0\0\0\1K\0\1\0\20\0\1\2\0\1\0\0029\1\0\0L\1\2\0\tname¶\4\1\0\a\0\28\1'6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0003\3\3\0=\3\5\0024\3\0\0=\3\6\0023\3\a\0=\3\b\0023\3\t\0=\3\n\0026\3\v\0009\3\f\0039\3\r\3=\3\r\0025\3\14\0006\4\15\0009\4\16\0046\6\v\0009\6\f\0069\6\17\6\24\6\0\6B\4\2\2=\4\18\0035\4\19\0=\4\20\3=\3\21\0025\3\22\0004\4\0\0=\4\23\3=\3\20\0025\3\24\0003\4\25\0=\4\26\3=\3\27\2B\0\2\1K\0\1\0\vwinbar\19name_formatter\0\1\0\1\fenabled\1\vNormal\1\0\0\15float_opts\15highlights\1\0\2\15background\vNormal\vborder\vNormal\nwidth\fcolumns\nfloor\tmath\1\0\3\rwinblend\3\0\vheight\3\15\vborder\vcurved\nshell\6o\bvim\ron_close\0\fon_open\0\20shade_filetypes\tsize\1\0\b\14direction\15horizontal\19shading_factor\0060\20start_in_insert\2\20insert_mappings\1\17persist_size\1\18close_on_exit\2\17hide_numbers\2\20shade_terminals\1\0\nsetup\15toggleterm\frequireõ≥ÊÃ\25Ãôìˇ\3\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/opt/toggleterm.nvim",
    url = "https://github.com/akinsho/toggleterm.nvim"
  },
  ["tokyonight.nvim"] = {
    config = { "\27LJ\2\nh\0\2\n\0\4\0\r6\2\0\0'\4\1\0B\2\2\0029\2\2\2B\2\1\0026\3\3\0\18\5\2\0B\3\2\4H\6\1Ä<\a\6\0F\6\3\3R\6˝\127K\0\1\0\npairs\23get_all_highlights\16colorscheme\frequireß\2\1\0\5\0\v\0\0156\0\0\0'\2\1\0B\0\2\0029\1\2\0005\3\3\0005\4\4\0=\4\5\0033\4\6\0=\4\a\3B\1\2\0016\1\b\0009\1\t\1'\3\n\0B\1\2\1K\0\1\0\27colorscheme tokyonight\bcmd\bvim\18on_highlights\0\vstyles\1\0\6\14variables\tNONE\rkeywords\vitalic\rsidebars\16transparent\vfloats\16transparent\14functions\tbold\rcomments\vitalic\1\0\3\nstyle\nnight\20terminal_colors\1\16transparent\2\nsetup\15tokyonight\frequire\0" },
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
    config = { "\27LJ\2\nÍ\3\0\0\4\0\14\0\0236\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0024\3\0\0=\3\6\0025\3\a\0=\3\b\0024\3\0\0=\3\t\0024\3\0\0=\3\n\0024\3\0\0=\3\v\0024\3\0\0=\3\f\0024\3\0\0=\3\r\2B\0\2\1K\0\1\0%providers_regex_syntax_allowlist$providers_regex_syntax_denylist\20modes_allowlist\19modes_denylist\24filetypes_allowlist\23filetypes_denylist\1\16\0\0\fdirvish\rfugitive\fdirvish\rfugitive\nalpha\rNvimTree\tlazy\17neogitstatus\fTrouble\blir\fOutline\18spectre_panel\15toggleterm\19DressingSelect\20TelescopePrompt\23filetype_overrides\14providers\1\0\2\ndelay\3¨\2\17under_cursor\2\1\4\0\0\blsp\15treesitter\nregex\14configure\15illuminate\frequire\0" },
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
  ["vim-tradewinds"] = {
    loaded = true,
    path = "/home/matheus/.local/share/nvim/site/pack/packer/start/vim-tradewinds",
    url = "https://github.com/andymass/vim-tradewinds"
  },
  ["vim-visual-multi"] = {
    config = { "\27LJ\2\nÄ\3\0\0\4\0\f\0\0256\0\0\0009\0\1\0)\1\0\0=\1\2\0006\0\0\0009\0\1\0)\1\0\0=\1\3\0006\0\0\0009\0\4\0009\0\5\0'\2\6\0005\3\a\0B\0\3\0016\0\0\0009\0\4\0009\0\5\0'\2\b\0005\3\t\0B\0\3\0016\0\0\0009\0\1\0005\1\v\0=\1\n\0K\0\1\0\1\0\4\6j\6h\6k\6j\6l\6k\a√ß\6l\22VM_custom_motions\1\0\a\15Find Under\n<C-n>\tRedo\n<C-r>\23Find Subword Under\n<C-n>\tUndo\6u\15Select All\14<leader>A\18Add Cursor Up\f<C-M-l>\20Add Cursor Down\f<C-M-k>\fVM_maps\1\0\3\vvisual\6 \fdefault\6 \vbuffer\6z\14VM_leader\17nvim_set_var\bapi\21VM_show_warnings\24VM_default_mappings\6g\bvim\0" },
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

-- Config for: nvim-navic
time([[Config for nvim-navic]], true)
try_loadstring("\27LJ\2\nı\a\0\0\b\0.\0ô\0016\0\0\0'\2\1\0B\0\2\0029\1\2\0006\2\0\0'\4\3\0B\2\2\0029\2\4\0025\4)\0005\5\a\0009\6\5\1'\a\6\0&\6\a\6=\6\5\0059\6\b\1=\6\b\0059\6\t\1'\a\6\0&\6\a\6=\6\t\0059\6\n\1'\a\6\0&\6\a\6=\6\n\0059\6\v\1'\a\6\0&\6\a\6=\6\v\0059\6\f\1'\a\6\0&\6\a\6=\6\f\0059\6\r\1'\a\6\0&\6\a\6=\6\r\0059\6\14\1'\a\6\0&\6\a\6=\6\14\0059\6\15\1'\a\6\0&\6\a\6=\6\15\0059\6\16\1'\a\6\0&\6\a\6=\6\16\0059\6\17\1'\a\6\0&\6\a\6=\6\17\0059\6\18\1'\a\6\0&\6\a\6=\6\18\0059\6\19\1'\a\6\0&\6\a\6=\6\19\0059\6\20\1'\a\6\0&\6\a\6=\6\20\0059\6\21\1'\a\6\0&\6\a\6=\6\21\0059\6\22\1'\a\6\0&\6\a\6=\6\22\0059\6\23\1'\a\6\0&\6\a\6=\6\23\0059\6\24\1'\a\6\0&\6\a\6=\6\24\0059\6\25\1'\a\6\0&\6\a\6=\6\25\0059\6\26\1'\a\6\0&\6\a\6=\6\26\0059\6\27\1'\a\6\0&\6\a\6=\6\27\0059\6\28\1'\a\6\0&\6\a\6=\6\28\0059\6\29\1'\a\6\0&\6\a\6=\6\29\0059\6\30\1'\a\6\0&\6\a\6=\6\30\0059\6\31\1'\a\6\0&\6\a\6=\6\31\0059\6 \1'\a\6\0&\6\a\6=\6 \0059\6!\1'\a\6\0&\6\a\6=\6!\0059\6\"\1'\a\6\0&\6\a\6=\6\"\0059\6#\1'\a\6\0&\6\a\6=\6#\0059\6$\1'\a\6\0&\6\a\6=\6$\0059\6%\1'\a\6\0&\6\a\6=\6%\0059\6&\1'\a\6\0&\6\a\6=\6&\0059\6'\1'\a\6\0&\6\a\6=\6'\0059\6(\1'\a\6\0&\6\a\6=\6(\5=\5*\4'\5\6\0009\6+\0009\6,\6'\a\6\0&\5\a\5=\5-\4B\2\2\1K\0\1\0\14separator\17ChevronRight\aui\nicons\1\0\3\14highlight\2\16depth_limit\3\4\26depth_limit_indicator\a..\rVariable\nValue\tUnit\18TypeParameter\tText\vStruct\vString\fSnippet\14Reference\rProperty\fPackage\rOperator\vObject\vNumber\tNull\14Namespace\vModule\vMethod\fKeyword\bKey\14Interface\rFunction\vFolder\tFile\nField\nEvent\15EnumMember\tEnum\16Constructor\rConstant\nColor\nClass\fBoolean\1\0\0\6 \nArray\nsetup\15nvim-navic\flspkind\16utils.icons\frequire\0", "config", "nvim-navic")
time([[Config for nvim-navic]], false)
-- Config for: mason.nvim
time([[Config for mason.nvim]], true)
try_loadstring("\27LJ\2\nò\1\0\1\t\1\a\0\19-\1\0\0009\1\0\1B\1\1\0026\2\1\0006\4\2\0'\5\3\0\18\6\0\0&\5\6\5B\2\3\3\15\0\2\0X\4\aÄ6\4\4\0009\4\5\4'\6\6\0\18\a\1\0\18\b\3\0B\4\4\2\18\1\4\0L\1\2\0\4¿\nforce\15tbl_extend\bvim\17lsp.servers.\frequire\npcall\23get_commom_configs5\0\1\5\2\1\0\t-\1\0\0\18\3\0\0B\1\2\2-\2\1\0008\2\0\0029\2\0\2\18\4\1\0B\2\2\1K\0\1\0\6¿\1¿\nsetupJ\0\0\4\3\2\0\f-\0\0\0009\0\0\0B\0\1\1-\0\1\0'\2\1\0B\0\2\2-\1\2\0009\1\1\0019\1\0\1\18\3\0\0B\1\2\1K\0\1\0\2¿\6¿\1¿\vlua_ls\nsetupz\0\0\6\1\6\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0-\3\0\0'\5\4\0B\3\2\2=\3\5\2B\0\2\1K\0\1\0\6¿\vserver\rtsserver\1\0\2\ndebug\1\21disable_commands\1\nsetup\15typescript\frequire∏\4\1\0\v\0\30\00056\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0026\2\0\0'\4\3\0B\2\2\0026\3\0\0'\5\4\0B\3\2\0026\4\0\0'\6\5\0B\4\2\0026\5\0\0'\a\6\0B\5\2\0029\6\a\0005\b\v\0005\t\b\0005\n\t\0=\n\n\t=\t\f\bB\6\2\0019\6\a\0055\b\14\0005\t\r\0=\t\15\bB\6\2\0019\6\a\0035\b\17\0009\t\16\4=\t\15\bB\6\2\0013\6\18\0009\a\19\0035\t\22\0003\n\20\0>\n\1\t3\n\21\0=\n\23\t3\n\24\0=\n\25\tB\a\2\0016\a\0\0'\t\26\0B\a\2\0029\a\27\a'\b\29\0=\b\28\a2\0\0ÄK\0\1\0\vsingle\vborder\20default_options\25lspconfig.ui.windows\rtsserver\0\vlua_ls\1\0\0\0\0\19setup_handlers\0\1\0\1\27automatic_installation\2\fservers\21ensure_installed\1\0\1\20automatic_setup\2\1\3\0\0\truff\ryamllint\aui\1\0\0\nicons\1\0\3\24package_uninstalled\b‚úó\22package_installed\b‚úì\20package_pending\b‚ü≥\1\0\1\vborder\frounded\nsetup\18mason-null-ls\blsp\20mason-lspconfig\vneodev\14lspconfig\nmason\frequire\0", "config", "mason.nvim")
time([[Config for mason.nvim]], false)
-- Config for: tokyonight.nvim
time([[Config for tokyonight.nvim]], true)
try_loadstring("\27LJ\2\nh\0\2\n\0\4\0\r6\2\0\0'\4\1\0B\2\2\0029\2\2\2B\2\1\0026\3\3\0\18\5\2\0B\3\2\4H\6\1Ä<\a\6\0F\6\3\3R\6˝\127K\0\1\0\npairs\23get_all_highlights\16colorscheme\frequireß\2\1\0\5\0\v\0\0156\0\0\0'\2\1\0B\0\2\0029\1\2\0005\3\3\0005\4\4\0=\4\5\0033\4\6\0=\4\a\3B\1\2\0016\1\b\0009\1\t\1'\3\n\0B\1\2\1K\0\1\0\27colorscheme tokyonight\bcmd\bvim\18on_highlights\0\vstyles\1\0\6\14variables\tNONE\rkeywords\vitalic\rsidebars\16transparent\vfloats\16transparent\14functions\tbold\rcomments\vitalic\1\0\3\nstyle\nnight\20terminal_colors\1\16transparent\2\nsetup\15tokyonight\frequire\0", "config", "tokyonight.nvim")
time([[Config for tokyonight.nvim]], false)
-- Config for: ChatGPT.nvim
time([[Config for ChatGPT.nvim]], true)
try_loadstring("\27LJ\2\nÉ\r\0\0\a\0-\0;6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0005\4\5\0=\4\6\3=\3\a\0025\3\b\0005\4\f\0005\5\t\0005\6\n\0=\6\v\5=\5\r\0045\5\14\0=\5\15\4=\4\16\0035\4\18\0005\5\17\0=\5\19\4=\4\6\3=\3\20\0025\3\21\0005\4\22\0=\4\23\3=\3\24\0025\3\25\0005\4\26\0005\5\27\0=\5\v\4=\4\r\0035\4\28\0=\4\15\3=\3\29\0025\3\30\0005\4\31\0005\5 \0=\5\v\4=\4\r\0035\4!\0=\4\15\3=\3\"\0025\3%\0005\4#\0005\5$\0=\5\v\4=\4\r\0035\4&\0=\4\15\3=\3'\0025\3(\0=\3)\0025\3*\0=\3+\0024\3\0\0=\3,\2B\0\2\1K\0\1\0\18actions_paths\23openai_edit_params\1\0\4\16temperature\3\0\ntop_p\3\1\6n\3\1\nmodel\26code-davinci-edit-001\18openai_params\1\0\a\16temperature\3\0\21presence_penalty\3\0\15max_tokens\3¨\2\6n\3\1\22frequency_penalty\3\0\ntop_p\3\1\nmodel\18gpt-3.5-turbo\20settings_window\1\0\1\17winhighlight*Normal:Normal,FloatBorder:FloatBorder\1\0\0\1\0\1\btop\15 Settings \1\0\1\nstyle\frounded\16popup_input\1\0\1\17winhighlight*Normal:Normal,FloatBorder:FloatBorder\1\0\2\btop\r Prompt \14top_align\vcenter\1\0\2\nstyle\frounded\14highlight\16FloatBorder\1\0\2\vsubmit\v<c-CR>\vprompt\n ÔÜí \17popup_window\1\0\1\17winhighlight*Normal:Normal,FloatBorder:FloatBorder\1\0\1\btop\14 ChatGPT \1\0\2\nstyle\frounded\14highlight\16FloatBorder\1\0\1\rfiletype\fchatgpt\17popup_layout\tsize\1\0\2\nwidth\b80%\vheight\b80%\1\0\2\rposition\b50%\rrelative\veditor\tchat\nclose\1\0\n\19rename_session\6r\19delete_session\6d\20toggle_settings\n<C-o>\14yank_last\n<C-y>\19yank_last_code\n<C-k>\18cycle_windows\n<Tab>\16new_session\n<C-n>\19select_session\f<Space>\14scroll_up\n<C-u>\16scroll_down\n<C-d>\1\2\0\0\n<C-c>\20sessions_window\16win_options\1\0\1\17winhighlight*Normal:Normal,FloatBorder:FloatBorder\vborder\1\0\0\ttext\1\0\1\btop\15 Sessions \1\0\1\nstyle\frounded\1\0\4\18question_sign\bÔÄá\17loading_text\29Loading, please wait ...\16answer_sign\bÔÆß\20max_line_length\3x\27edit_with_instructions\fkeymaps\1\0\5\20toggle_settings\n<C-o>\24use_output_as_input\n<C-i>\16toggle_diff\n<C-d>\18cycle_windows\n<Tab>\vaccept\n<C-y>\1\0\1\tdiff\1\1\0\2\18yank_register\6+ predefined_chat_gpt_promptsQhttps://raw.githubusercontent.com/f/awesome-chatgpt-prompts/main/prompts.csv\nsetup\fchatgpt\frequire\0", "config", "ChatGPT.nvim")
time([[Config for ChatGPT.nvim]], false)
-- Config for: nvim-tree.lua
time([[Config for nvim-tree.lua]], true)
try_loadstring("\27LJ\2\n7\0\1\5\0\4\0\a6\1\0\0009\1\1\1'\3\2\0009\4\3\0&\3\4\3B\1\2\1K\0\1\0\nfname\nedit \bcmd\bvimµ\3\0\1\t\1\19\1J5\1\0\0006\2\1\0009\2\2\0029\2\3\0029\4\4\0B\2\2\2\b\2\0\0X\2\2Ä+\2\1\0X\3\1Ä+\2\2\0009\3\4\0\a\3\5\0X\3\aÄ6\3\1\0009\3\6\0039\4\a\0008\3\4\0039\3\b\3\6\3\5\0X\3\2Ä+\3\1\0X\4\1Ä+\3\2\0006\4\1\0009\4\6\0049\5\a\0008\4\5\0049\4\t\4\14\0\2\0X\5\3Ä\14\0\3\0X\5\1ÄK\0\1\0006\5\1\0009\5\n\5\18\a\1\0\18\b\4\0B\5\3\2\15\0\5\0X\6\1ÄK\0\1\0006\5\1\0009\5\2\0059\5\v\0059\a\4\0B\5\2\2\b\5\0\0X\5\2Ä+\5\1\0X\6\1Ä+\5\2\0\15\0\5\0X\6\14Ä6\6\1\0009\6\f\0069\6\r\6B\6\1\0016\6\1\0009\6\f\0069\6\14\0069\b\a\0B\6\2\0016\6\1\0009\6\f\0069\6\15\0069\b\4\0B\6\2\1-\6\0\0009\6\16\0069\6\17\0065\b\18\0B\6\2\1K\0\1\0\2¿\1\0\2\nfocus\1\14find_file\2\vtoggle\ttree\acd\abw\tenew\bcmd\16isdirectory\17tbl_contains\aft\fbuftype\bbuf\abo\5\tfile\17filereadable\afn\bvim\1\2\0\0\14gitcommit\2%\0\1\2\1\0\0\a-\1\0\0\5\0\1\0X\1\2Ä+\1\1\0X\2\1Ä+\1\2\0L\1\2\0\0¿ë\1\0\0\4\1\6\1\0206\0\0\0009\0\1\0009\0\2\0B\0\1\2\21\0\0\0\t\0\0\0X\0\1ÄX\0\vÄ6\0\0\0009\0\3\0'\2\4\0B\0\2\0016\0\0\0009\0\1\0009\0\5\0-\2\0\0:\2\1\2+\3\2\0B\0\3\1K\0\1\0\4¿\19nvim_win_close\17NvimTreeOpen\bcmd\19nvim_list_wins\bapi\bvim\2Õ\3\1\1\v\1\18\1H6\1\0\0009\1\1\0019\1\2\1\18\3\0\0B\1\2\0026\2\0\0009\2\1\0029\2\3\2\18\4\0\0B\2\2\0026\3\0\0009\3\4\0039\3\5\3\18\5\2\0B\3\2\2:\3\1\0036\4\0\0009\4\6\0043\6\a\0006\a\0\0009\a\1\a9\a\b\a\18\t\1\0B\a\2\0A\4\1\0026\5\0\0009\5\t\0056\a\0\0009\a\1\a9\a\3\a\18\b\4\0B\5\3\0029\6\n\3\18\b\6\0009\6\v\6'\t\f\0B\6\3\2\15\0\6\0X\a\vÄ6\6\0\0009\6\r\6\18\b\5\0B\6\2\2\14\0\6\0X\6\25Ä-\6\0\0009\6\14\0069\6\15\6B\6\1\1X\6\20Ä\21\6\5\0\t\6\0\0X\6\17Ä6\6\0\0009\6\4\0069\6\5\6:\b\1\5B\6\2\2:\6\1\0069\a\n\6\18\t\a\0009\a\v\a'\n\f\0B\a\3\2\15\0\a\0X\b\4Ä6\a\0\0009\a\16\a3\t\17\0B\a\2\0012\0\0ÄK\0\1\0\2¿\0\rschedule\nclose\ttree\16tbl_isempty\20.*NvimTree_%d*$\nmatch\tname\ftbl_map\27nvim_tabpage_list_wins\0\15tbl_filter\15getbufinfo\afn\21nvim_win_get_buf\25nvim_win_get_tabpage\bapi\bvim\2y\0\0\a\1\a\0\0156\0\0\0006\2\1\0009\2\2\0029\2\3\2'\4\4\0B\2\2\0A\0\0\0026\1\1\0009\1\5\0016\3\6\0-\5\0\0\18\6\0\0B\3\3\0A\1\0\1K\0\1\0\4¿\npcall\18schedule_wrap\r<amatch>\vexpand\afn\bvim\rtonumberÅ\1\0\0\4\2\a\0\17-\0\0\0009\0\0\0B\0\1\2\v\0\0\0X\1\1ÄK\0\1\0006\1\1\0009\1\2\1'\3\3\0B\1\2\1-\1\1\0009\1\4\0019\1\5\0019\1\6\1\18\3\0\0B\1\2\1K\0\1\0\1¿\2¿\btab\topen\tnode\rwincmd l\bcmd\bvim\23get_node_at_cursorX\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\afn2nvim-tree.actions.tree-modifiers.collapse-all\frequirem\0\0\4\1\3\0\14-\0\0\0009\0\0\0B\0\1\2\v\0\0\0X\1\1ÄK\0\1\0009\1\1\0\n\1\0\0X\1\4Ä-\1\0\0009\1\2\1\18\3\0\0B\1\2\1K\0\1\0\1¿\23expand_or_collapse\nnodes\23get_node_at_cursorˇ\1\0\0\6\1\14\0\31-\0\0\0009\0\0\0B\0\1\0029\1\1\0009\1\2\1\6\1\3\0X\2\6Ä\6\1\4\0X\2\4Ä\6\1\5\0X\2\2Ä\a\1\6\0X\2\aÄ6\2\a\0009\2\b\2'\4\t\0009\5\n\0&\4\5\4B\2\2\1X\2\nÄ\6\1\v\0X\2\2Ä\a\1\f\0X\2\6Ä6\2\a\0009\2\b\2'\4\r\0009\5\n\0&\4\5\4B\2\2\1K\0\1\0\1¿\"silent !git restore --staged \aA \aM \18absolute_path\21silent !git add \bcmd\bvim\a M\aAM\aMM\a??\tfile\15git_status\23get_node_at_cursorS\0\1\4\1\6\0\v-\1\0\0009\1\0\0019\1\1\0019\1\2\1\18\3\0\0B\1\2\0016\1\3\0009\1\4\0019\1\5\1B\1\1\1K\0\1\0\2¿\ftabprev\bcmd\bvim\btab\topen\tnode]\0\1\4\1\4\0\b5\1\1\0'\2\0\0\18\3\0\0&\2\3\2=\2\2\1-\2\0\0=\2\3\1L\1\2\0\0¿\vbuffer\tdesc\1\0\3\vnowait\2\vsilent\2\fnoremap\2\16nvim-tree: ü\16\1\1\n\6[\0€\0023\1\0\0006\2\1\0009\2\2\0029\2\3\2'\4\4\0'\5\5\0-\6\0\0009\6\6\0069\6\a\0069\6\b\6\18\a\1\0'\t\t\0B\a\2\0A\2\3\0016\2\1\0009\2\2\0029\2\3\2'\4\4\0'\5\n\0-\6\1\0\18\a\1\0'\t\v\0B\a\2\0A\2\3\0016\2\1\0009\2\2\0029\2\3\2'\4\4\0'\5\f\0-\6\2\0\18\a\1\0'\t\r\0B\a\2\0A\2\3\0016\2\1\0009\2\2\0029\2\3\2'\4\4\0'\5\14\0-\6\0\0009\6\6\0069\6\15\0069\6\16\6\18\a\1\0'\t\17\0B\a\2\0A\2\3\0016\2\1\0009\2\2\0029\2\3\2'\4\4\0'\5\18\0-\6\3\0\18\a\1\0'\t\19\0B\a\2\0A\2\3\0016\2\1\0009\2\2\0029\2\3\2'\4\4\0'\5\20\0-\6\4\0\18\a\1\0'\t\21\0B\a\2\0A\2\3\0016\2\1\0009\2\2\0029\2\3\2'\4\4\0'\5\22\0-\6\5\0\18\a\1\0'\t\23\0B\a\2\0A\2\3\0016\2\1\0009\2\2\0029\2\3\2'\4\4\0'\5\24\0-\6\0\0009\6\6\0069\6\a\0069\6\25\6\18\a\1\0'\t\26\0B\a\2\0A\2\3\0016\2\1\0009\2\2\0029\2\3\2'\4\4\0'\5\27\0-\6\0\0009\6\6\0069\6\a\0069\6\28\6\18\a\1\0'\t\29\0B\a\2\0A\2\3\0016\2\1\0009\2\2\0029\2\3\2'\4\4\0'\5\30\0-\6\0\0009\6\6\0069\6\15\0069\6\31\6\18\a\1\0'\t \0B\a\2\0A\2\3\0016\2\1\0009\2\2\0029\2\3\2'\4\4\0'\5!\0-\6\0\0009\6\6\0069\6\a\0069\6\"\6\18\a\1\0'\t#\0B\a\2\0A\2\3\0016\2\1\0009\2\2\0029\2\3\2'\4\4\0'\5$\0-\6\0\0009\6\6\0069\6\15\0069\6%\0069\6&\6\18\a\1\0'\t'\0B\a\2\0A\2\3\0016\2\1\0009\2\2\0029\2\3\2'\4\4\0'\5(\0-\6\0\0009\6\6\0069\6\15\0069\6%\0069\6)\6\18\a\1\0'\t*\0B\a\2\0A\2\3\0016\2\1\0009\2\2\0029\2\3\2'\4\4\0'\5+\0-\6\0\0009\6,\0069\6-\6\18\a\1\0'\t.\0B\a\2\0A\2\3\0016\2\1\0009\2\2\0029\2\3\2'\4\4\0'\5/\0-\6\0\0009\6,\0069\0060\6\18\a\1\0'\t1\0B\a\2\0A\2\3\0016\2\1\0009\2\2\0029\2\3\2'\4\4\0'\0052\0-\6\0\0009\0063\0069\0064\6\18\a\1\0'\t5\0B\a\2\0A\2\3\0016\2\1\0009\2\2\0029\2\3\2'\4\4\0'\0056\0-\6\0\0009\0063\0069\0067\6\18\a\1\0'\t8\0B\a\2\0A\2\3\0016\2\1\0009\2\2\0029\2\3\2'\4\4\0'\0059\0-\6\0\0009\0063\0069\6:\6\18\a\1\0'\t;\0B\a\2\0A\2\3\0016\2\1\0009\2\2\0029\2\3\2'\4\4\0'\5<\0-\6\0\0009\0063\0069\6=\6\18\a\1\0'\t>\0B\a\2\0A\2\3\0016\2\1\0009\2\2\0029\2\3\2'\4\4\0'\5?\0-\6\0\0009\0063\0069\6@\0069\6\6\6\18\a\1\0'\tA\0B\a\2\0A\2\3\0016\2\1\0009\2\2\0029\2\3\2'\4\4\0'\5B\0-\6\0\0009\0063\0069\6C\6\18\a\1\0'\tD\0B\a\2\0A\2\3\0016\2\1\0009\2\2\0029\2\3\2'\4\4\0'\5E\0-\6\0\0009\0063\0069\6@\0069\6F\6\18\a\1\0'\tG\0B\a\2\0A\2\3\0016\2\1\0009\2\2\0029\2\3\2'\4\4\0'\5H\0-\6\0\0009\0063\0069\6@\0069\6I\6\18\a\1\0'\tJ\0B\a\2\0A\2\3\0016\2\1\0009\2\2\0029\2\3\2'\4\4\0'\5K\0-\6\0\0009\0063\0069\6@\0069\6L\6\18\a\1\0'\tM\0B\a\2\0A\2\3\0016\2\1\0009\2\2\0029\2\3\2'\4\4\0'\5N\0-\6\0\0009\6\6\0069\6\15\0069\6O\0069\6P\6\18\a\1\0'\tQ\0B\a\2\0A\2\3\0016\2\1\0009\2\2\0029\2\3\2'\4\4\0'\5R\0-\6\0\0009\6\6\0069\6\15\0069\6O\0069\6S\6\18\a\1\0'\tT\0B\a\2\0A\2\3\0016\2\1\0009\2\2\0029\2\3\2'\4\4\0'\5U\0-\6\0\0009\6,\0069\6V\6\18\a\1\0'\tW\0B\a\2\0A\2\3\0016\2\1\0009\2\2\0029\2\3\2'\4\4\0'\5X\0-\6\0\0009\6,\0069\6Y\6\18\a\1\0'\tZ\0B\a\2\0A\2\3\0012\0\0ÄK\0\1\0\2¿\5¿\a¿\6¿\b¿\t¿\tHelp\16toggle_help\6?\nClose\nclose\6q\rNext Git\tnext\a]c\rPrev Git\tprev\bgit\a[c\23Copy Absolute Path\18absolute_path\agy\23Copy Relative Path\18relative_path\6Y\14Copy Name\rfilename\6y\nPaste\npaste\6p\tCopy\tcopy\6c\bCut\bcut\6x\vRename\vrename\6r\vDelete\vremove\6d\vCreate\vcreate\afs\6a\fRefresh\vreload\6R\20Toggle Dotfiles\25toggle_hidden_filter\ttree\6H\17Last Sibling\tlast\6K\18First Sibling\nfirst\fsibling\6L\17Open Preview\fpreview\n<Tab>\21Parent Directory\vparent\6P\27Open: Horizontal Split\15horizontal\n<C-x>\25Open: Vertical Split\rvertical\n<C-v>\20open_tab_silent\6T\fgit_add\aga\rCollapse\6J\20Close Directory\17parent_close\rnavigate\6j\vexpand\a√ß\23swap_then_open_tab\6t\27Open: No Window Picker\21no_window_picker\topen\tnode\6o\6n\bset\vkeymap\bvim\0Ç\17\1\0\19\0|\0´\0016\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0026\2\0\0'\4\3\0B\2\2\0029\3\4\0029\3\5\0039\5\4\0029\5\6\0059\5\a\0053\6\b\0B\3\3\0013\3\t\0006\4\n\0009\4\v\0049\4\f\4'\6\r\0005\a\14\0=\3\15\aB\4\3\0013\4\16\0006\5\n\0009\5\v\0059\5\f\5'\a\17\0005\b\19\0003\t\18\0=\t\15\bB\5\3\0013\5\20\0003\6\21\0003\a\22\0003\b\23\0003\t\24\0006\n\0\0'\f\25\0B\n\2\0029\v\26\0005\r \0005\14\30\0005\15\27\0005\16\28\0=\16\29\15=\15\31\14=\14!\r5\14%\0006\15\n\0009\15\"\0159\15#\0159\15$\15=\15&\14=\14'\r5\14(\0005\15+\0009\16)\n9\16*\16=\16,\0159\16)\n9\16-\16=\16.\0159\16)\n9\16/\16=\0160\0159\16)\n9\0161\16=\0162\15=\0153\14=\14)\r3\0144\0=\0145\r5\0146\0005\0157\0=\0158\0145\15`\0005\16;\0009\0179\n9\17:\17=\17<\0169\0179\n9\17=\17=\17>\0169\0179\n9\17?\17=\17@\0165\17B\0009\0189\n9\18A\18=\18C\0179\0189\n9\18D\18=\18E\0179\0189\n9\18F\18=\18<\0179\0189\n9\18G\18=\18H\0179\0189\n9\18I\18=\18J\0179\0189\n9\18K\18=\18L\0179\0189\n9\18M\18=\18>\0179\0189\n9\18G\18=\18N\17=\17O\0165\17R\0009\18P\n9\18Q\18=\18S\0179\18P\n9\18T\18=\18U\0179\18P\n9\18V\18=\18W\0179\18P\n9\18X\18=\18Y\0179\18P\n9\18Z\18=\18[\0179\18P\n9\18\\\18=\18]\0179\18P\n9\18^\18=\18_\17=\17P\16=\16a\15=\0153\14=\14b\r5\14c\0=\14d\r5\14e\0005\15f\0=\15g\14=\14h\r5\14i\0004\15\0\0=\15j\14=\14k\r5\14l\0005\15m\0=\15n\0144\15\0\0=\15o\14=\14p\r5\14q\0=\14P\r5\14r\0005\15s\0=\15t\0145\15u\0=\15v\14=\14w\r5\14x\0=\14y\r5\14z\0=\14{\rB\v\2\0012\0\0ÄK\0\1\0\ntrash\1\0\2\20require_confirm\2\bcmd\ntrash\tview\1\0\4\vnumber\1\nwidth\3\30\19relativenumber\1\tside\tleft\factions\14open_file\1\0\2\18resize_window\2\17quit_on_open\1\15change_dir\1\0\3\vglobal\1\venable\2\23restrict_above_cwd\1\1\0\1\25use_system_clipboard\2\1\0\3\venable\2\ftimeout\3Ù\3\vignore\2\ffilters\fexclude\vcustom\1\3\0\0\17node_modules\f\\.cache\1\0\3\rdotfiles\1\14git_clean\1\14no_buffer\1\16system_open\targs\1\0\1\bcmd\5\24update_focused_file\16ignore_list\1\2\0\0\14gitcommit\1\0\2\15update_cwd\2\venable\2\23hijack_directories\1\0\2\venable\2\14auto_open\2\rrenderer\vglyphs\1\0\0\fignored\vIgnore\fdeleted\vRemove\14untracked\14Untracked\frenamed\vRename\runmerged\rUnmerged\vstaged\vStaged\runstaged\1\0\0\rUnstaged\bgit\vfolder\17symlink_open\18FolderSymlink\15empty_open\20EmptyFolderOpen\nempty\16EmptyFolder\topen\15FolderOpen\vFolder\15arrow_open\27TriangleShortArrowDown\17arrow_closed\1\0\0\28TriangleShortArrowRight\rbookmark\rBookMark\fsymlink\16FileSymlink\fdefault\1\0\0\tText\aui\19indent_markers\1\0\1\venable\1\1\0\6\22root_folder_label\16:~:s?$?/..?\17add_trailing\1\16group_empty\1\18highlight_git\2\27highlight_opened_files\tnone\25root_folder_modifier\a:~\14on_attach\0\nicons\nerror\nError\fwarning\fWarning\tinfo\16Information\thint\1\0\0\tHint\16diagnostics\1\0\2\venable\1\17show_on_dirs\1\vnotify\14threshold\1\0\0\tINFO\vlevels\blog\btab\1\0\a\20respect_buf_cwd\1\18disable_netrw\1\15update_cwd\2\17hijack_netrw\2\18hijack_cursor\1'hijack_unnamed_buffer_when_opening\2\16open_on_tab\1\tsync\1\0\0\vignore\1\2\0\0\14gitcommit\1\0\2\nclose\2\topen\2\nsetup\16utils.icons\0\0\0\0\0\1\0\1\vnested\2\0\14WinClosed\0\rcallback\1\0\0\rVimEnter\24nvim_create_autocmd\bapi\bvim\0\0\16FileCreated\nEvent\14subscribe\vevents\18nvim-tree.api\18nvim-tree.lib\14nvim-tree\frequire\0", "config", "nvim-tree.lua")
time([[Config for nvim-tree.lua]], false)
-- Config for: vim-visual-multi
time([[Config for vim-visual-multi]], true)
try_loadstring("\27LJ\2\nÄ\3\0\0\4\0\f\0\0256\0\0\0009\0\1\0)\1\0\0=\1\2\0006\0\0\0009\0\1\0)\1\0\0=\1\3\0006\0\0\0009\0\4\0009\0\5\0'\2\6\0005\3\a\0B\0\3\0016\0\0\0009\0\4\0009\0\5\0'\2\b\0005\3\t\0B\0\3\0016\0\0\0009\0\1\0005\1\v\0=\1\n\0K\0\1\0\1\0\4\6j\6h\6k\6j\6l\6k\a√ß\6l\22VM_custom_motions\1\0\a\15Find Under\n<C-n>\tRedo\n<C-r>\23Find Subword Under\n<C-n>\tUndo\6u\15Select All\14<leader>A\18Add Cursor Up\f<C-M-l>\20Add Cursor Down\f<C-M-k>\fVM_maps\1\0\3\vvisual\6 \fdefault\6 \vbuffer\6z\14VM_leader\17nvim_set_var\bapi\21VM_show_warnings\24VM_default_mappings\6g\bvim\0", "config", "vim-visual-multi")
time([[Config for vim-visual-multi]], false)
-- Config for: hop.nvim
time([[Config for hop.nvim]], true)
try_loadstring("\27LJ\2\nO\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\tkeys\22√ßalskdjfwoeicmvn\nsetup\bhop\frequire\0", "config", "hop.nvim")
time([[Config for hop.nvim]], false)
-- Config for: nvim-treesitter
time([[Config for nvim-treesitter]], true)
try_loadstring("\27LJ\2\nÇ\n\0\0\a\0001\00076\0\0\0'\2\1\0B\0\2\0029\1\2\0005\3\4\0005\4\3\0=\4\5\0035\4\6\0=\4\a\0035\4\t\0005\5\b\0=\5\n\0045\5\v\0=\5\f\4=\4\r\0035\4\14\0005\5\15\0=\5\16\4=\4\17\0035\4\18\0=\4\19\0035\4\20\0004\5\0\0=\5\21\4=\4\22\0035\4\23\0=\4\24\0035\4\25\0=\4\26\0035\4\29\0005\5\27\0005\6\28\0=\6\16\5=\5\30\0045\5\31\0005\6 \0=\6!\0055\6\"\0=\6#\0055\6$\0=\6%\0055\6&\0=\6'\5=\5(\0045\5)\0004\6\0\0=\6*\5=\5+\4=\4,\0035\4-\0=\4.\0035\4/\0=\0040\3B\1\2\1K\0\1\0\fendwise\1\0\1\venable\2\fmatchup\1\0\1\venable\1\16textobjects\tswap\14swap_next\1\0\1\venable\1\tmove\22goto_previous_end\1\0\2\a[M\17@class.outer\a[]\20@function.outer\18goto_next_end\1\0\2\a]M\17@class.outer\a][\20@function.outer\24goto_previous_start\1\0\2\a[m\17@class.outer\a[[\20@function.outer\20goto_next_start\1\0\2\a]m\17@class.outer\a]]\20@function.outer\1\0\2\14set_jumps\2\venable\2\vselect\1\0\0\1\0\4\aic\17@class.inner\aaf\20@function.outer\aac\17@class.outer\aif\20@function.inner\1\0\3\14lookahead\2#include_surrounding_whitespace\1\venable\2\26context_commentstring\1\0\2\19enable_autocmd\1\venable\2\frainbow\1\0\2\venable\2\18extended_mode\1\vindent\fdisable\1\0\1\venable\2\14highlight\1\0\3\21use_languagetree\2\venable\2&additional_vim_regex_highlighting\1\26incremental_selection\fkeymaps\1\0\2\19init_selection\14<C-space>\21node_incremental\14<C-space>\1\0\1\venable\2\rrefactor\28highlight_current_scope\1\0\1\venable\1\26highlight_definitions\1\0\0\1\0\1\venable\2\fautotag\1\0\1\venable\2\21ensure_installed\1\0\1\17auto_install\2\1\23\0\0\bvim\vvimdoc\rmarkdown\20markdown_inline\tbash\nregex\15javascript\15typescript\vprisma\truby\btsx\vpython\tdart\tjson\thtml\blua\bcss\tscss\ttoml\tfish\njsdoc\tyaml\nsetup\28nvim-treesitter.configs\frequire\0", "config", "nvim-treesitter")
time([[Config for nvim-treesitter]], false)
-- Config for: comment-box.nvim
time([[Config for comment-box.nvim]], true)
try_loadstring("\27LJ\2\n„\2\0\0\4\0\b\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\0025\3\6\0=\3\a\2B\0\2\1K\0\1\0\tline\1\0\3\rline_end\b‚îÄ\15line_start\b‚îÄ\tline\b‚îÄ\fborders\1\0\b\tleft\b‚îÇ\nright\b‚îÇ\16bottom_left\b‚ï∞\17bottom_right\b‚ïØ\rtop_left\b‚ï≠\14top_right\b‚ïÆ\vbottom\b‚îÄ\btop\b‚îÄ\1\0\a\22inner_blank_lines\1\22outer_blank_lines\1\26line_blank_line_below\1\14box_width\3<\14doc_width\3P\15line_width\3d\26line_blank_line_above\1\nsetup\16comment-box\frequire\0", "config", "comment-box.nvim")
time([[Config for comment-box.nvim]], false)
-- Config for: Comment.nvim
time([[Config for Comment.nvim]], true)
try_loadstring("\27LJ\2\nÇ\2\0\0\6\0\f\0\0216\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0004\3\0\0=\3\4\0024\3\0\0=\3\5\0024\3\0\0=\3\6\0025\3\a\0=\3\b\0026\3\0\0'\5\t\0B\3\2\0029\3\n\3B\3\1\2=\3\v\2B\0\2\1K\0\1\0\rpre_hook\20create_pre_hook7ts_context_commentstring.integrations.comment_nvim\rmappings\1\0\2\nbasic\2\nextra\2\nextra\ropleader\ftoggler\1\0\2\vsticky\2\fpadding\2\nsetup\fComment\frequire\0", "config", "Comment.nvim")
time([[Config for Comment.nvim]], false)
-- Config for: nvim-cmp
time([[Config for nvim-cmp]], true)
try_loadstring("\27LJ\2\n-\0\1\4\1\2\0\5-\1\0\0009\1\0\0019\3\1\0B\1\2\1K\0\1\0\3¿\tbody\15lsp_expand£\3\0\2\a\0\19\0.5\2\1\0009\3\2\0009\3\3\0038\2\3\2\14\0\2\0X\3\1Ä)\2\0\0=\2\0\0019\2\4\1\a\2\5\0X\2\fÄ9\2\6\0009\2\a\2\15\0\2\0X\3\bÄ6\2\b\0'\4\t\0B\2\2\0029\2\n\2\18\4\0\0\18\5\1\0B\2\3\2\18\1\2\0006\2\v\0009\2\f\0025\4\r\0009\5\2\0009\5\3\5B\2\3\2\15\0\2\0X\3\14Ä6\2\b\0'\4\14\0B\2\2\0029\2\15\2\18\6\0\0009\4\16\0B\4\2\0029\4\17\4B\2\2\3\15\0\2\0X\4\3Ä=\2\4\1=\3\18\1L\1\2\0L\1\2\0\18kind_hl_group\nlabel\24get_completion_item\rget_icon\22nvim-web-devicons\1\2\0\0\tpath\17tbl_contains\bvim\20format_tailwind%plugins.cmp.utils.custom_formats\frequire\18documentation\20completion_item\nColor\tkind\tname\vsource\1\0\2\tpath\3\0\rnvim_lsp\3\0\bdupπ\14\1\0\14\0L\0†\0016\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0026\2\0\0'\4\3\0B\2\2\0026\3\0\0'\5\4\0B\3\2\0029\4\5\0005\6\t\0005\a\a\0003\b\6\0=\b\b\a=\a\n\0066\a\0\0'\t\v\0B\a\2\2=\a\f\0069\a\r\0009\a\14\a4\t\6\0005\n\15\0>\n\1\t5\n\16\0>\n\2\t5\n\17\0>\n\3\t5\n\18\0>\n\4\t5\n\19\0>\n\5\tB\a\2\2=\a\14\0065\a\20\0=\a\21\0065\a$\0004\b\f\0009\t\r\0009\t\22\t9\t\23\t>\t\1\b9\t\r\0009\t\22\t9\t\24\t>\t\2\b6\t\0\0'\v\25\0B\t\2\0029\t\26\t>\t\3\b6\t\0\0'\v\27\0B\t\2\0029\t\28\t>\t\4\b6\t\0\0'\v\27\0B\t\2\0029\t\29\t>\t\5\b9\t\r\0009\t\22\t9\t\30\t>\t\6\b9\t\r\0009\t\22\t9\t\29\t>\t\a\b9\t\r\0009\t\22\t9\t\31\t>\t\b\b6\t\0\0'\v \0B\t\2\0029\t!\t>\t\t\b9\t\r\0009\t\22\t9\t\"\t>\t\n\b9\t\r\0009\t\22\t9\t#\t>\t\v\b=\b%\a=\a&\0065\a(\0005\b'\0=\b)\a9\b*\0025\n+\0006\v\0\0'\r,\0B\v\2\0029\v\3\v=\v-\n3\v.\0=\v/\nB\b\2\2=\b0\a=\a1\0065\a4\0009\b2\0019\b3\b=\b5\a=\a6\0065\a:\0009\b\r\0009\b7\b9\b8\b5\n9\0B\b\2\2=\b;\a9\b\r\0009\b7\b9\b8\b5\n<\0B\b\2\2=\b=\a=\a7\0065\a>\0=\a?\0069\a@\0009\aA\a=\aB\0065\aC\0=\aD\6B\4\2\0019\4\5\0009\4E\4'\6F\0005\aI\0009\b\r\0009\b\14\b4\n\3\0005\vG\0>\v\1\n4\v\3\0005\fH\0>\f\1\vB\b\3\2=\b\14\aB\4\3\0016\4\0\0'\6J\0B\4\2\0029\4\5\4B\4\1\0016\4\0\0'\6K\0B\4\2\0029\4\5\4B\4\1\0012\0\0ÄK\0\1\0\24plugins.cmp.cmdline\24plugins.cmp.copilot\1\0\0\1\0\1\tname\vbuffer\1\0\1\tname\24conventionalcommits\14gitcommit\rfiletype\tview\1\0\1\fentries\vcustom\14preselect\tItem\18PreselectMode\17experimental\1\0\1\15ghost_text\2\18documentation\1\0\1\17winhighlight7Normal:TelescopeNormal,FloatBorder:TelescopeBorder\15completion\1\0\0\1\0\4\vborder\frounded\15col_offset\3˝ˇˇˇ\15\17winhighlight7Normal:TelescopeNormal,FloatBorder:TelescopeBorder\17side_padding\3\1\rbordered\vwindow\17confirm_opts\rbehavior\1\0\1\vselect\1\fReplace\20ConfirmBehavior\15formatting\vformat\vbefore\0\15symbol_map\16utils.icons\1\0\2\tmode\vsymbol\14max_width\0032\15cmp_format\vfields\1\0\0\1\4\0\0\tkind\tabbr\tmenu\fsorting\16comparators\1\0\0\norder\14sort_text\nunder\25cmp-under-comparator\rlocality\voffset\nscore\15prioritize\28copilot_cmp.comparators\25deprioritize_snippet\"plugins.cmp.utils.comparators\nexact\tkind\fcompare\15duplicates\1\0\4\tpath\3\1\vbuffer\3\1\fluasnip\3\0\rnvim_lsp\3\0\1\0\4\tname\vbuffer\19keyword_length\3\4\16group_index\3\2\19max_item_count\3\5\1\0\3\tname\fcopilot\19keyword_length\3\0\16group_index\3\1\1\0\3\tname\tpath\16group_index\3\1\19max_item_count\3\4\1\0\2\tname\rnvim_lsp\16group_index\3\1\1\0\5\16group_index\3\1\19keyword_length\3\2\rpriority\3\a\19max_item_count\3\5\tname\fluasnip\fsources\vconfig\fmapping\25plugins.cmp.mappings\fsnippet\1\0\0\vexpand\1\0\0\0\nsetup\fluasnip\flspkind\18cmp.types.cmp\bcmp\frequire\0", "config", "nvim-cmp")
time([[Config for nvim-cmp]], false)
-- Config for: prettier.nvim
time([[Config for prettier.nvim]], true)
try_loadstring("\27LJ\2\n\15\0\0\1\0\0\0\2+\0\2\0L\0\2\0\15\0\1\2\0\0\0\2+\1\2\0L\1\2\0\4\1\0\5\0\14\0\0176\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\0025\3\6\0=\3\a\0025\3\t\0003\4\b\0=\4\n\0033\4\v\0=\4\f\3=\3\r\2B\0\2\1K\0\1\0\fnull-ls\22runtime_condition\0\14condition\1\0\1\ftimeout\3à'\0\14filetypes\1\r\0\0\bcss\fgraphql\thtml\15javascript\20javascriptreact\tjson\tless\rmarkdown\tscss\15typescript\20typescriptreact\tyaml\16cli_options\1\0\17\16quote_props\14as-needed\15prose_wrap\rpreserve\16print_width\3P\21jsx_single_quote\1 html_whitespace_sensitivity\bcss\16end_of_line\alf!embedded_language_formatting\tauto\22bracket_same_line\1\20bracket_spacing\2\17arrow_parens\valways vue_indent_script_and_style\1\ruse_tabs\1\19trailing_comma\bes5\14tab_width\3\2\17single_quote\2\30single_attribute_per_line\1\tsemi\2\1\0\1\bbin\14prettierd\nsetup\rprettier\frequire\0", "config", "prettier.nvim")
time([[Config for prettier.nvim]], false)
-- Config for: nvim-ufo
time([[Config for nvim-ufo]], true)
try_loadstring("\27LJ\2\n˘\2\0\5\23\0\v\0I4\5\0\0'\6\0\0\18\b\6\0009\6\1\6!\t\1\2B\6\3\0026\a\2\0009\a\3\a9\a\4\a\18\t\6\0B\a\2\2!\b\a\3)\t\0\0006\n\5\0\18\f\0\0B\n\2\4X\r/Ä:\15\1\0146\16\2\0009\16\3\0169\16\4\16\18\18\15\0B\16\2\2 \17\16\t\1\17\b\0X\17\6Ä6\17\6\0009\17\a\17\18\19\5\0\18\20\14\0B\17\3\1X\17\31Ä\18\17\4\0\18\19\15\0!\20\t\bB\17\3\2\18\15\17\0:\17\2\0146\18\6\0009\18\a\18\18\20\5\0004\21\3\0>\15\1\21>\17\2\21B\18\3\0016\18\2\0009\18\3\0189\18\4\18\18\20\15\0B\18\2\2\18\16\18\0 \18\16\t\1\18\b\0X\18\fÄ\18\18\6\0'\19\b\0\18\21\19\0009\19\t\19!\22\t\b!\22\16\22B\19\3\2&\6\19\18X\n\3Ä \t\16\tE\r\3\3R\rœ\1276\n\6\0009\n\a\n\18\f\5\0005\r\n\0>\6\1\rB\n\3\1L\5\2\0\1\3\0\0\0\fMoreMsg\brep\6 \vinsert\ntable\vipairs\20strdisplaywidth\afn\bvim\vformat\r ÔïÅ %d ∫\1\0\3\a\0\t\0\0266\3\0\0\18\5\1\0B\3\2\2\a\3\1\0X\3\14Ä\18\5\1\0009\3\2\1'\6\3\0B\3\3\2\15\0\3\0X\4\bÄ6\3\4\0'\5\5\0B\3\2\0029\3\6\3\18\5\0\0\18\6\2\0D\3\3\0X\3\6Ä6\3\4\0'\5\a\0B\3\2\0029\3\b\3\18\5\1\0D\3\2\0K\0\1\0\vreject\fpromise\rgetFolds\bufo\frequire\25UfoFallbackException\nmatch\vstring\ttype*\0\1\6\2\1\0\5-\1\0\0-\3\1\0\18\4\0\0'\5\0\0D\1\4\0\0\0\0¿\15treesitter&\0\1\6\2\1\0\5-\1\0\0-\3\1\0\18\4\0\0'\5\0\0D\1\4\0\0\0\0¿\vindentj\1\1\5\1\a\0\0166\1\0\0'\3\1\0B\1\2\0029\1\2\1\18\3\0\0'\4\3\0B\1\3\2\18\3\1\0009\1\4\0013\4\5\0B\1\3\2\18\3\1\0009\1\4\0013\4\6\0002\0\0ÄD\1\3\0\3¿\0\0\ncatch\blsp\rgetFolds\bufo\frequire@\1\3\5\0\5\0\n3\3\0\0\6\1\1\0X\4\2Ä\a\2\2\0X\4\2Ä'\4\3\0X\5\1Ä3\4\4\0002\0\0ÄL\4\2\0\0\vindent\vnofile\5\0Õ\1\1\0\6\0\r\0\0236\0\0\0'\2\1\0B\0\2\0023\1\2\0006\2\3\0009\2\4\2)\3c\0=\3\5\0026\2\3\0009\2\4\2)\3c\0=\3\6\0026\2\3\0009\2\4\2+\3\2\0=\3\a\0029\2\b\0005\4\t\0=\1\n\0043\5\v\0=\5\f\4B\2\2\1K\0\1\0\22provider_selector\0\27fold_virt_text_handler\1\0\0\nsetup\15foldenable\19foldlevelstart\14foldlevel\6o\bvim\0\bufo\frequire\0", "config", "nvim-ufo")
time([[Config for nvim-ufo]], false)
-- Config for: nvim-web-devicons
time([[Config for nvim-web-devicons]], true)
try_loadstring("\27LJ\2\n`\0\0\4\0\5\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0004\3\0\0=\3\4\2B\0\2\1K\0\1\0\roverride\1\0\1\fdefault\2\nsetup\22nvim-web-devicons\frequire\0", "config", "nvim-web-devicons")
time([[Config for nvim-web-devicons]], false)
-- Config for: nvim-navbuddy
time([[Config for nvim-navbuddy]], true)
try_loadstring("\27LJ\2\nk\0\0\t\0\5\0\0166\0\0\0'\2\1\0B\0\2\0029\0\2\0004\1\0\0006\2\3\0\18\4\0\0B\2\2\4H\5\4Ä\18\a\5\0'\b\4\0&\a\b\a<\6\a\1F\5\3\3R\5˙\127L\1\2\0\6 \npairs\flspkind\16utils.icons\frequire\b\1\0\v\0M\0X6\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0023\2\3\0009\3\4\0005\5\14\0005\6\5\0005\a\a\0005\b\6\0=\b\b\a5\b\t\0=\b\n\a5\b\v\0=\b\f\a=\a\r\6=\6\15\0055\6\16\0005\a\17\0=\a\18\6=\6\19\5\18\6\2\0B\6\1\2=\6\18\0055\6\21\0009\a\20\1=\a\22\0069\a\20\1=\a\23\0069\a\24\1=\a\25\0069\a\26\1=\a\27\0069\a\28\1=\a\29\0069\a\30\1=\a\31\0069\a \1=\a!\0069\a\"\1=\a#\0069\a$\1=\a%\0069\a&\1=\a'\0069\a(\1=\a)\0069\a*\1=\a+\0069\a,\1=\a-\0069\a.\1=\a/\0069\a0\1=\a1\0069\a2\1=\a3\0069\a4\1=\a5\0069\a6\1=\a7\0069\a8\1=\a9\0069\a:\1=\a;\0069\a<\1=\a=\0069\a<\1=\a>\0069\a?\1=\a@\0069\aA\1=\aB\0069\aC\0015\tE\0005\nD\0=\nF\tB\a\2\2=\aG\6=\6H\0055\6I\0=\6J\0055\6K\0=\6L\5B\3\2\1K\0\1\0\18source_buffer\1\0\3\14highlight\2\rreorient\nsmart\16follow_node\2\blsp\1\0\1\16auto_attach\1\rmappings\6t\18layout_config\1\0\1\20layout_strategy\15horizontal\1\0\4\20prompt_position\btop\18preview_width\4\0ÄÄÄˇ\3\nwidth\4≥ÊÃô\3≥Êåˇ\3\vheight\4≥ÊÃô\3≥Êåˇ\3\14telescope\n<A-l>\fmove_up\n<A-k>\14move_down\6o\f<enter>\vselect\6c\fcomment\6F\16fold_delete\6f\16fold_create\6d\vdelete\6r\vrename\6A\17append_scope\6a\16append_name\6I\17insert_scope\6i\16insert_name\6Y\15yank_scope\6y\14yank_name\6V\17visual_scope\6v\16visual_name\0060\troot\a√ß\rchildren\6j\vparent\6l\21previous_sibling\6k\17next_sibling\6q\n<esc>\1\0\0\nclose\17node_markers\nicons\1\0\3\18leaf_selected\n ‚Üí \tleaf\a  \vbranch\t Ôë†\1\0\1\fenabled\2\vwindow\1\0\1\25use_default_mappings\2\rsections\nright\1\0\1\fpreview\tleaf\bmid\1\0\1\tsize\b40%\tleft\1\0\0\1\0\1\tsize\b20%\1\0\3\tsize\b60%\rposition\b50%\vborder\vsingle\nsetup\0\26nvim-navbuddy.actions\18nvim-navbuddy\frequire\0", "config", "nvim-navbuddy")
time([[Config for nvim-navbuddy]], false)
-- Config for: flutter-tools.nvim
time([[Config for flutter-tools.nvim]], true)
try_loadstring("\27LJ\2\né\4\0\2\b\1\20\0(6\2\0\0'\4\1\0B\2\2\0029\2\2\2\18\4\0\0\18\5\1\0B\2\3\1-\2\0\0'\4\3\0'\5\4\0'\6\5\0005\a\6\0B\2\5\1-\2\0\0'\4\3\0'\5\a\0'\6\b\0005\a\t\0B\2\5\1-\2\0\0'\4\3\0'\5\n\0'\6\v\0005\a\f\0B\2\5\1-\2\0\0'\4\3\0'\5\r\0'\6\14\0005\a\15\0B\2\5\0016\2\16\0009\2\17\0026\4\0\0'\6\18\0B\4\2\0029\4\19\4B\4\1\0A\2\0\1K\0\1\0\0\0\24get_base_highlights\16colorscheme\fset_hls\nutils\1\0\1\tdesc!flutter: run code generation;:TermExec cmd='flutter pub run build_runner watch'<CR>\15<leader>br\1\0\1\tdesc\26Flutter: open pallete\17:Flutter<CR>\22<leader><leader>o\1\0\1\tdesc\21Flutter: restart\24:FlutterRestart<CR>\22<leader><leader>r\1\0\1\tdesc\20Flutter: reload\23:FlutterReload<CR>\14<leader>r\6n\21common_on_attach\blsp\frequireµ\3\1\0\b\1\23\0\0316\0\0\0'\2\1\0B\0\2\0029\1\2\0005\3\4\0005\4\3\0=\4\5\0034\4\0\0=\4\6\0035\4\b\0005\5\a\0=\5\t\4=\4\n\0035\4\v\0=\4\f\0035\4\r\0=\4\14\0035\4\16\0005\5\15\0=\5\17\0043\5\18\0=\5\19\0046\5\0\0'\a\20\0B\5\2\0029\5\21\5B\5\1\2=\5\22\4=\4\20\3B\1\2\1K\0\1\0\1¿\17capabilities\24common_capabilities\blsp\14on_attach\0\rsettings\1\0\0\1\0\2\14showTodos\2\27renameFilesWithClasses\vprompt\fdev_log\1\0\2\fenabled\2\ropen_cmd\ftabedit\18widget_guides\1\0\1\fenabled\2\16decorations\15statusline\1\0\0\1\0\2\16app_version\2\vdevice\2\rdebugger\aui\1\0\0\1\0\2\23notification_style\vplugin\vborder\frounded\nsetup\18flutter-tools\frequire\0", "config", "flutter-tools.nvim")
time([[Config for flutter-tools.nvim]], false)
-- Config for: nvim-colorizer.lua
time([[Config for nvim-colorizer.lua]], true)
try_loadstring("\27LJ\2\nõ\1\0\0\4\0\b\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0025\3\6\0=\3\a\2B\0\2\1K\0\1\0\25user_default_options\1\0\3\tmode\15background\rtailwind\tboth\nnames\1\14filetypes\1\0\0\1\2\0\0\6*\nsetup\14colorizer\frequire\0", "config", "nvim-colorizer.lua")
time([[Config for nvim-colorizer.lua]], false)
-- Config for: dressing.nvim
time([[Config for dressing.nvim]], true)
try_loadstring("\27LJ\2\n\v\0\1\1\0\0\0\1L\0\2\0\v\0\1\1\0\0\0\1L\0\2\0ö\n\1\0\6\0001\0?6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\19\0005\3\3\0005\4\4\0=\4\5\0035\4\6\0=\4\a\0034\4\0\0=\4\b\0035\4\t\0=\4\n\0035\4\f\0005\5\v\0=\5\r\0045\5\14\0=\5\15\4=\4\16\0033\4\17\0=\4\18\3=\3\20\0025\3\21\0005\4\22\0=\4\23\0035\4\25\0005\5\24\0=\5\26\4=\4\27\0035\4\29\0005\5\28\0=\5\30\4=\4\31\0035\4 \0005\5!\0=\5\"\0045\5#\0=\5\b\0045\5$\0=\5\n\4=\4%\0035\4&\0004\5\0\0=\5\b\0045\5'\0=\5\n\0045\5(\0=\5\5\0045\5)\0=\5\a\0045\5*\0=\5+\0045\5,\0=\5\16\0043\5-\0=\5\18\4=\4.\0034\4\0\0=\4/\3=\0030\2B\0\2\1K\0\1\0\vselect\25format_item_override\fbuiltin\0\1\0\3\t<CR>\fConfirm\n<Esc>\nClose\n<C-c>\nClose\15min_height\1\3\0\0\3\n\4ö≥ÊÃ\tô≥¶˛\3\1\3\0\0\3(\4ö≥ÊÃ\tô≥¶˛\3\1\3\0\0\3å\1\4ö≥ÊÃ\tô≥¶ˇ\3\1\0\2\rwinblend\3\n\17winhighlight\"Normal:Normal,NormalNC:Normal\1\0\4\vanchor\aNW\rrelative\veditor\15max_height\4Õô≥Ê\fÃô≥ˇ\3\vborder\frounded\bnui\1\0\1\rwinblend\3\n\1\0\2\rswapfile\1\rfiletype\19DressingSelect\vborder\1\0\1\nstyle\frounded\1\0\6\15max_height\3(\14max_width\3P\14min_width\3(\15min_height\3\n\rrelative\veditor\rposition\b50%\ffzf_lua\fwinopts\1\0\0\1\0\2\nwidth\4\0ÄÄÄˇ\3\vheight\4ö≥ÊÃ\tô≥Ê˛\3\bfzf\vwindow\1\0\0\1\0\2\nwidth\4\0ÄÄÄˇ\3\vheight\4ö≥ÊÃ\tô≥Ê˛\3\fbackend\1\6\0\0\14telescope\ffzf_lua\bfzf\fbuiltin\bnui\1\0\2\fenabled\2\16trim_prompt\2\ninput\1\0\0\roverride\0\rmappings\6i\1\0\4\t<Up>\16HistoryPrev\t<CR>\fConfirm\v<Down>\16HistoryNext\n<C-c>\nClose\6n\1\0\0\1\0\2\n<Esc>\nClose\t<CR>\fConfirm\16win_options\1\0\3\rwinblend\3\0\twrap\1\17winhighlight7Normal:TelescopeNormal,FloatBorder:TelescopeBorder\16buf_options\14min_width\1\3\0\0\3\20\4ö≥ÊÃ\tô≥¶˛\3\14max_width\1\3\0\0\3å\1\4Õô≥Ê\fÃô≥ˇ\3\1\0\t\16insert_only\2\rrelative\vcursor\20start_in_insert\2\19default_prompt\vInput:\17prefer_width\3(\17prompt_align\tleft\vanchor\aSW\vborder\frounded\fenabled\2\nsetup\rdressing\frequire\0", "config", "dressing.nvim")
time([[Config for dressing.nvim]], false)
-- Config for: vim-illuminate
time([[Config for vim-illuminate]], true)
try_loadstring("\27LJ\2\nÍ\3\0\0\4\0\14\0\0236\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0024\3\0\0=\3\6\0025\3\a\0=\3\b\0024\3\0\0=\3\t\0024\3\0\0=\3\n\0024\3\0\0=\3\v\0024\3\0\0=\3\f\0024\3\0\0=\3\r\2B\0\2\1K\0\1\0%providers_regex_syntax_allowlist$providers_regex_syntax_denylist\20modes_allowlist\19modes_denylist\24filetypes_allowlist\23filetypes_denylist\1\16\0\0\fdirvish\rfugitive\fdirvish\rfugitive\nalpha\rNvimTree\tlazy\17neogitstatus\fTrouble\blir\fOutline\18spectre_panel\15toggleterm\19DressingSelect\20TelescopePrompt\23filetype_overrides\14providers\1\0\2\ndelay\3¨\2\17under_cursor\2\1\4\0\0\blsp\15treesitter\nregex\14configure\15illuminate\frequire\0", "config", "vim-illuminate")
time([[Config for vim-illuminate]], false)
-- Config for: indent-blankline.nvim
time([[Config for indent-blankline.nvim]], true)
try_loadstring("\27LJ\2\nî\4\0\0\4\0\b\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\0025\3\6\0=\3\a\2B\0\2\1K\0\1\0\21filetype_exclude\1\16\0\0\ndbout\19neo-tree-popup\blog\14gitcommit\btxt\thelp\rNvimTree\bgit\24flutterToolsOutline\rundotree\rmarkdown\tnorg\borg\14orgagenda\5\20buftype_exclude\1\4\0\0\rterminal\14telescope\vnofile\1\0\f\21show_end_of_line\1\18char_priority\3\f\18show_foldtext\1\tchar\b‚îÇ/show_current_context_start_on_current_line\1\28show_first_indent_level\2\31show_current_context_start\2\25space_char_blankline\6 \17context_char\b‚îÇ\25show_current_context\2\19use_treesitter\2#show_trailing_blankline_indent\1\nsetup\21indent_blankline\frequire\0", "config", "indent-blankline.nvim")
time([[Config for indent-blankline.nvim]], false)
-- Config for: null-ls.nvim
time([[Config for null-ls.nvim]], true)
try_loadstring("\27LJ\2\nz\0\0\5\0\b\0\f6\0\0\0009\0\1\0009\0\2\0009\0\3\0005\2\6\0006\3\0\0009\3\4\0039\3\5\3B\3\1\2=\3\a\2B\0\2\1K\0\1\0\nbufnr\1\0\1\15timeout_ms\3∏\23\25nvim_get_current_buf\bapi\vformat\bbuf\blsp\bvim§\1\1\2\b\0\n\0\0159\2\0\0'\4\1\0B\2\2\2\15\0\2\0X\3\tÄ6\2\2\0009\2\3\0029\2\4\2'\4\5\0'\5\6\0003\6\a\0005\a\b\0=\1\t\aB\2\5\1K\0\1\0\vbuffer\1\0\1\tdesc\17[lsp] format\0\15<Leader>ff\6n\bset\vkeymap\bvim\28textDocument/formatting\20supports_methodÂ\4\1\0\r\0!\2?6\0\0\0'\2\1\0B\0\2\0029\1\2\0009\2\3\0005\4\29\0004\5\14\0009\6\4\0019\6\5\0069\6\6\0065\b\f\0005\t\a\0006\n\b\0009\n\t\n9\n\n\n'\f\v\0B\n\2\0?\n\0\0=\t\r\bB\6\2\2>\6\1\0059\6\4\0019\6\14\6>\6\2\0059\6\4\0019\6\15\6>\6\3\0059\6\4\0019\6\16\6>\6\4\0059\6\4\0019\6\17\6>\6\5\0059\6\4\0019\6\18\6>\6\6\0059\6\4\0019\6\19\6>\6\a\0059\6\20\0019\6\21\6>\6\b\0059\6\20\0019\6\22\6>\6\t\0059\6\20\0019\6\23\6>\6\n\0059\6\24\0019\6\25\6>\6\v\0059\6\26\0019\6\27\6>\6\f\0056\6\0\0'\b\28\0B\6\2\0?\6\1\0=\5\30\0043\5\31\0=\5 \4B\2\2\1K\0\1\0\14on_attach\0\fsources\1\0\0/typescript.extensions.null-ls.code-actions\reslint_d\17code_actions\fluasnip\15completion\ryamllint\truff\tfish\16diagnostics\16fish_indent\16dart_format\fyamlfmt\ffixjson\14prettierd\nblack\15extra_args\1\0\0005~/.config/nvim/lua/lsp/linter-config/stylua.toml\vexpand\afn\bvim\1\2\0\0\18--config-path\twith\vstylua\15formatting\nsetup\rbuiltins\fnull-ls\frequire\5ÄÄ¿ô\4\27ÄÄ¿ô\4\0", "config", "null-ls.nvim")
time([[Config for null-ls.nvim]], false)
-- Config for: lsp_signature.nvim
time([[Config for lsp_signature.nvim]], true)
try_loadstring("\27LJ\2\nÄ\4\0\0\4\0\a\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\0024\3\0\0=\3\6\2B\0\2\1K\0\1\0\24extra_trigger_chars\17handler_opts\1\0\1\vborder\frounded\1\0\23\26floating_window_off_x\3\1\26floating_window_off_y\3\0\18close_timeout\3†\31\ffix_pos\1\16hint_enable\1\twrap\2\16hint_prefix\nüêº \17shadow_blend\3$\16hint_scheme\vString\17hi_parameter LspSignatureActiveParameter\19always_trigger\1\17transparency\3d\17shadow_guibg\nBlack\19timer_interval\3»\1\nnoice\2\15toggle_key\n<A-q>\tbind\1\15max_height\3\f\14max_width\3P\fpadding\5\14doc_lines\3\n\20floating_window\1#floating_window_above_cur_line\2\nsetup\18lsp_signature\frequire\0", "config", "lsp_signature.nvim")
time([[Config for lsp_signature.nvim]], false)
-- Config for: nvim-notify
time([[Config for nvim-notify]], true)
try_loadstring("\27LJ\2\n·\2\0\0\a\0\19\0\0276\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0029\2\3\0005\4\4\0005\5\a\0009\6\5\0019\6\6\6=\6\b\0059\6\5\0019\6\t\6=\6\n\0059\6\5\0019\6\v\6=\6\f\0059\6\r\0019\6\14\6=\6\15\0059\6\r\0019\6\16\6=\6\17\5=\5\18\4B\2\2\1K\0\1\0\nicons\nTRACE\vPencil\nDEBUG\bBug\aui\tINFO\16Information\tWARN\fWarning\nERROR\1\0\0\nError\16diagnostics\1\0\b\nlevel\3\2\ftimeout\3–\15\rtop_down\2\14max_width\3x\vrender\fdefault\22background_colour\f#121212\vstages\22fade_in_slide_out\bfpg\3\30\nsetup\16utils.icons\vnotify\frequire\0", "config", "nvim-notify")
time([[Config for nvim-notify]], false)
-- Config for: tabhula.nvim
time([[Config for tabhula.nvim]], true)
try_loadstring("\27LJ\2\n\15\0\1\2\0\0\0\2)\1\1\0L\1\2\0æ\2\1\0\5\0\21\0$3\0\0\0006\1\1\0'\3\2\0B\1\2\0029\1\3\0015\3\4\0005\4\5\0=\0\6\4=\0\a\4=\0\b\4=\0\t\4=\0\n\4=\0\v\4=\0\f\4=\0\r\4=\0\14\4=\0\15\4=\0\16\4=\0\17\4=\4\18\0035\4\19\0=\0\6\4=\0\a\4=\0\b\4=\0\t\4=\0\n\4=\0\v\4=\0\f\4=\0\r\4=\0\14\4=\0\15\4=\0\16\4=\0\17\4=\4\20\3B\1\2\1K\0\1\0\24backward_characters\1\0\0\23forward_characters\6`\6'\6\"\6;\6.\6,\6{\6}\6[\6]\6(\6)\1\0\0\1\0\4\25evil_backward_tabkey\5\vtabkey\n<Tab>\20backward_tabkey\f<S-Tab>\16evil_tabkey\5\nsetup\ftabhula\frequire\0\0", "config", "tabhula.nvim")
time([[Config for tabhula.nvim]], false)
-- Config for: lsp-colors.nvim
time([[Config for lsp-colors.nvim]], true)
try_loadstring("\27LJ\2\n~\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\4\tHint\f#10B981\16Information\f#0db9d7\fWarning\f#e0af68\nError\f#db4b4b\nsetup\15lsp-colors\frequire\0", "config", "lsp-colors.nvim")
time([[Config for lsp-colors.nvim]], false)
-- Config for: LuaSnip
time([[Config for LuaSnip]], true)
try_loadstring("\27LJ\2\né\1\0\1\3\1\5\0\20-\1\0\0009\1\0\1\15\0\1\0X\2\15Ä-\1\0\0009\1\0\0019\1\1\0019\2\2\0008\1\2\1\15\0\1\0X\2\bÄ-\1\0\0009\1\0\0019\1\3\1\14\0\1\0X\1\3Ä-\1\0\0009\1\4\1B\1\1\1K\0\1\0\0¿\19unlink_current\16jump_active\bbuf\18current_nodes\fsession™\4\1\0\a\0\25\0'6\0\0\0'\2\1\0B\0\2\0026\1\2\0009\1\3\0019\1\4\1'\3\5\0005\4\6\0B\1\3\0026\2\2\0009\2\3\0029\2\a\2'\4\b\0005\5\t\0=\1\n\0055\6\v\0=\6\f\0053\6\r\0=\6\14\5B\2\3\0019\2\15\0'\4\16\0005\5\17\0B\2\3\0019\2\15\0'\4\18\0005\5\19\0B\2\3\0016\2\0\0'\4\20\0B\2\2\0029\2\21\2B\2\1\0019\2\22\0009\2\23\0025\4\24\0B\2\2\0012\0\0ÄK\0\1\0\1\0\1\24region_check_events\16CursorMoved\15set_config\vconfig\14lazy_load luasnip.loaders.from_vscode\1\3\0\0\thtml\15javascript\20javascriptreact\1\3\0\0\thtml\15typescript\20typescriptreact\20filetype_extend\rcallback\0\fpattern\1\3\0\0\bs:n\bi:*\ngroup\1\0\1\tdesc<Forget the current snippet when leaving the insert mode\16ModeChanged\24nvim_create_autocmd\1\0\1\nclear\2\30UnlinkSnippetOnModeChange\24nvim_create_augroup\bapi\bvim\fluasnip\frequire\0", "config", "LuaSnip")
time([[Config for LuaSnip]], false)
-- Config for: stay-in-place.nvim
time([[Config for stay-in-place.nvim]], true)
try_loadstring("\27LJ\2\nO\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\16set_keymaps\1\nsetup\18stay-in-place\frequire\0", "config", "stay-in-place.nvim")
time([[Config for stay-in-place.nvim]], false)

-- Command lazy-loads
time([[Defining lazy-load commands]], true)
pcall(vim.api.nvim_create_user_command, 'TermOpen', function(cmdargs)
          require('packer.load')({'toggleterm.nvim'}, { cmd = 'TermOpen', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'toggleterm.nvim'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('TermOpen ', 'cmdline')
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
vim.cmd [[au LspAttach * ++once lua require("packer.load")({'lspsaga.nvim'}, { event = "LspAttach *" }, _G.packer_plugins)]]
vim.cmd [[au InsertEnter * ++once lua require("packer.load")({'nvim-autopairs'}, { event = "InsertEnter *" }, _G.packer_plugins)]]
vim.cmd [[au BufReadPre * ++once lua require("packer.load")({'bufferline.nvim', 'marks.nvim', 'lualine.nvim', 'gitsigns.nvim'}, { event = "BufReadPre *" }, _G.packer_plugins)]]
vim.cmd [[au VimEnter * ++once lua require("packer.load")({'telescope.nvim', 'noice.nvim'}, { event = "VimEnter *" }, _G.packer_plugins)]]
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
