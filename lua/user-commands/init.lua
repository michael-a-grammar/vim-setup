return function()
  local api          = vim.api
  local neon         = require'milque.neon'
  local nine_to_five = require'milque.nine-to-five'
  local sludge       = require'milque.sludge'
  local togs         = require'milque.togs'

  api.nvim_create_user_command('Leader',
  function(opts)
    neon.leader(opts.fargs[1])
  end, { nargs = 1 })

  api.nvim_create_user_command('GetAllWds', nine_to_five.get_all_wds, {})
  api.nvim_create_user_command('TgACD', togs.tg_autochdir, {})
  api.nvim_create_user_command('TgList', togs.tg_list, {})
  api.nvim_create_user_command('TgNU', togs.tg_number, {})
  api.nvim_create_user_command('TgRNU', togs.tg_relativenumber, {})
end
