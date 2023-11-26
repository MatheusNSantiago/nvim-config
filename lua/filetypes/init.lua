---@diagnostic disable: missing-fields

utils.ft_helpers.filetype_settings({
  ['python'] = require('filetypes.python'),
  [{ 'typescript', 'typescriptreact', 'javascript', 'javascriptreact' }] = require('filetypes.js'),
  ['c'] = require('filetypes.c'),
  ['cobol'] = require('filetypes.cobol'),
})

create_picker('<leader><leader>u', 'Utilities', {
  { name = 'Color Picker', handler = ':CccPick<CR>' },
  { name = 'Icon Picker',  handler = ':IconPickerNormal<CR>' },
})
