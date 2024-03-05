return {
  {
    'elixir-tools/elixir-tools.nvim',
    dependencies = 'nvim-lua/plenary.nvim',
    ft = 'elixir',

    opts = function()
      local elixir_ls = require('elixir.elixirls')

      local capabilities = require('cmp_nvim_lsp').default_capabilities(
        vim.lsp.protocol.make_client_capabilities()
      )

      return {
        elixirls = {
          settings = elixir_ls.settings({
            cmd = '~/bin/elixir-ls/elixir-ls',
            dialyzerEnabled = true,
            enableTestLenses = true,
            fetchDeps = true,
            suggestSpecs = true,
          }),

          capabilities = capabilities,

          on_attach = function(_, _)
            vim.keymap.set(
              { 'n', 'x' },
              '<localleader>ee',
              '<cmd>ElixirExpandMacro<cr>',
              { desc = 'Expand macro', buffer = true, noremap = true }
            )

            vim.keymap.set(
              { 'n', 'x' },
              '<localleader>em',
              ':Mix ',
              { desc = 'Mix', buffer = true, noremap = true }
            )

            vim.keymap.set({ 'n', 'x' }, '<localleader>eo', function()
              elixir_ls.open_output_panel({
                window = 'float',
              })
            end, {
              desc = 'ElixirLS logs',
              buffer = true,
              noremap = true,
            })

            vim.keymap.set(
              { 'n', 'x' },
              '<localleader>ena',
              ':Etask ',
              { desc = 'New Task', buffer = true, noremap = true }
            )

            vim.keymap.set(
              { 'n', 'x' },
              '<localleader>enc',
              ':Econtroller ',
              { desc = 'New Controller', buffer = true, noremap = true }
            )

            vim.keymap.set(
              { 'n', 'x' },
              '<localleader>ene',
              ':Echannel ',
              { desc = 'New Channel', buffer = true, noremap = true }
            )

            vim.keymap.set(
              { 'n', 'x' },
              '<localleader>enf',
              ':Efeature ',
              { desc = 'New Feature', buffer = true, noremap = true }
            )

            vim.keymap.set(
              { 'n', 'x' },
              '<localleader>enh',
              ':Ehtml ',
              { desc = 'New HTML', buffer = true, noremap = true }
            )

            vim.keymap.set(
              { 'n', 'x' },
              '<localleader>enj',
              ':Ejson ',
              { desc = 'New JSON', buffer = true, noremap = true }
            )

            vim.keymap.set(
              { 'n', 'x' },
              '<localleader>enl',
              ':Eliveview ',
              { desc = 'New LiveView', buffer = true, noremap = true }
            )

            vim.keymap.set(
              { 'n', 'x' },
              '<localleader>enm',
              ':Ecomponent ',
              { desc = 'New Component', buffer = true, noremap = true }
            )

            vim.keymap.set(
              { 'n', 'x' },
              '<localleader>enn',
              ':Esource ',
              { desc = 'New Module', buffer = true, noremap = true }
            )

            vim.keymap.set(
              { 'n', 'x' },
              '<localleader>eno',
              ':Elivecomponent ',
              { desc = 'New LiveComponent', buffer = true, noremap = true }
            )

            vim.keymap.set(
              { 'n', 'x' },
              '<localleader>ent',
              ':Etest ',
              { desc = 'New Test', buffer = true, noremap = true }
            )

            vim.keymap.set(
              { 'n', 'x' },
              '<localleader>env',
              ':Eview ',
              { desc = 'New View', buffer = true, noremap = true }
            )

            vim.keymap.set(
              { 'n', 'x' },
              '<localleader>epf',
              '<cmd>ElixirFromPipe<cr>',
              { desc = 'From pipe', buffer = true, noremap = true }
            )

            vim.keymap.set(
              { 'n', 'x' },
              '<localleader>ept',
              '<cmd>ElixirToPipe<cr>',
              { desc = 'To pipe', buffer = true, noremap = true }
            )

            vim.keymap.set(
              { 'n', 'x' },
              '<localleader>ere',
              '<cmd>ElixirRestart | edit<cr>',
              {
                desc = 'Restart ElixirLS and reattach',
                buffer = true,
                noremap = true,
              }
            )

            vim.keymap.set(
              { 'n', 'x' },
              '<localleader>err',
              '<cmd>ElixirRestart<cr>',
              { desc = 'Restart ElixirLS', buffer = true, noremap = true }
            )

            vim.keymap.set(
              { 'n', 'x' },
              '<localleader>erf',
              '<cmd>ElixirRestart | edit!<cr>',
              {
                desc = '' .. ' Restart ElixirLS',
                buffer = true,
                noremap = true,
              }
            )
          end,
        },
      }
    end,
  },

  {
    'elixir-editors/vim-elixir',
    ft = 'elixir',
  },

  {
    'andyl/vim-textobj-elixir',
    dependencies = 'kana/vim-textobj-user',
    ft = 'elixir',
  },
}
