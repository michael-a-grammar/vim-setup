local fn           = vim.fn
local split        = vim.split
local neon         = require'milque.neon'
local cmd          = neon.cmd
local exe          = neon.exe
local nine_to_five = {}

local function get_bufdir()
  return fn.expand('%:h')
end

local function set_wd(scope, dir)
  cmd(scope .. 'cd ' .. dir)
  return exe('verbose pwd')
end

local function set_wd_bufdir(scope)
  return set_wd(scope, get_bufdir())
end

local function set_wd_prev(scope)
  return set_wd(scope, '-')
end

function nine_to_five.get_all_wds()
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

function nine_to_five.set_g_wd_bufdir()
  return set_wd_bufdir('')
end

function nine_to_five.set_g_wd_prev()
  return set_wd_prev('')
end

function nine_to_five.set_t_wd_bufdir()
  return set_wd_bufdir('t')
end

function nine_to_five.set_t_wd_prev()
  return set_wd_prev('t')
end

function nine_to_five.set_w_wd_bufdir()
  return set_wd_bufdir('l')
end

function nine_to_five.set_w_wd_prev()
  return set_wd_prev('l')
end

return nine_to_five
