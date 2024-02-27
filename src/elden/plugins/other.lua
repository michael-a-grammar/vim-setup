return {
  {
    'L3MON4D3/LuaSnip',
    build = 'make install_jsregexp',
  },

  { 'danilamihailov/beacon.nvim',  },
  { 'm-demare/hlargs.nvim',        },
  { 'norcalli/nvim-colorizer.lua', },

  {
    'nvim-tree/nvim-web-devicons',
    
    opts = {
      color_icons = true
    },
  },

  {
    'TamaMcGlinn/quickfixdd',
    ft = 'qf',
  },

  {
    'rhysd/vim-textobj-ruby',
    dependencies = 'kana/vim-textobj-user',
    ft           = 'ruby',
  },

  {
    'bfredl/nvim-luadev',
    ft = 'lua',
  },
}