return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',

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
      enable = true,
      additional_vim_regex_highlighting = false,
    },

    ident = {
      enable = true,
    },

    sync_install = false,
  },

  main = 'nvim-treesitter.configs',
}
