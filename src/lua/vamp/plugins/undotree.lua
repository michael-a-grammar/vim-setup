return {
  'jiaoshijie/undotree',
  dependencies = 'nvim-lua/plenary.nvim',
  config = true,

  keys = {
    {
      '<leader>nu',
      function()
        require('undotree').toggle()
      end,
      desc = 'Undo tree',
      mode = { 'n', 'x' },
    },
  },
}
