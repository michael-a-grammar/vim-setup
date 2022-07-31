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
local get
get = function(key, val)
  local _exp_0 = type(val)
  if 'table' == _exp_0 then
    opts = val
    return key
  elseif 'nil' == _exp_0 then
    return key
  elseif 'string' == _exp_0 then
    if key == 'kc' then
      return function(agg)
        return get(val, agg)
      end
    end
    return tostring(key) .. "__" .. tostring(val)
  end
end
local r = { }
local keymap = {
  use = function(val)
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
      return get(key, val)
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
return print(r[14])
