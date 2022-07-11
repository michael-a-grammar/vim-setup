local api  = vim.api
local g    = vim.g
local neon = {}

function neon.cmd(src)
  api.nvim_exec(src, false)
  return neon
end

function neon.exe(src)
  return api.nvim_exec(src, true)
end

function neon.i(val)
  print(vim.inspect(val))
  return neon
end

function neon.t(str)
  return api.nvim_replace_termcodes(str, true, true, true)
end

function neon.leader(suffix)
  local leader = g.mapleader

  if leader == ' ' then
    leader = '1' .. leader
  end

  return neon.cmd('normal ' .. leader .. suffix)
end

return neon
