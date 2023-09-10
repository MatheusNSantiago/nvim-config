local settings = utils.ft_helpers.filetype_settings

settings({
  python = require('filetypes.python'),
  [{ 'typescript', 'typescriptreact', 'javascript', 'javascriptreact' }] = require('filetypes.js'),
  c = require('filetypes.c'),
})

create_picker('<leader><leader>u', 'Utilities', {
  { name = 'Color Picker', handler = ':CccPick<CR>' },
  { name = 'Icon Picker',  handler = ':IconPickerNormal<CR>' },
})
