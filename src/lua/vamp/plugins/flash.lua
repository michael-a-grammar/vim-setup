return {
  'folke/flash.nvim',
  event = 'VeryLazy',

  opts = {
    labels = 'ntesiroamghdkvclpufxzufq',

    prompt = {
      prefix = {
        {
          '󱐌',
          'FlashPromptIcon',
        },
      },
    },
  },

  keys = {
    {
      'r',
      mode = 'o',

      function()
        require('flash').remote()
      end,

      desc = 'Flash remote',
    },

    {
      '<bs>',

      mode = {
        'n',
        'x',
        'o',
      },

      function()
        require('flash').jump()
      end,

      desc = 'Flash',
    },
  },
}
