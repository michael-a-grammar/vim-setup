return {
  'hrsh7th/nvim-cmp',

  event = {
    'InsertEnter',
    'CmdlineEnter',
  },

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

    'onsails/lspkind.nvim',
  },

  config = function()
    local cmp = require('cmp')
    local lspkind = require('lspkind')
    local luasnip = require('luasnip')

    local has_words_before = function()
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))

      return col ~= 0
        and vim.api
            .nvim_buf_get_lines(0, line - 1, line, true)[1]
            :sub(col, col)
            :match('%s')
          == nil
    end

    local cmp_next_selection = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end

    local cmp_previous_selection = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
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
          maxwidth = 80,
          mode = 'symbol',

          show_labelDetails = true,
        }),
      },

      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },

      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },

      mapping = cmp.mapping.preset.insert({
        ['<c-bs>'] = cmp.mapping.complete(),
        ['<c-e>'] = cmp.mapping.abort(),
        ['<c-f>'] = cmp.mapping.scroll_docs(-4),
        ['<c-p>'] = cmp.mapping.scroll_docs(4),
        ['<cr>'] = cmp.mapping.confirm({ select = true }),
        ['q'] = cmp.mapping.close_docs(),

        ['<tab>'] = cmp.mapping(cmp_next_selection, { 'i', 's' }),
        ['<s-tab>'] = cmp.mapping(cmp_previous_selection, { 'i', 's' }),

        ['<down>'] = cmp.mapping(cmp_next_selection, { 'i', 's' }),
        ['<up>'] = cmp.mapping(cmp_previous_selection, { 'i', 's' }),
      }),

      sources = cmp.config.sources({
        {
          name = 'nvim_lsp',
        },

        {
          name = 'nvim_lsp_signature_help',
        },

        {
          name = 'luasnip',
        },
      }),
    })

    cmp.setup.cmdline({ '/', '?' }, {
      mapping = cmp.mapping.preset.cmdline(),

      sources = cmp.config.sources({
        {
          name = 'buffer',
        },

        {
          name = 'nvim_lsp_document_symbol',
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
          name = 'path',
          options = {
            trailing_slash = true,
          },
        },
      }),
    })
  end,
}
