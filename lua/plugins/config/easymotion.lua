return function()
  local api  = vim.api
  local g    = vim.g
  local map  = require'bundled.cartographer'.map

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

  if E.colorscheme == 'dracula' then
    set_hl_link('EasyMotionTarget',        'DraculaOrange')
    set_hl_link('EasyMotionTarget2First',  'DraculaGreen')
    set_hl_link('EasyMotionTarget2Second', 'DraculaCyan')
  elseif E.colorscheme == 'tender' then
    set_hl_link('EasyMotionTarget',        'Operator')
    set_hl_link('EasyMotionTarget2Second', 'Character')
    set_hl_link('EasyMotionTarget2First',  'Character')
  end

  set_hl_link('EasyMotionTarget',        'Type')
  set_hl_link('EasyMotionTarget2First',  'Title')
  set_hl_link('EasyMotionTarget2Second', 'Title')

  set_hl_link('EasyMotionShade',     'Comment')
  set_hl_link('EasyMotionMoveHL',    'Search')
  set_hl_link('EasyMotionIncSearch', 'Search')

  map(function()
    nvo {
      --',', plug('easymotion-prefix'), 'EasyMotion'
    }

    nvo_with ',' {
      '/', plug('easymotion-sn'),   'Search',
      'n', plug('easymotion-next'), 'Next result',
      'N', plug('easymotion-prev'), 'Previous result',

      'a', plug('easymotion-lineanywhere'),   'Line anywhere',
      'A', plug('easymotion-jumptoanywhere'), 'Jump to anywhere',

      'f', plug('easymotion-bd-f'),  'Find char forward',
      'F', plug('easymotion-bd-fl'), 'Find char bidirectional',

      't', plug('easymotion-bd-t'),  'Til char forward',
      'T', plug('easymotion-bd-tl'), 'Til char bidirectional',

      up,    plug('easymotion-k'),            'Jump to line upwards',
      right, plug('easymotion-lineforward'),  'Jump word forward',
      down,  plug('easymotion-j'),            'Jump to line downwards',
      left,  plug('easymotion-linebackward'), 'Jump word backwards',

      'sf', plug('easymotion-overwin-f'),    'Over-window find char',
      'sF', plug('easymotion-overwin-f2'),   'Over-window find char (2)',
      'sl', plug('easymotion-overwin-line'), 'Over-window jump to line',
      'ss', plug('easymotion-s2'),           'Sneak (2)',
      'sw', plug('easymotion-overwin-w'),    'Over-window jump to word'
    }
  end)
end
