return function()
  local g   = require'milque.cartographer'.with.g
  local lsp = vim.lsp.buf

  g()
    .use_D()
    .rhs
      .fn(lsp.declaration)
    .exe()

  g()
    .use_d()
    .rhs
      .fn(lsp.definition)
    .exe()

  g()
    .use_i()
    .rhs
      .fn(lsp.implementation)
    .exe()

  g()
    .use_r()
    .rhs
      .fn(lsp.references)
    .exe()

  g()
    .use_t()
    .rhs
      .fn(lsp.type_definition)
    .exe()
end
