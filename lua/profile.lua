require('telescope').load_extension('coc')

require'nvim-treesitter.configs'.setup {
  ensure_installed = {
    'c_sharp',
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
    enable = true,

    additional_vim_regex_highlighting = false,
  },
}

require('gitsigns').setup()
