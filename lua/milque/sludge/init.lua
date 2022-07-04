local fn     = vim.fn
local opt    = vim.opt
local neon   = require'neon'
local cmd    = neon.cmd
local sludge = {}

local function get_slime_bufname(buf_prefix, ft)
  return buf_prefix .. '_slime.' .. ft
end

local function get_slime_state(buf_prefix, ft)
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

local function create_slime_win(slime_bufnr)
  local height       = opt.lines:get()
  local slime_height = height / 4
  local split_cmd    = 'split' .. '+buffer' .. slime_bufnr
  local resize_cmd   = 'resize' .. slime_height

  local function set_opt(name, val)
    vim.wo[name] = val
  end

  cmd(split_cmd)
  cmd(resize_cmd)

  set_opt('list', 0)
  set_opt('number', false)
  set_opt('relativenumber', false)
end

local function select_slime_win(slime_winnr)
  cmd(slime_winnr .. 'wincmd w')
end

local function create_slime_buf(slime_bufname, ft)
  local slime_bufnr = fn.bufadd(slime_bufname)

  local function set_opt(name, val)
    vim.bo[slime_bufnr][name] = val
  end

  set_opt('bufhidden', 'hide')
  set_opt('buflisted', false)
  set_opt('filetype', ft)
  set_opt('modeline', false)
  set_opt('swapfile', false)

  return slime_bufnr
end

function sludge.start(buf_prefix, ft, slime_key)
  local state       = get_slime_state(buf_prefix, ft)
  local slime_bufnr = state.slime_bufnr

  if state.slime_selected then
    neon.leader(slime_key)
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

return sludge
