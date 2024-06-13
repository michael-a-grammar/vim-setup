return {
  'folke/neodev.nvim',
  dependencies = 'neovim/nvim-lspconfig',
  ft = 'lua',

  config = function(_, _)
    require('neodev').setup({})

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

    require('lspconfig').lua_ls.setup({
      handlers = handlers,
    })
  end,
}
