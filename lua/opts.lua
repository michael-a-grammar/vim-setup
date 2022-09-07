local opts = {
  use = {
    themes = {
      dracula = false,
      jellybeans = false,
      alduin  = false,
      noir = false
      kolor   = false,
      tender  = false,
      solarized = false,
    },
    airline     = true,
    cmp         = true,
    dracula     = true,
    elixir_nvim = false,
    elixir_lsp  = true,
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
