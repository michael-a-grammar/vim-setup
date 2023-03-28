return function()
  require('catppuccin').setup({
    background = {
      light = 'latte',
      dark  = 'mocha'
    },
    flavour = 'mocha',
    integrations = {
      cmp        = true,
      fern       = true,
      notify     = true,
      telescope  = true,
      treesitter = true,
      which_key  = true,

      native_lsp = {
        enabled = true
      },
    }
  })
end
