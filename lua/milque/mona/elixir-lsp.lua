return function(opts)
  if opts.use.elixir_lsp and not opts.use.elixir_nvim and opts.use.cmp then
    local capabilities =
      require'cmp_nvim_lsp'
        .update_capabilities(vim.lsp.protocol.make_client_capabilities())

    require'lspconfig'.elixirls.setup {
      cmd = {
        vim.loop.os_homedir() .. '/elixir-ls/language_server.sh'
      },

      on_attach = function()
        require'lsp.keymappings'()
      end,

      capabilities = capabilities
    }
  end
end
