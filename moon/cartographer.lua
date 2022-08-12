local vim = { }
vim.split = function(str, on)
  local result = { }
  for match in (tostring(str) .. tostring(on)):gmatch("(.-)" .. tostring(on)) do
    table.insert(result, match)
  end
  return result
end
local setfenv
setfenv = function(fn, env)
  local i = 1
  while debug.getupvalue(fn, i) ~= '_ENV' do
    i = i + 1
  end
  debug.upvaluejoin(fn, i, (function()
    return env
  end), 1)
  return fn
end
local opts = { }
local create_segment
create_segment = function(key, val)
  local _exp_0 = type(val)
  if 'table' == _exp_0 then
    opts = val
    return key
  elseif 'nil' == _exp_0 then
    return key
  elseif 'string' == _exp_0 then
    if key == 'kc' then
      return function(agg)
        return create_segment(val, agg)
      end
    end
    return tostring(key) .. "__" .. tostring(val)
  end
end
local r = { }
local cur_use = { }
local modes
do
  local tbl = { }
  local _list_0 = {
    'n',
    'v',
    's',
    'x',
    'o',
    'i',
    'l',
    'c',
    't'
  }
  for _index_0 = 1, #_list_0 do
    local key = _list_0[_index_0]
    tbl[key] = key
  end
  local _list_1 = {
    ['nvo'] = ' ',
    ['ic'] = '!'
  }
  for _index_0 = 1, #_list_1 do
    local key, val = _list_1[_index_0]
    tbl[key] = val
  end
  modes = tbl
end
local get_modes
get_modes = function(segment)
  local tbl = { }
  return segment:gsub('.', function(char)
    if not (modes[char] == nil) then
      return table.insert(tbl, modes[char])
    end
  end)
end
local keymap = {
  use = function(val)
    local segments = vim.split(val)
    modes = get_modes(segments[1])
    print("here " .. tostring(modes))
    return table.insert(r, val)
  end,
  add = function(val) end
}
local mt = {
  __index = function(_, key)
    if key == '_' then
      return nil
    end
    return function(val)
      return create_segment(key, val)
    end
  end
}
local cartographer
cartographer = function(fn)
  setfenv(fn, setmetatable(keymap, mt))
  return fn()
end
cartographer(function()
  use(nx(leader(t())))
  use(nx(leader(t(_))))
  use(nx(leader(t({
    name = 'Buffers',
    silent = true
  }))))
  add(t({
    fn = function()
      return print(1)
    end
  }))
  use(nx(leader(ctrl(t(y())))))
  use(nx(leader(ctrl(t(y(_))))))
  use(nx(leader(ctrl(t(y({
    name = 'Tabs',
    slient = false
  }))))))
  use(nx(leader(kc('?')(ctrl(kc('/')())))))
  use(nx(leader(kc('?')(ctrl(kc('/')(_))))))
  use(nx(leader(kc('?')(ctrl(kc('/')({
    name = 'Maps'
  }))))))
  use(nx(kc('#')(kc('0')())))
  use(nx(kc('#')(kc('0')(_))))
  use(nx(kc('#')(kc('0')({
    name = 'Opts'
  }))))
  use(kc('{')(nx(alt(kc('}')(_)))))
  return use(nx(leader(kc('!')(_))))
end)
local tests
tests = function()
  print(r[1] == 'nx__leader__t')
  print(r[2] == 'nx__leader__t')
  print(r[3] == 'nx__leader__t')
  print(r[4] == 'nx__leader__ctrl__t__y')
  print(r[5] == 'nx__leader__ctrl__t__y')
  print(r[6] == 'nx__leader__ctrl__t__y')
  print(r[7] == 'nx__leader__?__ctrl__/')
  print(r[8] == 'nx__leader__?__ctrl__/')
  print(r[9] == 'nx__leader__?__ctrl__/')
  print(r[10] == 'nx__#__0')
  print(r[11] == 'nx__#__0')
  return print(r[12] == 'nx__#__0')
end
print(r[14])
return print(vim.split(r[7], '__')[5])
