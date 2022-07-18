return function()
  local g   = require'milque.cartographer'.with.g
  local lsp = vim.lsp.buf

  g()
    .use_D()
    .rhs
      .fn(function()
        lsp.declaration()
      end)
    .exe()

    g()
      .use_d()
      .rhs
        .fn(function()
          lsp.definition()
        end)
      .exe()

    g()
      .use_i()
      .rhs
        .fn(function()
          lsp.implementation()
        end)
      .exe()

    g()
      .use_r()
      .rhs
        .fn(function()
          lsp.references()
        end)
      .exe()

    g()
      .use_t()
      .rhs
        .fn(function()
          lsp.type_definition()
        end)
      .exe()
end
