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

    local cmp_config_window_bordered = cmp.config.window.bordered()

    cmp_config_window_bordered.border = 'none'
    cmp_config_window_bordered.col_offset = -3
    cmp_config_window_bordered.side_padding = 0

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
        fields = {
          'kind',
          'abbr',
          'menu',
        },

        format = function(entry, vim_item)
          local cmp_format_factory = lspkind.cmp_format({
            mode = 'symbol_text',
            maxwidth = 80,
          })

          local cmp_format = cmp_format_factory(entry, vim_item)

          local split_kind = vim.split(cmp_format.kind, '%s', {
            trimempty = true,
          })

          local kind = split_kind[1] or ''
          local menu = split_kind[2] or ''

          cmp_format.kind = ' ' .. kind .. ' '
          cmp_format.menu = '    ' .. '(' .. menu .. ')'

          return cmp_format
        end,
      },

      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },

      window = {
        completion = cmp_config_window_bordered,
        documentation = cmp.config.window.bordered(),
      },

      mapping = cmp.mapping.preset.insert({
        ['<c-bs>'] = cmp.mapping.complete(),
        ['<c-a>'] = cmp.mapping.abort(),
        ['<c-f>'] = cmp.mapping.scroll_docs(-4),
        ['<c-p>'] = cmp.mapping.scroll_docs(4),

        ['q'] = cmp.mapping.close_docs(),

        ['<cr>'] = cmp.mapping.confirm({
          select = true,
        }),

        ['<tab>'] = cmp.mapping(cmp_next_selection, {
          'i',
          's',
        }),

        ['<s-tab>'] = cmp.mapping(cmp_previous_selection, {
          'i',
          's',
        }),

        ['<down>'] = cmp.mapping(cmp_next_selection, {
          'i',
          's',
        }),

        ['<up>'] = cmp.mapping(cmp_previous_selection, {
          'i',
          's',
        }),
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

    cmp.setup.cmdline({
      '/',
      '?',
    }, {
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
            ignore_cmds = {
              '!',
              'Man',
            },
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

    local catppuccin = require('catppuccin.palettes').get_palette('mocha')

    vim.api.nvim_set_hl(
      0,
      'Pmenu',
      { bg = catppuccin.base, fg = catppuccin.text }
    )

    vim.api.nvim_set_hl(
      0,
      'PmenuSel',
      { bg = catppuccin.teal, fg = catppuccin.teal }
    )

    vim.api.nvim_set_hl(
      0,
      'CmpItemAbbrDeprecated',
      { fg = '#7E8294', bg = 'NONE', strikethrough = true }
    )

    vim.api.nvim_set_hl(
      0,
      'CmpItemAbbrMatch',
      { fg = '#82AAFF', bg = 'NONE', bold = true }
    )

    vim.api.nvim_set_hl(
      0,
      'CmpItemAbbrMatchFuzzy',
      { fg = '#82AAFF', bg = 'NONE', bold = true }
    )

    vim.api.nvim_set_hl(
      0,
      'CmpItemMenu',
      { fg = '#C792EA', bg = 'NONE', italic = true }
    )

    vim.api.nvim_set_hl(
      0,
      'CmpItemKindField',
      { fg = '#EED8DA', bg = '#B5585F' }
    )

    vim.api.nvim_set_hl(
      0,
      'CmpItemKindProperty',
      { fg = '#EED8DA', bg = '#B5585F' }
    )

    vim.api.nvim_set_hl(
      0,
      'CmpItemKindEvent',
      { fg = '#EED8DA', bg = '#B5585F' }
    )

    vim.api.nvim_set_hl(
      0,
      'CmpItemKindText',
      { fg = '#C3E88D', bg = '#9FBD73' }
    )

    vim.api.nvim_set_hl(
      0,
      'CmpItemKindEnum',
      { fg = '#C3E88D', bg = '#9FBD73' }
    )

    vim.api.nvim_set_hl(
      0,
      'CmpItemKindKeyword',
      { fg = '#C3E88D', bg = '#9FBD73' }
    )

    vim.api.nvim_set_hl(
      0,
      'CmpItemKindConstant',
      { fg = '#FFE082', bg = '#D4BB6C' }
    )

    vim.api.nvim_set_hl(
      0,
      'CmpItemKindConstructor',
      { fg = '#FFE082', bg = '#D4BB6C' }
    )

    vim.api.nvim_set_hl(
      0,
      'CmpItemKindReference',
      { fg = '#FFE082', bg = '#D4BB6C' }
    )

    vim.api.nvim_set_hl(
      0,
      'CmpItemKindFunction',
      { fg = '#EADFF0', bg = '#A377BF' }
    )

    vim.api.nvim_set_hl(
      0,
      'CmpItemKindStruct',
      { fg = '#EADFF0', bg = '#A377BF' }
    )

    vim.api.nvim_set_hl(
      0,
      'CmpItemKindClass',
      { fg = '#EADFF0', bg = '#A377BF' }
    )

    vim.api.nvim_set_hl(
      0,
      'CmpItemKindModule',
      { fg = '#EADFF0', bg = '#A377BF' }
    )

    vim.api.nvim_set_hl(
      0,
      'CmpItemKindOperator',
      { fg = '#EADFF0', bg = '#A377BF' }
    )

    vim.api.nvim_set_hl(
      0,
      'CmpItemKindVariable',
      { fg = '#C5CDD9', bg = '#7E8294' }
    )

    vim.api.nvim_set_hl(
      0,
      'CmpItemKindFile',
      { fg = '#C5CDD9', bg = '#7E8294' }
    )

    vim.api.nvim_set_hl(
      0,
      'CmpItemKindUnit',
      { fg = '#F5EBD9', bg = '#D4A959' }
    )

    vim.api.nvim_set_hl(
      0,
      'CmpItemKindSnippet',
      { fg = '#F5EBD9', bg = '#D4A959' }
    )

    vim.api.nvim_set_hl(
      0,
      'CmpItemKindFolder',
      { fg = '#F5EBD9', bg = '#D4A959' }
    )

    vim.api.nvim_set_hl(
      0,
      'CmpItemKindMethod',
      { fg = '#DDE5F5', bg = '#6C8ED4' }
    )

    vim.api.nvim_set_hl(
      0,
      'CmpItemKindValue',
      { fg = '#DDE5F5', bg = '#6C8ED4' }
    )

    vim.api.nvim_set_hl(
      0,
      'CmpItemKindEnumMember',
      { fg = '#DDE5F5', bg = '#6C8ED4' }
    )

    vim.api.nvim_set_hl(
      0,
      'CmpItemKindInterface',
      { fg = '#D8EEEB', bg = '#58B5A8' }
    )

    vim.api.nvim_set_hl(
      0,
      'CmpItemKindColor',
      { fg = '#D8EEEB', bg = '#58B5A8' }
    )

    vim.api.nvim_set_hl(
      0,
      'CmpItemKindTypeParameter',
      { fg = '#D8EEEB', bg = '#58B5A8' }
    )
  end,
}
