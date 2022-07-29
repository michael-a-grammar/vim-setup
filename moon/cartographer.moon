nx = 'nx'
leader = (key) -> "<leader>#{key}"
ctrl = (key) -> "<c-#{key}"
t = 't'

setfenv = (fn, env) ->
  i = 1
  while true do
    name = debug.getupvalue fn, i
    if name == '_ENV'
      debug.upvaluejoin fn, i, (-> env), 1
      break
    elseif not name
      break
  fn

cartographer = (fn) ->
  setfenv fn, setmetable {},
    __index: (self, key) ->
      -> print 2
  fn!


map = keymap nx leader ctrl t name: 'Buffers'
