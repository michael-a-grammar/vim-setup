return {
  {
    'elixir-tools/elixir-tools.nvim',
    dependencies = 'nvim-lua/plenary.nvim',
    ft = 'elixir',
    enabled = false,

    opts = function(_, _)
      local capabilities = require('cmp_nvim_lsp').default_capabilities(
        vim.lsp.protocol.make_client_capabilities()
      )

      local handlers = {
        ['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
          border = 'rounded',
        }),

        ['textDocument/signatureHelp'] = vim.lsp.with(
          vim.lsp.handlers.signature_help,
          {
            border = 'rounded',
          }
        ),
      }

      return {
        credo = {
          handlers = handlers,
        },

        elixirls = {
          handlers = handlers,
          capabilities = capabilities,

          settings = require('elixir.elixirls').settings({
            dialyzerEnabled = true,
            enableTestLenses = true,
            fetchDeps = true,
            suggestSpecs = true,
          }),
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
