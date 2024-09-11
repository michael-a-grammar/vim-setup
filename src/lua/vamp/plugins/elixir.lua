return {
  {
    'elixir-tools/elixir-tools.nvim',
    dependencies = 'nvim-lua/plenary.nvim',
    enabled = true,
    ft = 'elixir',

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
        elixirls = {
          enable = true,

          handlers = handlers,
          capabilities = capabilities,

          settings = require('elixir.elixirls').settings({
            dialyzerEnabled = true,
            enableTestLenses = true,
            fetchDeps = true,
            suggestSpecs = true,
          }),
        },

        nextls = {
          enable = false,

          handlers = handlers,
          capabilities = capabilities,

          init_options = {
            experimental = {
              completions = {
                enable = true,
              },
            },
          },
        },

        projectionist = {
          enable = false,
        },
      }
    end,
  },

  {
    'elixir-editors/vim-elixir',
    ft = 'elixir',
  },
}
