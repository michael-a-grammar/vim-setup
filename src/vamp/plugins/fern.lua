return {
  'lambdalisue/fern.vim',

  dependencies = {
    'lambdalisue/fern-hijack.vim',
    'lambdalisue/nerdfont.vim',
    'lambdalisue/fern-renderer-nerdfont.vim',
    'lambdalisue/glyph-palette.vim',
    'andykog/fern-highlight.vim',
    'yuki-yano/fern-preview.vim',
  },

  init = function()
    local api = vim.api
    local fn = vim.fn
    local g = vim.g
    local set_keymap = vim.keymap.set

    g['fern#renderer'] = 'nerdfont'

    local events_augroup = api.nvim_create_augroup('fern_file_type_events', {})

    api.nvim_create_autocmd('FileType', {
      group = events_augroup,
      pattern = 'fern',
      callback = function()
        fn['glyph_palette#apply']()
      end,
    })

    api.nvim_create_autocmd('FileType', {
      group = events_augroup,
      pattern = 'fern',
      callback = function()
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
        vim.opt_local.signcolumn = 'no'

        set_keymap(
          'n',
          '<plug>(fern-quit-or-close-preview)',
          'fern_preview#smart_preview(":call fern_preview#close()<cr>", ":q<cr>")',
          { desc = 'Quit Fern', buffer = true, expr = true, noremap = true }
        )

        set_keymap(
          'n',
          '<c-f>',
          '<plug>(fern-action-preview:scroll:up:half)',
          { desc = 'Preview scroll up', buffer = true, noremap = true }
        )

        set_keymap(
          'n',
          '<c-p>',
          '<plug>(fern-action-preview:scroll:down:half)',
          { desc = 'Preview scroll down', buffer = true, noremap = true }
        )

        set_keymap(
          'n',
          '<leader>o',
          '<plug>(fern-action-preview:auto:toggle)',
          { desc = 'Preview toggle', buffer = true, noremap = true }
        )

        set_keymap(
          'n',
          '<leader>q',
          '<plug>(fern-quit-or-close-preview)',
          { desc = 'Quit', buffer = true, noremap = true }
        )

        set_keymap(
          'n',
          '<leader>l',
          '<c-w>p',
          { desc = 'Previous window', buffer = true, noremap = true }
        )
      end,
    })

    set_keymap(
      { 'n', 'x' },
      'l',
      '<cmd>Fern . -drawer -reveal=%:p<cr>',
      { desc = 'Locate file within fern', noremap = true }
    )

    set_keymap(
      { 'n', 'x' },
      'L',
      '<cmd>Fern . -drawer -toggle -reveal=%:p<cr>',
      { desc = 'Toggle fern', noremap = true }
    )
  end,
}
