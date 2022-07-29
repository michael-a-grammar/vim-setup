--nx = 'nx'
--leader = (key) -> "<leader>#{key}"
--ctrl = (key) -> "<c-#{key}"
--t = 't'

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

mapper =
  keymap: (opts) ->
    print opts

cartographer = (fn) ->
  setfenv fn, setmetatable mapper,
    __index: (self, key) ->
      print key
      -> key
  fn!

--map = keymap nx leader ctrl t name: 'Buffers'

cartographer ->
 keymap nx
