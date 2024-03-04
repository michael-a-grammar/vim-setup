return {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,

  opts = {
    flavour = 'mocha',

    background = {
      light = 'latte',
      dark = 'mocha',
    },

    integrations = {
      beacon = true,
      cmp = true,
      dashboard = true,
      gitsigns = true,
      hop = true,
      lsp_trouble = true,
      neogit = true,
      noice = true,
      notify = true,
      rainbow_delimiters = true,
      semantic_tokens = true,
      treesitter = true,
      which_key = true,

      barbecue = {
        dim_dirname = true,
        bold_basename = true,
        dim_context = true,
        alt_background = false,
      },

      mini = {
        enabled = true,
        indentscope_color = 'green',
      },

      native_lsp = {
        enabled = true,
        virtual_text = {
          errors = { 'italic' },
          hints = { 'italic' },
          information = { 'italic' },
          warnings = { 'italic' },
        },
        underlines = {
          errors = { 'underline' },
          hints = { 'underline' },
          information = { 'underline' },
          warnings = { 'underline' },
        },
      },

      navic = {
        enabled = true,
        custom_bg = 'NONE',
      },

      telescope = {
        enabled = true,
        style = 'nvchad',
      },
    },
  },

  config = function(_, opts)
    require('catppuccin').setup(opts)

    vim.api.nvim_exec('colorscheme catppuccin', false)
  end,
}
