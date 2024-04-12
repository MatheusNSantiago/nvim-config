---@diagnostic disable: missing-fields

local cobol_bundle_ok, cobol_bundle = pcall(require, 'cobol-bundle')
if not cobol_bundle_ok then cobol_bundle = {} end

local cobol_foo_ok, cobol_foo = pcall(require, 'cobol-foo')
if not cobol_foo_ok then cobol_foo = {} end

utils.ft_helpers.filetype_settings({
  ['python'] = require('filetypes.python'),
  [{ 'typescript', 'typescriptreact', 'javascript', 'javascriptreact' }] = require('filetypes.js'),
  ['c'] = require('filetypes.c'),
  ['cobol'] = cobol_bundle.cobol_config,
  ['copybook'] = cobol_bundle.copybook_config,
  ['foo'] = cobol_foo,
})

create_picker('<leader><leader>u', 'Utilities', {
  { name = 'Icon Picker', handler = ':IconPickerNormal<CR>' },
})
