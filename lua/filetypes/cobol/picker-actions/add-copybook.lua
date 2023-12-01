local quick_add = require('filetypes.cobol.quick-add')
local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local conf = require('telescope.config').values
local dropdown = require('telescope.themes').get_dropdown
local t_actions = require('telescope.actions')
local action_state = require('telescope.actions.state')
local M = {}

function M.copy_book_dropdown()
  local function entry_maker(option)
    return {
      value = option,
      name = option.name,
      ordinal = option.name,
      display = option.name,
    }
  end

  pickers
      .new(dropdown({}), {
        prompt_title = 'Adicionar Copybook',
        finder = finders.new_table({
          results = M.get_all_copybooks(),
          entry_maker = entry_maker,
        }),
        sorter = conf.generic_sorter(),
        attach_mappings = function(telescope_buf, _)
          local copybook

          t_actions.select_default:replace(function()
            local selected_entry = action_state.get_selected_entry()
            local entry = selected_entry.value

            copybook = entry.name
            t_actions.close(telescope_buf)
          end)
          t_actions.close:enhance({
            post = function(_)
              if copybook then
                quick_add.working_storage.add_book(copybook)
              end
            end,
          })
          return true
        end,
      })
      :find()
end

--  ╾───────────────────────────────────────────────────────────────────────────────────╼
--  ╾───────────────────────────────────────────────────────────────────────────────────╼

function M.get_all_copybooks()
  local copybook_folder = M.get_copybook_dir()

  local files = Array(vim.fn.readdir(copybook_folder))
  local file_paths = files:map(function(file) return copybook_folder .. '/' .. file end)

  return file_paths:map(function(path)
    local is_copybook = path:match('%.cpy$')
    if is_copybook then
      local name = vim.fn.fnamemodify(path, ':t:r')
      local entry = { name = name, path = path }
      return entry
    end
  end)
end

function M.get_copybook_dir()
  local path = vim.fn.expand('%:p')
  while path ~= '/' do
    local parent_dir_path = vim.fn.fnamemodify(path, ':h')
    local parent_dir_files = Array(vim.fn.readdir(parent_dir_path))

    if parent_dir_files:contains('copybook') then --
      return parent_dir_path .. '/copybook'
    end

    path = parent_dir_path
  end

  return path
end

return M.copy_book_dropdown
