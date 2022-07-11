return function()
  require('nvim-treesitter.configs').setup({
    ensure_installed = {
      'elixir',
      'eex',
      'fish',
      'lua',
      'javascript',
      'markdown',
      'ruby',
      'typescript',
      'vim'
    },
    sync_install = false,
    highlight = {
      enable                            = true,
      additional_vim_regex_highlighting = false
    },
  })
end
