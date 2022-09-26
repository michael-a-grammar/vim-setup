local exec  = vim.api.nvim_exec
local fn    = vim.fn
local split = vim.split
local M     = {}

local get_bufdir = function()
  return fn.expand('%:h')
end

local set_wd = function(scope, dir)
  exec(scope .. 'cd ' .. dir, false)
  return exec('verbose pwd', true)
end

local set_wd_bufdir = function(scope)
  return set_wd(scope, get_bufdir())
end

local set_wd_prev = function(scope)
  return set_wd(scope, '-')
end

M.get_all_wds = function()
  local tabpagenr = fn.tabpagenr()
  local winnr     = fn.winnr()
  local dirs      = {}

  local pwds =
    split(
      exec('tabdo windo verbose pwd', true),
    '\n')

  for _, pwd in ipairs(pwds) do
    local wd    = split(pwd, ' ')
    local scope = wd[1]:gsub('[^%w]', '')

    table.insert(dirs, {
      wd    = wd[2],
      scope = scope
    })
  end

  me.cmd('tabnext' .. tabpagenr)
  me.cmd(winnr .. 'wincmd w')

  return dirs
end

local scopes = {
  { 'g', ''  },
  { 't', 't' },
  { 'w', 'l' }
}

for scope_name, scope in pairs(scopes) do
  local prefix = 'set_' .. scope_name .. '_wd_'

  M[prefix .. 'bufdir'] = function()
    return set_wd_bufdir(scope)
  end

  M[prefix .. 'prev'] = function()
    return set_wd_prev(scope)
  end
end

return M
