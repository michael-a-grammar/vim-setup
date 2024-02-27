return {
  {
    'elixir-tools/elixir-tools.nvim',
    dependencies = 'nvim-lua/plenary.nvim',
    ft           = 'elixir',

    opts = function()
      local elixir    = require'elixir'
      local elixir_ls = require'elixir.elixirls'

      local capabilities =
        require'cmp_nvim_lsp'
          .default_capabilities(vim.lsp.protocol.make_client_capabilities())

      return {
        elixirls = {
          settings = elixir_ls.settings {
            cmd              = '~/bin/elixir-ls/elixir-ls',
            dialyzerEnabled  = true,
            enableTestLenses = true,
            fetchDeps        = true,
            suggestSpecs     = true,
          },

          capabilities = capabilities,

          on_attach = function(_, bufnr)
            local map = require'elden.cartographer'.map

            map(function()
              b.nx_local_leader_with 'e' {
                'e', exe 'ElixirExpandMacro', 'Expand macro',
                'm', cmd_mode 'Mix ',         'Mix',

                'o',
                function()
                  elixir_ls.open_output_panel({ window = 'float' })
                end,
                'ElixirLS logs',
              }

              b.nx_local_leader_with 'en' {
                'a', cmd_mode 'Etask ',          'New Task',
                'c', cmd_mode 'Econtroller ',    'New Controller',
                'e', cmd_mode 'Echannel ',       'New Channel',
                'f', cmd_mode 'Efeature ',       'New Feature',
                'h', cmd_mode 'Ehtml ',          'New HTML',
                'j', cmd_mode 'Ejson ',          'New JSON',
                'l', cmd_mode 'Eliveview ',      'New LiveView',
                'm', cmd_mode 'Ecomponent ',     'New Component',
                'n', cmd_mode 'Esource ',        'New Module',
                'o', cmd_mode 'Elivecomponent ', 'New LiveComponent',
                't', cmd_mode 'Etest ',          'New Test',
                'v', cmd_mode 'Eview ',          'New View',
              }

              b.nx_local_leader_with 'ep' {
                'f', exe 'ElixirFromPipe', 'From pipe',
                't', exe 'ElixirToPipe',   'To pipe',
              }

              b.nx_local_leader_with 'er' {
                'e', exe 'ElixirRestart | edit',  'Restart ElixirLS and reattach',
                'r', exe 'ElixirRestart',         'Restart ElixirLS',
                'f', exe 'ElixirRestart | edit!', 'Restart ElixirLS and force reattach',
              }
            end)
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
    ft           = 'elixir',
  },
}
