import api, g, keymap, opt from vim

opts = 
  use: 
    airline: false
    cmp: false
    coc: true
    dracula: true
    easymotion: true
    elixir_nvim: false
    lsp: false
    tender: false
  cs_override: 'solarized'

get_cs = ->
  if opts.use.dracula
    return 'dracula'
  elseif opts.use.tender
    return 'tender'
  else
    return opts.cs_override

with opt
  .clipboard\append('unnamed')
  .spelllang = { 'en_gb', 'en' }

