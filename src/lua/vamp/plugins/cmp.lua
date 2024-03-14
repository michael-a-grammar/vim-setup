return {
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',

  dependencies = {
    {
      'neovim/nvim-lspconfig',

      config = function()
        require('lspconfig.ui.windows').default_options = {
          border = 'rounded',
        }
      end,
    },

    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-nvim-lsp-document-symbol',
    'hrsh7th/cmp-nvim-lsp-signature-help',
    'hrsh7th/cmp-path',

    'dmitmel/cmp-cmdline-history',
    'amarakon/nvim-cmp-buffer-lines',

    'chrisgrieser/cmp_yanky',

    'onsails/lspkind.nvim',
  },

  config = function()
    local cmp = require('cmp')
    local lspkind = require('lspkind')

    local has_words_before = function()
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))

      return col ~= 0
        and vim.api
            .nvim_buf_get_lines(0, line - 1, line, true)[1]
            :sub(col, col)
            :match('%s')
          == nil
    end

    local enable_cmp = function()
      local context = require('cmp.config.context')

      if
        vim.bo.filetype == 'TelescopePrompt'
        or context.in_syntax_group('Comment')
        or context.in_treesitter_capture('comment')
      then
        return false
      end

      return true
    end

    cmp.setup({
      enabled = enable_cmp,

      formatting = {
        format = lspkind.cmp_format({
          ellipsis_char = '...',
          maxwidth = 50,
          mode = 'symbol',

          show_labelDetails = true,
        }),
      },

      mapping = cmp.mapping.preset.insert({
        ['<c-f>'] = cmp.mapping.scroll_docs(-4),
        ['<c-p>'] = cmp.mapping.scroll_docs(4),

        ['<cr>'] = cmp.mapping.confirm({ select = false }),

        ['<c-space>'] = cmp.mapping.complete(),

        ['<tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { 'i', 's' }),

        ['<s-tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          else
            fallback()
          end
        end, { 'i', 's' }),
      }),

      preselect = cmp.PreselectMode.None,

      snippet = {
        expand = function(_) end,
      },

      sources = cmp.config.sources({
        {
          name = 'buffer',
        },

        {
          name = 'buffer-lines',

          option = {
            leading_whitespace = false,
            line_numbers = true,
          },
        },

        {
          name = 'cmp_yanky',
        },

        {
          name = 'nvim_lsp',
        },

        {
          name = 'nvim_lsp_signature_help',
        },
      }),

      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
    })

    cmp.setup.cmdline({ '/', '?' }, {
      mapping = cmp.mapping.preset.cmdline(),

      sources = cmp.config.sources({
        {
          name = 'nvim_lsp_document_symbol',
        },

        {
          name = 'buffer',
        },
      }),
    })

    cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        {
          name = 'cmdline',
          option = {
            ignore_cmds = { 'Man', '!' },
          },
        },

        {
          name = 'cmdline_history',
        },

        {
          name = 'path',
          options = {
            trailing_slash = true,
          },
        },
      }),
    })
  end,
}
