return {
  'nvim-treesitter/nvim-treesitter',

  opts = {
    ensure_installed = {
      'bash',
      'elixir',
      'eex',
      'fish',
      'lua',
      'javascript',
      'markdown',
      'markdown_inline',
      'regex',
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
