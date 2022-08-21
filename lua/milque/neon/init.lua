local api  = vim.api
local g    = vim.g
local neon = {}

neon.cmd = function(src)
  api.nvim_exec(src, false)
  return neon
end

neon.exe = function(src)
  return api.nvim_exec(src, true)
end

neon.i = function(val)
  print(vim.inspect(val))
  return neon
end

neon.t = function(str)
  return api.nvim_replace_termcodes(str, true, true, true)
end

neon.leader = function(suffix)
  local leader = g.mapleader

  if leader == ' ' then
    leader = '1' .. leader
  end

  return neon.cmd('normal ' .. leader .. suffix)
end

return neon
