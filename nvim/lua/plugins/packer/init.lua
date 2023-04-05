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

      use 'mhinz/vim-startify'

      use_spec {
        'vim-airline/vim-airline',
        requires = {
          'vim-airline/vim-airline-themes',
          'dawikur/base16-vim-airline-themes'
        }
      }

      use_spec {
        'nvim-treesitter/nvim-treesitter',
        requires = 'nvim-treesitter/playground'
      }

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
              require'fidget'.setup()
            end
          }
        }
      }

      use_spec 'folke/which-key.nvim'

      use 'rcarriga/nvim-notify'

      use_spec {
        'lambdalisue/fern.vim',
        requires = {
          'lambdalisue/fern-hijack.vim',
          'lambdalisue/nerdfont.vim',
          'lambdalisue/fern-renderer-nerdfont.vim',
          'lambdalisue/glyph-palette.vim'
        }
      }

      use_spec 'easymotion/vim-easymotion'
      use_spec 'jpalardy/vim-slime'
      use_spec 'numToStr/Comment.nvim'
      use_spec 'junegunn/vim-easy-align'
      use_spec 'terryma/vim-expand-region'
      use_spec 'bfredl/nvim-miniyank'

      use 'chaoren/vim-wordmotion'
      use 'FooSoft/vim-argwrap'
      use 'sickill/vim-pasta'
      use 'Wolfy87/vim-syntax-expand'

      use_spec 'mbbill/undotree'

      use 'TimUntersberger/neogit'

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
        'rust-lang/rust.vim',
        ft = 'rust'
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
        'norcalli/nvim-colorizer.lua',
        config = function()
          require'colorizer'.setup()
        end
      }

      use {
        'ryanoasis/vim-devicons',
        after = {
          'vim-startify',
          'vim-airline'
        }
      }

      use {
        'kyazdani42/nvim-web-devicons',
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
