local opts = {
  use = {
    airline     = false,
    cmp         = true,
    dracula     = false,
    elixir_nvim = true,
    elixir_lsp  = false,
    lsp         = true,
    tender      = true,
    which_key   = true
  },
  cs_override = 'solarized'
}

function opts:get_cs()
  if self.use.dracula then
    return 'dracula'
  elseif self.use.tender then
    return 'tender'
  else
    return self.cs_override
  end
end

return opts
