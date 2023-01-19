return function(globals)
  local ensure     = require'plugins.packer.ensure'(globals)
  local extensions = require'plugins.packer.extensions'(globals)

  ensure()

  require'packer'.startup({
    function(use)
      local created_extensions = extensions.create(use)
      local use_spec           = created_extensions.use_spec
      local local_use_spec     = created_extensions.local_use_spec
      local local_use          = created_extensions.local_use

      use 'wbthomason/packer.nvim'

      use {
        'dracula/vim',
        as = 'dracula'
      }

      use 'cocopon/iceberg.vim'

      use 'mhinz/vim-startify'

      use_spec {
        'vim-airline/vim-airline',
        requires = 'vim-airline/vim-airline-themes'
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

          {
            'ray-x/cmp-treesitter',
            requires = 'nvim-treesitter'
          },

          'hrsh7th/cmp-nvim-lsp',
          'hrsh7th/cmp-nvim-lsp-document-symbol',
          'hrsh7th/cmp-nvim-lsp-signature-help',

          'hrsh7th/cmp-buffer',
          'f3fora/cmp-spell',
          'hrsh7th/cmp-calc',

          'hrsh7th/cmp-path',
          'hrsh7th/cmp-cmdline',

          'hrsh7th/cmp-nvim-lua',

          'onsails/lspkind.nvim'
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
        'ryanoasis/vim-devicons',
        after = {
          'vim-startify',
          'vim-airline'
        }
      }

      use 'kyazdani42/nvim-web-devicons'
    end,
    config = {
      autoremove = true
    }
  })
end
