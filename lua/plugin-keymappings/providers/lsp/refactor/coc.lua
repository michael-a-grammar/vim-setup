return function()
  return {
    definitions = {
      hover     = { cmd = "call CocActionAsync('definitionHover')"   },
      signature = { cmd = "call CocActionAsync('showSignatureHelp')" }
    },
    diagnostics = {
      info       = { plug = 'coc-diagnostic-info'                      },
      next       = { plug = 'coc-diagnostic-next'                      },
      next_error = { plug = 'coc-diagnostic-next-error'                },
      prev       = { plug = 'coc-diagnostic-prev'                      },
      prev_error = { plug = 'coc-diagnostic-prev-error'                },
      refresh    = { cmd  = "call CocActionAsync('diagnosticRefresh')" }
    },
    find_within_file = {
      outline = { cmd = 'CocList outline' }
    },
    refactor = {
      format   = { plug = 'coc-format'   },
      rename   = { plug = 'coc-rename'   },
      refactor = { plug = 'coc-refactor' }
    }
  }
end

