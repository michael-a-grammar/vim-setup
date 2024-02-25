return {
  'nvim-treesitter/nvim-treesitter',

    opts = {
      ensure_installed = {
        'elixir',
        'eex',
        'fish',
        'lua',
        'javascript',
        'markdown',
        'ruby',
        'rust',
        'toml',
        'typescript',
        'vim',
      },

      highlight = {
        enable                            = true,
        additional_vim_regex_highlighting = false,
      },

      ident = {
        enable = true,
      },

      sync_install = false,
  },

  config = function(_, opts)
    require'nvim-treesitter.configs'.setup(opts)
  end,
}
