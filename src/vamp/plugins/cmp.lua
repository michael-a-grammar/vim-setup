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

    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-nvim-lsp-document-symbol',
    'hrsh7th/cmp-nvim-lsp-signature-help',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-calc',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/cmp-nvim-lua',

    'onsails/lspkind.nvim',

    {
      'j-hui/fidget.nvim',

      opts = {
        notification = {
          window = {
            winblend = 0,
          },
        },
      },
    },
  },

  config = function()
    local api = vim.api
    local bo = vim.bo
    local cmp = require('cmp')

    local has_words_before = function()
      local line, col = unpack(api.nvim_win_get_cursor(0))

      return col ~= 0
        and api
            .nvim_buf_get_lines(0, line - 1, line, true)[1]
            :sub(col, col)
            :match('%s')
          == nil
    end

    local enable_cmp = function()
      local context = require('cmp.config.context')

      if
        bo.filetype == 'TelescopePrompt'
        or context.in_treesitter_capture('comment')
        or context.in_syntax_group('Comment')
      then
        return false
      end

      return true
    end

    cmp.setup({
      enabled = enable_cmp,
      preselect = cmp.PreselectMode.None,

      snippet = {
        expand = function(_) end,
      },

      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },

      mapping = cmp.mapping.preset.insert({
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

        ['<c-f>'] = cmp.mapping.scroll_docs(-4),
        ['<c-p>'] = cmp.mapping.scroll_docs(4),

        ['<c-space>'] = cmp.mapping.complete(),
        ['<cr>'] = cmp.mapping.confirm({ select = false }),
        ['<esc>'] = cmp.mapping.abort(),
      }),

      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'nvim_lsp_signature_help' },
        { name = 'buffer' },
        { name = 'nvim_lua' },
        { name = 'calc' },
        { name = 'vsnip' },
      }),
    })

    cmp.setup.cmdline({ '/', '?' }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = 'nvim_lsp_document_symbol' },
        { name = 'buffer' },
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
