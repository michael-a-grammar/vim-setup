local exec = vim.api.nvim_exec
local bo   = vim.bo
local fn   = vim.fn
local opt  = vim.opt
local wo   = vim.wo
local M    = {}

local get_slime_bufname = function(buf_prefix, ft)
  return buf_prefix .. '_slime.' .. ft
end

local get_slime_state = function(buf_prefix, ft)
  local state   = {}
  local bufname = fn.bufname()

  local slime_bufname = get_slime_bufname(buf_prefix, ft)
  local slime_bufnr   = fn.bufnr(slime_bufname)
  local slime_winnr   = fn.bufwinnr(slime_bufnr)

  state.slime_bufnr    = slime_bufnr
  state.slime_selected = slime_bufname == bufname
  state.has_slime_buf  = slime_bufnr > -1
  state.slime_winnr    = slime_winnr
  state.has_slime_win  = slime_winnr > -1
  state.slime_bufname  = slime_bufname

  return state
end

local create_slime_win = function(slime_bufnr)
  local height       = opt.lines:get()
  local slime_height = height / 4
  local split_cmd    = 'split' .. '+buffer' .. slime_bufnr
  local resize_cmd   = 'resize' .. slime_height

  local set_opt = function(name, val)
    wo[name] = val
  end

  exec(split_cmd, false)
  exec(resize_cmd, false)

  set_opt('list', false)
  set_opt('number', false)
  set_opt('relativenumber', false)
end

local select_slime_win = function(slime_winnr)
  exec(slime_winnr .. 'wincmd w', false)
end

local create_slime_buf = function(slime_bufname, ft)
  local slime_bufnr = fn.bufadd(slime_bufname)

  local set_opt = function(name, val)
    bo[slime_bufnr][name] = val
  end

  set_opt('bufhidden', 'hide')
  set_opt('buflisted', false)
  set_opt('filetype', ft)
  set_opt('modeline', false)
  set_opt('swapfile', false)

  return slime_bufnr
end

M.start = function(buf_prefix, ft, slime_fn)
  local state       = get_slime_state(buf_prefix, ft)
  local slime_bufnr = state.slime_bufnr

  if state.slime_selected then
    slime_fn()
  end

  if not state.has_slime_buf then
    slime_bufnr = create_slime_buf(state.slime_bufname, ft)
  end

  if state.has_slime_win then
    select_slime_win(state.slime_winnr)
  else
    create_slime_win(slime_bufnr)
  end
end

return M
