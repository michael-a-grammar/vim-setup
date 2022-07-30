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
  if 'function' == _exp_0 then
    return val()
  elseif 'table' == _exp_0 then
    opts = val
    return key
  elseif 'nil' == _exp_0 then
    return key
  else
    return tostring(key) .. "__" .. tostring(val)
  end
end
local mt = {
  use = function(val)
    return print(val)
  end,
  add = function(val)
    return print(val)
  end
}
local kc = setmetatable({ }, {
  __index = function(tbl, key)
    return function(val)
      return key
    end
  end
})
local cartographer
cartographer = function(fn)
  setfenv(fn, setmetatable(mt, {
    __index = function(tbl, key)
      return function(val)
        return get(key, val)
      end
    end
  }))
  return fn()
end
return cartographer(function()
  return use(nx(leader(kc['£'](ctrl(z)))))
end)
