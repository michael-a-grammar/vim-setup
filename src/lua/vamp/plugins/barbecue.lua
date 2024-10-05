return {
  'utilyre/barbecue.nvim',

  version = '*',

  dependencies = {
    'SmiteshP/nvim-navic',
    'nvim-tree/nvim-web-devicons',
  },

  opts = {
    show_basename = false,
    theme = 'catppuccin',

    symbols = {
      separator = ' ',
    },
  },

  config = function(_, opts)
    require('barbecue').setup(opts)

    vim.keymap.set({ 'n', 'x' }, '<leader>kb', function()
      require('barbecue.ui').toggle()
    end, { desc = 'Toggle barbecue', noremap = true })

    for index = 1, 9, 1 do
      local barbecue_index = index
      local keymap_index = index == 1 and 'r' or tostring(barbecue_index)

      vim.keymap.set({ 'n', 'x' }, '<leader>nr' .. keymap_index, function()
        require('barbecue.ui').navigate(barbecue_index)
      end, { desc = 'Go to breadcrumb ' .. barbecue_index, noremap = true })
    end

    vim.keymap.set({ 'n', 'x' }, '<leader>nrl', function()
      require('barbecue.ui').navigate(-1)
    end, { desc = 'Go to the last breadcrumb', noremap = true })
  end,
}
