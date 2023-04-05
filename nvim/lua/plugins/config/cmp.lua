return function()
  local api           = vim.api
  local bo            = vim.bo
  local fn            = vim.fn
  local cmp           = require'cmp'
  local lspkind       = require'lspkind'

  local has_words_before = function()
    local line, col = unpack(api.nvim_win_get_cursor(0))

    return col ~= 0
      and api.nvim_buf_get_lines(0, line - 1, line, true)[1]
            :sub(col, col)
            :match("%s") == nil
  end

  local enable_cmp = function()
    local context = require'cmp.config.context'

    if bo.filetype == 'TelescopePrompt'
      or context.in_treesitter_capture('comment')
      and context.in_syntax_group('Comment')
      then
        return false
    end

    return true
  end

  cmp.setup {
    enabled = enable_cmp,

    preselect = cmp.PreselectMode.None,

    formatting = {
      format = lspkind.cmp_format {
        mode     = 'symbol_text',
        maxwidth = 80,
        menu = {
          buffer                   = '﬘',
          calc                     = '',
          cmdline                  = '',
          nvim_lsp                 = '',
          nvim_lsp_document_symbol = ' ',
          nvim_lsp_signature_help  = ' ',
          nvim_lua                 = '',
          path                     = '',
          spell                    = '﬜',
          vsnip                    = ''
        }
      }
    },

    snippet = {
      expand = function(args)
      end
    },

    window = {
      completion    = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered()
    },

    mapping = cmp.mapping.preset.insert {
      ['<tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end, { 'i', 's' }),

      ['<s-tab>'] = cmp.mapping(function()
        if cmp.visible() then
          cmp.select_prev_item()
        end
      end, { 'i', 's' }),

      ['<c-e>'] = cmp.mapping.scroll_docs(-4),
      ['<c-n>'] = cmp.mapping.scroll_docs(4),

      ['<c-space>'] = cmp.mapping.complete(),
      ['<cr>']      = cmp.mapping.confirm({ select = false }),
      ['<esc>']     = cmp.mapping.abort()
    },

    sources = cmp.config.sources({
      { name = 'nvim_lsp'                },
      { name = 'nvim_lsp_signature_help' },
      {
        name   = 'buffer',
        option = {
          get_bufnrs = function()
            return api.nvim_list_bufs()
          end
        }
      },
      {
        { name = 'nvim_lua' },
        { name = 'calc'     },
        { name = 'vsnip'    }
      }
    })
  }

  cmp.setup.cmdline({ '/', '? '}, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'nvim_lsp_document_symbol' },
      { name = 'buffer' }
    })
  })

  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      {
        name = 'cmdline',
        option = {
          ignore_cmds = { 'Man', '!' }
        }
      },
      {
        name = 'path',
        options = {
          trailing_slash = true
        }
      }
    })
  })

  local enable_debounce = function()
    local timer = vim.loop.new_timer()

    local debounce_delay = 1000

    local debounce = function()
      timer:stop()

      timer:start(
        debounce_delay,
        0,
        vim.schedule_wrap(function()
          if enable_cmp() then
            cmp.complete({ reason = cmp.ContextReason.Auto })
          end
        end))
    end

    local events_augroup = api.nvim_create_augroup('text_changed_insert_events', {})

    api.nvim_create_autocmd('TextChangedI', {
      group    = events_augroup,
      pattern  = "*",
      callback = debounce
    })
  end
end
