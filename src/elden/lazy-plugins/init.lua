return {
    {
      'nvim-tree/nvim-web-devicons',
      
      opts = {
        color_icons = true
      },
    },

    {
      'rhysd/vim-textobj-ruby',
      dependancies = 'kana/vim-textobj-user',
      ft           = 'ruby',
    },

    {
      'bfredl/nvim-luadev',
      ft = 'lua',
    },
}