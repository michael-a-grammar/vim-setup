return function(env)
  local ensure_packer     = require'plugins.packer.ensure'(env)
  local packer_extensions = require'plugins.packer.extensions'(env)

  ensure_packer()

  require'packer'.startup({
    function(use)
      local created_extensions = packer_extensions.create(use)
      local use_spec           = created_extensions.use_spec
      local local_use_spec     = created_extensions.local_use_spec
      local local_use          = created_extensions.local_use

      use 'wbthomason/packer.nvim'

      use {
        'catppuccin/nvim',
        as = 'catppuccin',
      }

      use_spec 'nvim-treesitter/nvim-treesitter'

      use {
        'glepnir/dashboard-nvim',

        event = 'VimEnter',

        config = function()
          require'dashboard'.setup {

          }
        end,
      }

      use_spec 'nvim-lualine/lualine.nvim'

      use_spec {
        'hrsh7th/nvim-cmp',

        requires = {
          'neovim/nvim-lspconfig',

          'hrsh7th/cmp-nvim-lsp',
          'hrsh7th/cmp-nvim-lsp-document-symbol',
          'hrsh7th/cmp-nvim-lsp-signature-help',

          'hrsh7th/cmp-buffer',
          'hrsh7th/cmp-calc',

          'hrsh7th/cmp-path',
          'hrsh7th/cmp-cmdline',

          'hrsh7th/cmp-nvim-lua',

          'onsails/lspkind.nvim',
        }
      }

      use {
        'L3MON4D3/LuaSnip',
        run = 'make install_jsregexp',
      }

      use_spec 'folke/which-key.nvim'

      use_spec {
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
          'catppuccin',
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
          'catppuccin',
          'nvim-web-devicons',
        },

        config = function()
          require'barbecue'.setup {
            show_basename = false,
            theme         = 'catppuccin',

            symbols = {
              separator = '',
            },
          }
        end
      }

      use_spec {
        'lambdalisue/fern.vim',

        requires = {
          'lambdalisue/fern-hijack.vim',
          'lambdalisue/nerdfont.vim',
          'lambdalisue/fern-renderer-nerdfont.vim',
          'lambdalisue/glyph-palette.vim',
          'andykog/fern-highlight.vim',
          'yuki-yano/fern-preview.vim',
        }
      }

      use 'folke/trouble.nvim'
      use 'TimUntersberger/neogit'

      use_spec 'mbbill/undotree'

      use {
        'simrat39/symbols-outline.nvim',

        config = function()
          require'symbols-outline'.setup()
        end,
      }

      use {
        'rcarriga/nvim-notify',

        config = function()
          vim.notify = require'notify'
        end,
      }

      use {
        'mrded/nvim-lsp-notify',

        after = 'nvim-notify',

        config = function()
          require'lsp-notify'.setup()
        end,
      }

      use 'danilamihailov/beacon.nvim'
      use 'm-demare/hlargs.nvim'

      use_spec 'numToStr/Comment.nvim'
      use_spec 'bfredl/nvim-miniyank'

      use {
        'norcalli/nvim-colorizer.lua',

        config = function()
          require'colorizer'.setup()
        end,
      }

      use_spec 'easymotion/vim-easymotion'
      use_spec 'jpalardy/vim-slime'
      use_spec 'junegunn/vim-easy-align'
      use_spec 'terryma/vim-expand-region'

      use {
        'TamaMcGlinn/quickfixdd',
        ft = 'qf',
      }

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

      use_spec {
        'simrat39/rust-tools.nvim',
        ft = 'rust',
      }

      use_spec {
        'mhanberg/elixir.nvim',
        ft = 'elixir',
      }

      use {
        'elixir-editors/vim-elixir',
        ft = 'elixir',
      }

      use {
        'andyl/vim-textobj-elixir',
        requires = 'kana/vim-textobj-user',
        ft       = 'elixir',
      }

      use {
        'rhysd/vim-textobj-ruby',
        requires = 'kana/vim-textobj-user',
        ft       = 'ruby',
      }

      use {
        'bfredl/nvim-luadev',
        ft = 'lua',
      }

      use {
        'nvim-tree/nvim-web-devicons',

        config = function()
          require'nvim-web-devicons'.setup {
            color_icons = false,
          }
        end,
      }
    end,

    config = {
      autoremove = true,
    },
  })
end
