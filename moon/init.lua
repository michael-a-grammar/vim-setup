local api, g, keymap, opt
do
  local _obj_0 = vim
  api, g, keymap, opt = _obj_0.api, _obj_0.g, _obj_0.keymap, _obj_0.opt
end
local opts = {
  use = {
    airline = false,
    cmp = false,
    coc = true,
    dracula = true,
    easymotion = true,
    elixir_nvim = false,
    lsp = false,
    tender = false
  },
  cs_override = 'solarized'
}
local get_cs
get_cs = function()
  if opts.use.dracula then
    return 'dracula'
  elseif opts.use.tender then
    return 'tender'
  else
    return opts.cs_override
  end
end
do
  opt.clipboard:append('unnamed')
  opt.spelllang = {
    'en_gb',
    'en'
  }
  return opt
end
