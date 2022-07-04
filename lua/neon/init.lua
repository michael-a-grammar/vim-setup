local neon = {}

local v         = vim
local api       = v.api
local nvim_exec = api.nvim_exec

function neon.cmd(src)
  nvim_exec(src, false)
  return true
end

function neon.exe(src)
  return nvim_exec(src, true)
end

function neon.i(val)
  print(v.inspect(val))
end

function neon.t(str)
  return api.nvim_replace_termcodes(str, true, true, true)
end

return neon
