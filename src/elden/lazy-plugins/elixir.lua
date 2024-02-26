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
            dialyzerEnabled  = true,
            enableTestLenses = true,
            fetchDeps        = true,
            suggestSpecs     = true,
          },

          on_attach = function(_, bufnr)
            map(function()
              local map = require'elden.cartographer'.map

              b.nx_local_leader_with {
                'a', exe 'ElixirExpandMacro', 'Expand macro',
                'e', exe 'ElixirRestart',     'Restart ElixirLS',
                'm', cmd_mode 'Mix ',         'Mix',

                'o',
                function()
                  elixir_ls.open_output_panel({ window = 'float' })
                end,
                'ElixirLS logs',

                'r', exe 'ElixirRestart | edit',  'Restart ElixirLS and reattach',
                'R', exe 'ElixirRestart | edit!', 'Restart ElixirLS and force reattach',
              }

              b.nx_local_leader_with 'ei' {
                'f', exe 'ElixirFromPipe', 'From pipe',
                't', exe 'ElixirToPipe',   'To pipe',
              }

              b.nx_local_leader_with 'ep' {
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
            end)
          end,
        },

        capabilities = capabilities,
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
