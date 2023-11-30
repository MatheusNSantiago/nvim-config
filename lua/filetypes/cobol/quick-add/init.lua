local ws = require('filetypes.cobol.quick-add.working-storage')
local section = require('filetypes.cobol.quick-add.section')

return {
  add_pic_under_cursor = ws.add_pic_under_cursor,
  add_section = section.add_section,
  working_storage = ws,
}
