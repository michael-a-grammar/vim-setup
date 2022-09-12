return function(opts)
  local api = vim.api
  local g   = vim.g

  -- Default - asdghklqwertyuiopzxcvbnmfj;
  g.EasyMotion_keys             = 'ARSTGQWFPMIOLUYNE;'
  g.EasyMotion_do_mapping       = false
  g.EasyMotion_smartcase        = true
  g.EasyMotion_use_smartsign_us = true
  g.EasyMotion_use_upper        = true
  g.EasyMotion_enter_jump_first = true
  g.EasyMotion_space_jump_first = true
  g.EasyMotion_inc_highlight    = true
  g.EasyMotion_move_highlight   = true
  g.EasyMotion_verbose          = true

  local set_hl_link = function(name, link)
    api.nvim_set_hl(0, name, {})
    api.nvim_set_hl(0, name, { link = link, default = true })
  end

  if opts.use_theme.dracula then
    set_hl_link('EasyMotionTarget',        'DraculaOrange')
    set_hl_link('EasyMotionTarget2First',  'DraculaGreen')
    set_hl_link('EasyMotionTarget2Second', 'DraculaCyan')
  elseif opts.use_theme.tender then
    set_hl_link('EasyMotionTarget',        'Operator')
    set_hl_link('EasyMotionTarget2First',  'Character')
    set_hl_link('EasyMotionTarget2Second', 'Character')
  else
    set_hl_link('EasyMotionTarget',        'Type')
    set_hl_link('EasyMotionTarget2First',  'Title')
    set_hl_link('EasyMotionTarget2Second', 'Title')
  end

  set_hl_link('EasyMotionShade',     'Comment')
  set_hl_link('EasyMotionMoveHL',    'Search')
  set_hl_link('EasyMotionIncSearch', 'Search')
end
