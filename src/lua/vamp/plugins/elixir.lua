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

          on_attach = function(_, bufnr)
            vim.keymap.set(
              { 'n', 'x' },
              '<leader>me',
              '<cmd>ElixirExpandMacro<cr>',
              { desc = 'Expand macro', buffer = bufnr, noremap = true }
            )

            vim.keymap.set(
              { 'n', 'x' },
              '<leader>mm',
              ':Mix ',
              { desc = 'Mix', buffer = bufnr, noremap = true }
            )

            vim.keymap.set({ 'n', 'x' }, '<leader>mo', function()
              elixir_ls.open_output_panel({
                window = 'float',
              })
            end, {
              desc = 'ElixirLS logs',
              buffer = bufnr,
              noremap = true,
            })

            vim.keymap.set(
              { 'n', 'x' },
              '<leader>mna',
              ':Etask ',
              { desc = 'New Task', buffer = bufnr, noremap = true }
            )

            vim.keymap.set(
              { 'n', 'x' },
              '<leader>mnc',
              ':Econtroller ',
              { desc = 'New Controller', buffer = bufnr, noremap = true }
            )

            vim.keymap.set(
              { 'n', 'x' },
              '<leader>mne',
              ':Echannel ',
              { desc = 'New Channel', buffer = bufnr, noremap = true }
            )

            vim.keymap.set(
              { 'n', 'x' },
              '<leader>mnf',
              ':Efeature ',
              { desc = 'New Feature', buffer = bufnr, noremap = true }
            )

            vim.keymap.set(
              { 'n', 'x' },
              '<leader>mnh',
              ':Ehtml ',
              { desc = 'New HTML', buffer = bufnr, noremap = true }
            )

            vim.keymap.set(
              { 'n', 'x' },
              '<leader>mnj',
              ':Ejson ',
              { desc = 'New JSON', buffer = bufnr, noremap = true }
            )

            vim.keymap.set(
              { 'n', 'x' },
              '<leader>mnl',
              ':Eliveview ',
              { desc = 'New LiveView', buffer = bufnr, noremap = true }
            )

            vim.keymap.set(
              { 'n', 'x' },
              '<leader>mnm',
              ':Ecomponent ',
              { desc = 'New Component', buffer = bufnr, noremap = true }
            )

            vim.keymap.set(
              { 'n', 'x' },
              '<leader>mnn',
              ':Esource ',
              { desc = 'New Module', buffer = bufnr, noremap = true }
            )

            vim.keymap.set(
              { 'n', 'x' },
              '<leader>mno',
              ':Elivecomponent ',
              { desc = 'New LiveComponent', buffer = bufnr, noremap = true }
            )

            vim.keymap.set(
              { 'n', 'x' },
              '<leader>mnt',
              ':Etest ',
              { desc = 'New Test', buffer = bufnr, noremap = true }
            )

            vim.keymap.set(
              { 'n', 'x' },
              '<leader>mnv',
              ':Eview ',
              { desc = 'New View', buffer = bufnr, noremap = true }
            )

            vim.keymap.set(
              { 'n', 'x' },
              '<leader>mpf',
              '<cmd>ElixirFromPipe<cr>',
              { desc = 'From pipe', buffer = bufnr, noremap = true }
            )

            vim.keymap.set(
              { 'n', 'x' },
              '<leader>mpt',
              '<cmd>ElixirToPipe<cr>',
              { desc = 'To pipe', buffer = bufnr, noremap = true }
            )

            vim.keymap.set(
              { 'n', 'x' },
              '<leader>mre',
              '<cmd>ElixirRestart | edit<cr>',
              {
                desc = 'Restart ElixirLS and reattach',
                buffer = bufnr,
                noremap = true,
              }
            )

            vim.keymap.set(
              { 'n', 'x' },
              '<leader>mrr',
              '<cmd>ElixirRestart<cr>',
              { desc = 'Restart ElixirLS', buffer = bufnr, noremap = true }
            )

            vim.keymap.set(
              { 'n', 'x' },
              '<leader>mrf',
              '<cmd>ElixirRestart | edit!<cr>',
              {
                desc = '' .. ' Restart ElixirLS',
                buffer = bufnr,
                noremap = true,
              }
            )

            local to_register = {
              ['<leader>m'] = {
                name = 'Elixir',

                n = {
                  name = 'New file',
                },

                p = {
                  name = 'Pipes',
                },

                r = {
                  name = 'Restart LSP',
                },
              },
            }

            local which_key = require('which-key')

            which_key.register(to_register, { mode = 'n' })
            which_key.register(to_register, { mode = 'x' })
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
