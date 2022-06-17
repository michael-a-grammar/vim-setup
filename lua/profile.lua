if vim.g.use_lsp then
  require('packer').startup(function()
    use 'wbthomason/packer.nvim'
    use 'nvim-lua/plenary.nvim'
    use 'neovim/nvim-lspconfig'
    use 'onsails/lspkind.nvim'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/vim-vsnip'

    use 'hrsh7th/cmp-nvim-lsp'
    use 'ray-x/cmp-treesitter'
    use 'hrsh7th/cmp-nvim-lsp-signature-help'
    use 'hrsh7th/cmp-vsnip'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-nvim-lua'
    use 'f3fora/cmp-spell'
    use 'hrsh7th/cmp-calc'

    use 'hrsh7th/cmp-nvim-lsp-document-symbol'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'

    use({
      'mhanberg/elixir.nvim',
      requires = {
        'nvim-lua/plenary.nvim',
        'neovim/nvim-lspconfig'
      }})
  end)
end

require('gitsigns').setup()

require('telescope').load_extension('fzf')
require('telescope').load_extension('gh')
require('telescope').load_extension('z')

if vim.g.use_coc then
  require('telescope').load_extension('coc')
end

require('nvim-treesitter.configs').setup({
  ensure_installed = {
    'elixir',
    'fish',
    'lua',
    'javascript',
    'markdown',
    'ruby',
    'typescript',
    'vim'
  },
  sync_install = false,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = true,
  },
})

if vim.g.use_lsp then
  local has_words_before = function()
    local line, col =unpack(vim.api.nvim_win_get_cursor(0))

    return col ~= 0
      and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]
        :sub(col, col)
        :match("%s") == nil
  end

  local feedkeys = function(key, mode)
    vim.api.nvim_feedkeys(
      vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
  end

  local cmp     = require('cmp')
  local lspkind = require('lspkind')

  cmp.setup({
    enabled = function()
      local context = require 'cmp.config.context'
      if vim.api.nvim_get_mode().mode == 'c' then
        return true
      else
        return not context.in_treesitter_capture('comment')
          and not context.in_syntax_group('Comment')
      end
    end,
    formatting = {
      format = lspkind.cmp_format({
        mode     = 'symbol_text',
        maxwidth = 50,
        menu = ({
          buffer                   = '[Buffer]',
          calc                     = '[Calc]',
          cmdline                  = '[CMD]',
          nvim_lsp                 = '[LSP]',
          nvim_lsp_document_symbol = '[LSP DS]',
          nvim_lsp_signature_help  = '[LSP SH]',
          nvim_lua                 = '[Lua]',
          path                     = '[Path]',
          spell                    = '[Spell]',
          treesitter               = '[Treesitter]',
          vsnip                    = '[vsnip]'
        })
      })
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
    mapping = cmp.mapping.preset.insert({
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
          feedkey('<plug>(vsnip-jump-prev)', '')
        end
      end, { 'i', 's' }),

      ['<c-e>']     = cmp.mapping.scroll_docs(-4),
      ['<c-n>']     = cmp.mapping.scroll_docs(4),
      ['<c-space>'] = cmp.mapping.complete(),
      ['<cr>']      = cmp.mapping.confirm({ select = true }),
      ['<esc>']     = cmp.mapping.abort()
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp'   },
      { name = 'treesitter' },
    },
    {
      { name = 'nvim_lsp_signature_help' },
      { name = 'vsnip'                   },
    },
    {
      { name = 'buffer' }
    },
    {
      { name = 'nvim_lua' },
      { name = 'calc'     },
      { name = 'spell'    }
    })
  })

  cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'nvim_lsp_document_symbol' }
    },
    {
      { name = 'buffer' }
    }
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

  local capabilities =
    require('cmp_nvim_lsp')
      .update_capabilities(vim.lsp.protocol.make_client_capabilities())

  local elixir = require('elixir')

  elixir.setup({
    settings           = elixir.settings({
      dialyzerEnabled  = true,
      fetchDeps        = false,
      enableTestLenses = true,
      suggestSpecs     = false,
    }),

    on_attach = function(client, buffer_number)
      local map_opts = {
        buffer  = true,
        noremap = true
      }

      local keymap_set = function(mode, mnemonic, command)
        vim.keymap.set(
          mode,
          mnemonic,
          '<cmd>' .. command .. '<cr>',
          map_opts)
      end

      local keymap_set_v = function(mnemonic, command)
        keymap_set('v', mnemonic, command)
      end

      local keymap_set_n = function(mnemonic, command)
        keymap_set('n', mnemonic, command)
      end

      keymap_set_v('<localleader>em', 'ElixirExpandMacro')

      keymap_set_n('<localleader>pf', 'ElixirFromPipe')
      keymap_set_n('<localleader>pt', 'ElixirToPipe')
      keymap_set_n('<localleader>rr', 'lua vim.lsp.codelens.run()')

      keymap_set_n('gd', 'lua vim.lsp.buf.definition()')
      keymap_set_n('gD', 'lua vim.lsp.buf.implementation()')
      keymap_set_n('<leader>dh', 'lua vim.lsp.buf.hover()')
      keymap_set_n('<leader>ee', 'lua vim.diagnostic.open_float()')
      keymap_set_n('<leader>gd', 'lua vim.lsp.buf.type_definition()')
      keymap_set_n('<leader>rf', 'lua vim.lsp.buf.format()')

      vim.cmd([[imap <expr> <c-l> vsnip#available(1) ? '<plug>(vsnip-expand-or-jump)' : '<c-l>']])
      vim.cmd([[smap <expr> <c-l> vsnip#available(1) ? '<plug>(vsnip-expand-or-jump)' : '<c-l>']])

      require('cmp_nvim_lsp').update_capabilities(capabilities)
    end
  })
end

