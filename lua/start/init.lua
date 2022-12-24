local g = vim.g

if elden == nil or g.elden == nil then
  _G.elden = {}
  g.elden  = _G.elden
end

require'start.opts'
require'start.globals'
