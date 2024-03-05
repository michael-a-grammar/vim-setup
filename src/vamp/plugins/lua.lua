return {
  'folke/neodev.nvim',
  ft = 'lua',

  dependencies = {
    'neovim/nvim-lspconfig',
  },

  config = function(_, _)
    require('neodev').setup({})

    require('lspconfig').lua_ls.setup({})
  end,
}
