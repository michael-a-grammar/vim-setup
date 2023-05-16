return function()
  require'catppuccin'.setup {
    background = {
      light = 'latte',
      dark  = 'mocha'
    },

    flavour = 'mocha',

    dim_inactive = {
      enabled    = false,
      shade      = 'dark',
      percentage = 0.15,
    },

    show_end_of_buffer = true,

    highlight = {
      enable                            = true,
      additional_vim_regex_highlighting = false
    },

    integrations = {
      beacon          = true,
      cmp             = true,
      gitsigns        = true,
      fern            = true,
      fidget          = true,
      hop             = true,
      lsp_trouble     = true,
      neogit          = true,
      notify          = true,
      telescope       = true,
      semantic_tokens = true,
      treesitter      = true,
      which_key       = true,

      barbecue = {
        dim_dirname    = true,
        bold_basename  = true,
        dim_context    = false,
        alt_background = false
      },

      native_lsp = {
        enabled = true,
        virtual_text = {
          errors      = { "italic" },
          hints       = { "italic" },
          information = { "italic" },
          warnings    = { "italic" }
        },
        underlines = {
          errors      = { "underline" },
          hints       = { "underline" },
          information = { "underline" },
          warnings    = { "underline" }
        }
      },

      navic = {
        enabled   = false,
        custom_bg = 'NONE'
      }
    }
  }
end
