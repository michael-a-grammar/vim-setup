return function(opts)
  if opts.use.easymotion then
    local api = vim.api
    local g   = vim.g

    -- Default - asdghklqwertyuiopzxcvbnmfj;
    g.EasyMotion_keys             = 'ARSTGQWFPMIOLUYNE;'
    g.EasyMotion_do_mapping       = 0
    g.EasyMotion_smartcase        = 1
    g.EasyMotion_use_smartsign_us = 1
    g.EasyMotion_use_upper        = 1
    g.EasyMotion_enter_jump_first = 1
    g.EasyMotion_space_jump_first = 1
    g.EasyMotion_inc_highlight    = 1
    g.EasyMotion_move_highlight   = 1
    g.EasyMotion_verbose          = 1

    local function set_hl_link(name, link)
      api.nvim_set_hl(0, name, { link = link })
    end

    if opts.use.dracula then
      set_hl_link('EasyMotionTarget',        'DraculaOrange')
      set_hl_link('EasyMotionTarget2First',  'DraculaGreen')
      set_hl_link('EasyMotionTarget2Second', 'DraculaGreen')
    elseif opts.use.tender then
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
end
