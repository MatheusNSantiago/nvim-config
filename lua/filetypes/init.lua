local settings = utils.ft_helpers.filetype_settings

settings({
  python = require('filetypes.python'),
  [{ 'typescript', 'javascript' }] = require('filetypes.js'),
})

create_picker('<leader><leader>u', '*', 'Utilities', {
  { name = 'Color Picker', handler = ':CccPick<CR>' },
  { name = 'Icon Picker',  handler = ':IconPickerNormal<CR>' },
})
