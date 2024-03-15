return {
  'ThePrimeagen/harpoon',

  config = function(_, _)
    require('telescope').load_extension('harpoon')

    vim.keymap.set(
      { 'n', 'x' },
      '<leader>hh',
      '<cmd>Telescope harpoon marks<cr>',
      { desc = 'Harpoons', noremap = true }
    )

    vim.keymap.set({ 'n', 'x' }, '<leader>hn', function()
      require('harpoon.ui').nav_next()
    end, { desc = 'Next harpoon', noremap = true })

    vim.keymap.set({ 'n', 'x' }, '<leader>hp', function()
      require('harpoon.ui').nav_prev()
    end, { desc = 'Previous harpoon', noremap = true })

    vim.keymap.set({ 'n', 'x' }, '<leader>ht', function()
      require('harpoon.ui').toggle_quick_menu()
    end, { desc = 'Harpoon quick menu', noremap = true })

    vim.keymap.set({ 'n', 'x' }, '<leader>nh', function()
      require('harpoon.mark').add_file()
    end, { desc = 'Harpoon here', noremap = true })
  end,
}
