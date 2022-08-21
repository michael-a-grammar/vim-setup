local fn           = vim.fn
local split        = vim.split
local neon         = require'milque.neon'
local cmd          = neon.cmd
local exe          = neon.exe
local nine_to_five = {}

local get_bufdir = function()
  return fn.expand('%:h')
end

local set_wd = function(scope, dir)
  cmd(scope .. 'cd ' .. dir)
  return exe('verbose pwd')
end

local set_wd_bufdir = function(scope)
  return set_wd(scope, get_bufdir())
end

local set_wd_prev = function(scope)
  return set_wd(scope, '-')
end

nine_to_five.get_all_wds = function()
  local tabpagenr = fn.tabpagenr()
  local winnr     = fn.winnr()
  local dirs      = {}

  local pwds =
  split(exe('tabdo windo verbose pwd'), '\n')

  for _, pwd in ipairs(pwds) do
    local wd    = split(pwd, ' ')
    local scope = wd[1]:gsub('[^%w]', '')

    table.insert(dirs, {
      wd    = wd[2],
      scope = scope
    })
  end

  cmd('tabnext' .. tabpagenr)
  cmd(winnr .. 'wincmd w')

  return dirs
end

local scopes = {
  { 'g', ''  },
  { 't', 't' },
  { 'w', 'l' }
}

nine_to_five.set_g_wd_bufdir = function()
  return set_wd_bufdir('')
end

nine_to_five.set_g_wd_prev = function()
  return set_wd_prev('')
end

nine_to_five.set_t_wd_bufdir = function()
  return set_wd_bufdir('t')
end

nine_to_five.set_t_wd_prev = function()
  return set_wd_prev('t')
end

nine_to_five.set_w_wd_bufdir = function()
  return set_wd_bufdir('l')
end

nine_to_five.set_w_wd_prev = function()
  return set_wd_prev('l')
end

return nine_to_five
