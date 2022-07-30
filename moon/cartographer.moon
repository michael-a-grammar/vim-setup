setfenv = (fn, env) ->
  i = 1
  while debug.getupvalue(fn, i) != '_ENV' do i += 1
  debug.upvaluejoin fn, i, (-> env), 1
  fn

opts = {}

get = (key, val) ->
  switch type(val)
    when 'function'
      return val()
    when 'table'
      opts = val
      return key
    when 'nil'
      return key
    else
      "#{key}__#{val}"

mt =
  use: (val) ->
    print val
  add: (val) ->
    print val

kc = setmetatable {},
    __index: (tbl, key) ->
      (val) -> key

cartographer = (fn) ->
  setfenv fn, setmetatable mt,
    __index: (tbl, key) ->
      (val) -> get key, val
  fn!

--map = keymap nx leader ctrl t name: 'Buffers'

--cartographer ->
  --use nx leader ctrl t name: 'Buffers', silent: true


--cartographer ->
  --use nx leader kc['?'] ctrl kc['/'] name: 'Buffers', silent: true

--cartographer ->
  --use nx leader kc['#'] ctrl kc['0']

cartographer ->
  use nx leader kc['£'] ctrl z
