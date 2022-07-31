setfenv = (fn, env) ->
  i = 1
  while debug.getupvalue(fn, i) != '_ENV' do i += 1
  debug.upvaluejoin fn, i, (-> env), 1
  fn

opts = {}

get = (key, val) ->
  switch type(val)
    when 'table'
      opts = val
      return key
    when 'nil'
      return key
    when 'string'
      if key == 'kc'
        return (agg) -> get val, agg
      "#{key}__#{val}"

r = {}

keymap =
  use: (val) -> table.insert(r, val)
  add: (val) ->

mt =
  __index: (_, key) ->
    return nil if key == '_'
    (val) -> get key, val

cartographer = (fn) ->
  setfenv fn, setmetatable keymap, mt
  fn!

cartographer ->
  use nx leader t!
  use nx leader t _
  use nx leader t
    name: 'Buffers'
    silent: true

  add t
    fn: -> print 1

  use nx leader ctrl t y! 
  use nx leader ctrl t y _
  use nx leader ctrl t y name: 'Tabs', slient: false

  use nx leader kc'?' ctrl kc'/'!
  use nx leader kc'?' ctrl kc'/' _
  use nx leader kc'?' ctrl kc'/' name: 'Maps'

  use nx kc'#' kc'0'!
  use nx kc'#' kc'0' _
  use nx kc'#' kc'0' name: 'Opts'

  use kc'{' nx alt kc'}' _

  use nx leader kc'!' _

  --use nx leader kc'#' ctrl kc'0'
  --use nx leader kc'£' ctrl z
  
tests = ->
  print r[1] == 'nx__leader__t'
  print r[2] == 'nx__leader__t'
  print r[3] == 'nx__leader__t'

  print r[4] == 'nx__leader__ctrl__t__y'
  print r[5] == 'nx__leader__ctrl__t__y'
  print r[6] == 'nx__leader__ctrl__t__y'

  print r[7] == 'nx__leader__?__ctrl__/'
  print r[8] == 'nx__leader__?__ctrl__/'
  print r[9] == 'nx__leader__?__ctrl__/'

  print r[10] == 'nx__#__0'
  print r[11] == 'nx__#__0'
  print r[12] == 'nx__#__0'

print r[14]
