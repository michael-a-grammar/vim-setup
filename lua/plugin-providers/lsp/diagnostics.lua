local diagnostic = vim.diagnostic

return {
  coc = {
    info       = { plug = 'coc-diagnostic-info'                      },
    next       = { plug = 'coc-diagnostic-next'                      },
    next_error = { plug = 'coc-diagnostic-next-error'                },
    prev       = { plug = 'coc-diagnostic-prev'                      },
    prev_error = { plug = 'coc-diagnostic-prev-error'                },
    refresh    = { cmd  = "call CocActionAsync('diagnosticRefresh')" }
  },
  lsp = {
    info       = diagnostic.open_float,
    next       = diagnostic.goto_next,
    next_error = diagnostic.goto_next,
    prev       = diagnostic.goto_prev,
    prev_error = diagnostic.goto_prev,
    setloclist = diagnostic.setloclist
  }
}
