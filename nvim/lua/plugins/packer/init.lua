return function(globals)
  local ensure_packer     = require'plugins.packer.ensure'(globals)
  local packer_extensions = require'plugins.packer.extensions'(globals)

  ensure_packer()

  require'packer'.startup({
    function(use)
      local created_extensions = packer_extensions.create(use)
      local use_spec           = created_extensions.use_spec
      local local_use_spec     = created_extensions.local_use_spec
      local local_use          = created_extensions.local_use

      use 'wbthomason/packer.nvim'

      use_spec {
        'catppuccin/nvim',
        as = 'catppuccin'
      }

      use_spec 'nvim-treesitter/nvim-treesitter'

      use_spec {
        'nvim-telescope/telescope.nvim',

        requires = {
          'nvim-lua/plenary.nvim',

          {
            'nvim-telescope/telescope-fzf-native.nvim',
            run = 'make'
          },

          'nvim-telescope/telescope-file-browser.nvim',
          'nvim-telescope/telescope-github.nvim',
          'nvim-telescope/telescope-z.nvim'
        }
      }

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

          {
            'j-hui/fidget.nvim',

            config = function()
              require'fidget'.setup {
                window = {
                  blend = 0
                }
              }
            end
          }
        }
      }

      use_spec {
        'lambdalisue/fern.vim',

        requires = {
          'ryanoasis/vim-devicons',
          'lambdalisue/fern-hijack.vim',
          'lambdalisue/nerdfont.vim',
          'lambdalisue/fern-renderer-nerdfont.vim',
          'lambdalisue/glyph-palette.vim',
          'andykog/fern-highlight.vim',
          'yuki-yano/fern-preview.vim'
        }
      }

      use_spec 'folke/which-key.nvim'

      use {
        'akinsho/bufferline.nvim',

        after = {
          'catppuccin',
          'nvim-web-devicons'
        },

        config = function()
          require'bufferline'.setup {
            highlights =
              require'catppuccin.groups.integrations.bufferline'.get(),

            options = {
              diagnostics     = 'nvim_lsp',
              numbers         = 'buffer_id',
              separator_style = 'thin',

              offsets = {
                {
                  filetype   = 'fern',
                  text       = 'Explorer',
                  text_align = 'center'
                }
              },
            }
          }
        end
      }

      use {
        'utilyre/barbecue.nvim',

        requires = 'SmiteshP/nvim-navic',

        after = {
          'catppuccin',
          'nvim-web-devicons'
        },

        config = function()
          require'barbecue'.setup {
            show_basename = false,
            theme         = 'catppuccin',

            symbols = {
              separator = '/'
            }
          }
        end
      }

      use 'rcarriga/nvim-notify'
      use 'folke/trouble.nvim'
      use 'TimUntersberger/neogit'
      use 'danilamihailov/beacon.nvim'
      use 'm-demare/hlargs.nvim'

      use_spec 'mbbill/undotree'
      use_spec 'numToStr/Comment.nvim'
      use_spec 'bfredl/nvim-miniyank'

      use {
        'norcalli/nvim-colorizer.lua',

        config = function()
          require'colorizer'.setup()
        end
      }

      use_spec 'easymotion/vim-easymotion'
      use_spec 'jpalardy/vim-slime'
      use_spec 'junegunn/vim-easy-align'
      use_spec 'terryma/vim-expand-region'

      use 'chaoren/vim-wordmotion'
      use 'FooSoft/vim-argwrap'
      use 'sickill/vim-pasta'
      use 'Wolfy87/vim-syntax-expand'

      use {
        'TamaMcGlinn/quickfixdd',
        ft = 'qf'
      }

      use 'tpope/vim-fugitive'
      use 'tpope/vim-eunuch'
      use 'tpope/vim-abolish'
      use 'tpope/vim-characterize'
      use 'tpope/vim-vinegar'

      use {
        'tpope/vim-unimpaired',
        requires = 'tpope/vim-repeat'
      }

      use {
        'tpope/vim-surround',
        requires = 'tpope/vim-repeat'
      }

      use_spec {
        'simrat39/rust-tools.nvim',
        ft = 'rust'
      }

      use_spec {
        'mhanberg/elixir.nvim',
        ft = 'elixir'
      }

      use {
        'elixir-editors/vim-elixir',
        ft = 'elixir'
      }

      use {
        'andyl/vim-textobj-elixir',
        requires = 'kana/vim-textobj-user',
        ft       = 'elixir'
      }

      use {
        'rhysd/vim-textobj-ruby',
        requires = 'kana/vim-textobj-user',
        ft       = 'ruby'
      }

      use {
        'bfredl/nvim-luadev',
        ft = 'lua'
      }

      use {
        'nvim-tree/nvim-web-devicons',

        config = function()
          require'nvim-web-devicons'.setup {
            color_icons = false
          }
        end
      }
    end,

    config = {
      autoremove = true
    }
  })
end
