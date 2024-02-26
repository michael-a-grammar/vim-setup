require'elden.packer.ensure'()

require'packer'.startup({
  function(use)
    local packer_extensions = require'elden.packer.extensions'(use)
    local plugin_spec       = packer_extensions.plugin_spec
    local local_plugin_spec = packer_extensions.local_plugin_spec
    local local_plugin      = packer_extensions.local_plugin

    use 'wbthomason/packer.nvim'


    use {
      'L3MON4D3/LuaSnip',
      run = 'make install_jsregexp',
    }

    plugin_spec 'folke/which-key.nvim'

    plugin_spec {
      'nvim-telescope/telescope.nvim',

      requires = {
        'nvim-lua/plenary.nvim',

        {
          'nvim-telescope/telescope-fzf-native.nvim',
          run = 'make',
        },

        'nvim-telescope/telescope-file-browser.nvim',
        'nvim-telescope/telescope-github.nvim',
        'nvim-telescope/telescope-z.nvim',
      },
    }

    use {
      'akinsho/bufferline.nvim',

      after = {
        'nvim-web-devicons',
      },

      config = function()
        require'bufferline'.setup {
          highlights =
            require'catppuccin.groups.integrations.bufferline'.get(),

          options = {
            diagnostics     = 'nvim_lsp',
            numbers         = 'both',
            separator_style = 'thin',
            show_close_icon = false,

            diagnostics_indicator = function(count, level, diagnostics_dict, context)
              if context.buffer:current() then
                return ''
              end

              return ''
            end,

            offsets = {
              {
                filetype   = 'fern',
                text       = '󰌪',
                text_align = 'center'
              },
              {
                filetype   = 'Outline',
                text       = '󰊕',
                text_align = 'center'
              },
              {
                filetype   = 'packer',
                text       = '',
                text_align = 'center',
              },
              {
                filetype   = 'undotree',
                text       = '󰕌',
                text_align = 'center',
              },
            },
          },
        }
      end
    }

    use {
      'utilyre/barbecue.nvim',

      requires = 'SmiteshP/nvim-navic',

      after = {
        'nvim-web-devicons',
      },

      config = function()
        require'barbecue'.setup {
          show_basename = false,
          --theme         = 'catppuccin',

          symbols = {
            separator = '',
          },
        }
      end
    }

    plugin_spec {
      'lambdalisue/fern.vim',

      requires = {
        'lambdalisue/fern-hijack.vim',
        'lambdalisue/nerdfont.vim',
        'lambdalisue/fern-renderer-nerdfont.vim',
        'lambdalisue/glyph-palette.vim',
        'andykog/fern-highlight.vim',
        'yuki-yano/fern-preview.vim',
      },
    }

    plugin_spec 'voldikss/vim-floaterm'

    use 'folke/trouble.nvim'
    use 'TimUntersberger/neogit'

    plugin_spec 'mbbill/undotree'

    use {
      'simrat39/symbols-outline.nvim',

      config = function()
        require'symbols-outline'.setup()
      end,
    }

    use {
      'rcarriga/nvim-notify',

      config = function()
        local notify = require'notify'

        notify.setup {
          render = 'compact',
          stages = 'fade',
        }

        vim.notify = notify
      end,
    }

    use 'danilamihailov/beacon.nvim'

    use 'm-demare/hlargs.nvim'

    -- plugin_spec 'numToStr/Comment.nvim'
    plugin_spec 'bfredl/nvim-miniyank'

    use {
      'norcalli/nvim-colorizer.lua',

      config = function()
        require'colorizer'.setup()
      end,
    }

    plugin_spec 'easymotion/vim-easymotion'
    plugin_spec 'jpalardy/vim-slime'
    plugin_spec 'junegunn/vim-easy-align'
    plugin_spec 'terryma/vim-expand-region'

    use {
      'TamaMcGlinn/quickfixdd',
      ft = 'qf',
    }

    use 'tpope/vim-projectionist'
    use 'tpope/vim-fugitive'
    use 'tpope/vim-eunuch'
    use 'tpope/vim-abolish'
    use 'tpope/vim-characterize'
    use 'tpope/vim-vinegar'

    use {
      'tpope/vim-unimpaired',
      requires = 'tpope/vim-repeat',
    }

    use {
      'tpope/vim-surround',
      requires = 'tpope/vim-repeat',
    }

  end,

  config = {
    autoremove = true,
  },
})
