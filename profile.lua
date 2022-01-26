require('telescope').load_extension('coc')

require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
  sync_install = false,
  ignore_install = { "javascript" },

  highlight = {
    enable = true,

    additional_vim_regex_highlighting = false,
  },
}
