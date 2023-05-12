return function()
  require'catppuccin'.setup {
    background = {
      light = 'latte',
      dark  = 'mocha'
    },

    flavour = 'mocha',

    dim_inactive = {
      enabled    = false,
      shade      = "dark",
      percentage = 0.15,
    },

    integrations = {
      cmp        = true,
      fern       = true,
      neogit     = true,
      notify     = true,
      telescope  = true,
      treesitter = true,
      which_key  = true,

      native_lsp = {
        enabled = true
      },
    }
  }
end
