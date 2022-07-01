local telescope         = require('telescope')
local telescope_builtin = require('telescope.builtin')

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

local pickers = {
  'buffers',
  'command_history',
  'commands',
  'current_buffer_fuzzy_find',
  'diagnostics',
  'find_files',
  'git_bcommits',
  'git_branches',
  'git_commits',
  'git_files',
  'git_status',
  'grep_string',
  'jumplist',
  'live_grep',
  'loclist',
  'lsp_definitions',
  'lsp_document_symbols',
  'lsp_dynamic_workspace_symbols',
  'lsp_implementations',
  'lsp_references',
  'lsp_workspace_symbols',
  'marks',
  'oldfiles',
  'quickfix',
  'quickfixhistory',
  'search_history',
  'treesitter',
  'workspace_symbols'
}

local pickers_configuration = {}

for _, picker in ipairs(pickers) do
  pickers_configuration[picker] = {
    theme = 'ivy'
  }
end

telescope.setup({
  defaults = {
    path_display = {
      truncate = 1
    }
  },
  pickers = pickers_configuration
})

telescope.load_extension('fzf')
telescope.load_extension('gh')
telescope.load_extension('z')

if vim.g.use_coc then
  telescope.load_extension('coc')
end

require('nvim-treesitter.configs').setup({
  ensure_installed = {
    'elixir',
    'eex',
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
    additional_vim_regex_highlighting = false,
  },
})

if vim.g.use_lsp then
  local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))

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

      ['<c-p>']     = cmp.mapping.scroll_docs(-4),
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
      dialyzerEnabled  = false,
      enableTestLenses = false,
      fetchDeps        = false,
      suggestSpecs     = false
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

      local keymap_set_n = function(mnemonic, command)
        keymap_set('n', mnemonic, command)
      end

      local keymap_set_v = function(mnemonic, command)
        keymap_set('v', mnemonic, command)
      end

      local keymap_set_x = function(mnemonic, command)
        keymap_set('x', mnemonic, command)
      end

      keymap_set_n('<localleader>f', '%!mix format -')
      keymap_set_n('<localleader>i', [[call Slime('iex', 'exs')]])
      keymap_set_n('<localleader>pf', 'ElixirFromPipe')
      keymap_set_n('<localleader>pt', 'ElixirToPipe')
      keymap_set_v('<localleader>em', 'ElixirExpandMacro')
      keymap_set_x('<localleader>i', [[call Slime('iex', 'exs')]])

      vim.cmd([[imap <expr> <c-l> vsnip#available(1) ? '<plug>(vsnip-expand-or-jump)' : '<c-l>']])
      vim.cmd([[smap <expr> <c-l> vsnip#available(1) ? '<plug>(vsnip-expand-or-jump)' : '<c-l>']])


      require('cmp_nvim_lsp').update_capabilities(capabilities)
    end
  })

  local elixir_find_files = function()
    require('telescope.builtin').find_files({
      prompt_title = 'Find Files (Elixir)',
      find_command = { 'rg', '--type', 'elixir', '--files' }
    })
  end

  vim.keymap.set('n', '<localleader>sf', elixir_find_files)

end

