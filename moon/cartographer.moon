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

class State
  new: =>
    @idx = 1
  
  update: (key, val) =>
   print key, val

cartographer = (fn) ->
  state = State!
  setfenv fn, setmetatable {},
    __index: (self, key) ->
      (val) ->
        print key, val
        state\update(key, val)
  fn!

--map = keymap nx leader ctrl t name: 'Buffers'

cartographer ->
  nx leader ctrl t name: 'Buffers', silent: true
