require'catppuccin'.setup {
  flavour = 'mocha',

  background = {
    light = 'latte',
    dark  = 'mocha',
  },

  integrations = {
    beacon          = true,
    cmp             = true,
    dashboard       = true,
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
      dim_context    = true,
      alt_background = false,
    },

    native_lsp = {
      enabled = true,
      virtual_text = {
        errors      = { 'italic', },
        hints       = { 'italic', },
        information = { 'italic', },
        warnings    = { 'italic', },
      },
      underlines = {
        errors      = { 'underline', },
        hints       = { 'underline', },
        information = { 'underline', },
        warnings    = { 'underline', },
      }
    },

    navic = {
      enabled   = false,
      custom_bg = 'NONE',
    },
  },
}

vim.api.nvim_exec('colorscheme catppuccin', false)
