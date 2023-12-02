local nui_ok, _ = pcall(require, 'nui')
if not nui_ok then return end

return {
  Input = require('utils.nui.input'),
}
