vim = {}
vim.split = (str, on) ->
  result = {}
  for match in ("#{str}#{on}")\gmatch("(.-)#{on}")
    table.insert(result, match)
  result

setfenv = (fn, env) ->
  i = 1
  while debug.getupvalue(fn, i) != '_ENV' do i += 1
  debug.upvaluejoin fn, i, (-> env), 1
  fn

opts = {}

create_segment = (key, val) ->
  switch type(val)
    when 'table'
      opts = val
      return key
    when 'nil'
      return key
    when 'string'
      if key == 'kc'
        return (agg) -> create_segment val, agg
      "#{key}__#{val}"

r = {}

cur_use = {
  
}

modes = do
  tbl = {}
  for key in *{'n', 'v', 's', 'x', 'o', 'i', 'l', 'c', 't'}
    tbl[key] = key
  for key, val in *{'nvo': ' ', 'ic': '!'}
    tbl[key] = val
  tbl

get_modes = (segment) ->
  tbl = {}
  segment\gsub '.', (char) ->
    unless modes[char] == nil
      table.insert tbl, modes[char]
  tbl

keymap =
  use: (val) ->
    segments = vim.split(val, '__')
    our_modes = get_modes(segments[1])
    --for seg in *segments do print seg
    for mode in *our_modes do print mode
    table.insert(r, val)
  add: (val) ->

mt =
  __index: (_, key) ->
    return nil if key == '_'
    (val) -> create_segment key, val

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
