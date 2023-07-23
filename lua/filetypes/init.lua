local settings = utils.ft_helpers.filetype_settings

settings({
  python = require('filetypes.python'),
  [{"typescript", "javascript"}] = require('filetypes.js')
})
