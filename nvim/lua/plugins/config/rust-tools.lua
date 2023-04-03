return function()
  local rust_tools = require'rust-tools'

  local capabilities =
    require'cmp_nvim_lsp'
      .default_capabilities(vim.lsp.protocol.make_client_capabilities())


  --https://github.com/hrsh7th/nvim-cmp/wiki/Language-Server-Specific-Samples#rust-with-rust-toolsnvim

  rust_tools.setup({
    tools = {
      runnables = {
        use_telescope = true,
      },

      inlay_hints = {
        auto = true,
        show_parameter_hints = false,
        parameter_hints_prefix = '',
        other_hints_prefix = '',
      },
    },

    server = {
      capabilities = capabilities,
      settings = {
        ['rust-analyzer'] = {
        },
      },
    },
  })
end
