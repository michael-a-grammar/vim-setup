return {
  'MagicDuck/grug-far.nvim',

  config = true,

  keys = {
    {
      '<leader>nr',
      function()
        require('grug-far').open({
          staticTitle = '󰛔',
          transient = true,

          prefills = {
            paths = vim.fn.expand('%'),
          },
        })
      end,
      desc = 'Find and replace',
      mode = { 'n', 'x' },
    },
  },
}
