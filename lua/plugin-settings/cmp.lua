return function(opts)
  if opts.use.cmp then
    local api     = vim.api
    local cmp     = require'cmp'
    local lspkind = require'lspkind'
    local neon    = require'milque.neon'

    local has_words_before = function()
      local line, col = unpack(api.nvim_win_get_cursor(0))

      return col ~= 0
        and api.nvim_buf_get_lines(0, line - 1, line, true)[1]
              :sub(col, col)
              :match("%s") == nil
    end

    cmp.setup{
      enabled = function()
        local context = require'cmp.config.context'
        if api.nvim_get_mode().mode == 'c' then
          return true
        else
          return not context.in_treesitter_capture('comment')
            and not context.in_syntax_group('Comment')
        end
      end,
      formatting = {
        format = lspkind.cmp_format{
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
            treesitter               = '',
            vsnip                    = ''
          }
        }
      },
      snippet = {
        expand = function(args)
          vim.fn['vsnip#anonymous'](args.body)
        end
      },
      window = {
        completion    = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered()
      },
      mapping = cmp.mapping.preset.insert{
        ['<tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif vim.fn['vsnip#available'](1) == 1 then
            feedkey('<plug>(vsnip-expand-or-jump)', '')
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { 'i', 's' }),

        ['<s-tab>'] = cmp.mapping(function()
          if cmp.visible() then
            cmp.select_prev_item()
          elseif vim.fn['vsnip#jumpable'](-1) == 1 then
            neon.f('<plug>(vsnip-jump-prev)', '')
          end
        end, { 'i', 's' }),

        ['<c-p>'] = cmp.mapping.scroll_docs(-4),
        ['<c-n>'] = cmp.mapping.scroll_docs(4),
        ['<c-t>'] = cmp.mapping.complete{
          config = {
            sources = {
              { name = 'treesitter' }
            }
          }
        },
        ['<c-l>'] = cmp.mapping.complete{
          config = {
            sources = {
              { name = 'nvim_lsp' },
              { name = 'nvim_lsp_document_symbol' },
              { name = 'nvim_lsp_signature_help'  },
            }
          }
        },
        ['<c-space>'] = cmp.mapping.complete(),
        ['<cr>']      = cmp.mapping.confirm({ select = true }),
        ['<esc>']     = cmp.mapping.abort()
      },
      sources = cmp.config.sources({
        { name = 'nvim_lsp'                 },
        { name = 'nvim_lsp_document_symbol' },
        { name = 'nvim_lsp_signature_help'  },
      },
      {
        { name = 'treesitter' },
      },
      {
        { name = 'vsnip' }
      },
      {
        { name = 'buffer' }
      },
      {
        { name = 'nvim_lua' },
        { name = 'calc'     },
        { name = 'spell'    }
      })
    }

    cmp.setup.cmdline('/', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = 'nvim_lsp_document_symbol' }
      },
      {
        { name = 'buffer' }
      })
    })

    cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = 'path' }
      },
      {
        { name = 'cmdline' }
      })
    })

    local events_augroup = api.nvim_create_augroup('events', {})

    api.nvim_create_autocmd('FileType TelescopePrompt', {
      callback = function()
        require'cmp'.setup.buffer{
          completion = {
            autocomplete = false
          }
        }
      end,
      group = events_augroup
    })
  end
end
