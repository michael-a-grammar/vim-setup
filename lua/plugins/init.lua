local fn = vim.fn

local install_path =
  fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  local repo = 'https://github.com/wbthomason/packer.nvim'

  local packer_bootstrap =
    fn.system({ 'git', 'clone', '--depth', '1', repo, install_path })
end

local packer = require'packer'

packer.init({
  autoremove = true
})

packer.startup(function()
  local config = function(plugin_name)
    local plugin_path = 'plugins.config.' .. plugin_name
    return require(plugin_path)
  end

  use 'wbthomason/packer.nvim'

  use {
    'dracula/vim',
    as = 'dracula'
  }

  use 'cocopon/iceberg.vim'
  use 'mhinz/vim-startify'

  use {
    'vim-airline/vim-airline',
    config   = config 'airline',
    disable  = false,
    requires = 'vim-airline/vim-airline-themes'
  }

  use {
    'folke/which-key.nvim',
    config  = config 'which-key',
    disable = true
  }

  use {
    'nvim-telescope/telescope.nvim',
    config   = config 'telescope',
    disable  = false,
    requires = {
      'nvim-lua/plenary.nvim',

      {
        'nvim-telescope/telescope-fzf-native.nvim',
        run = 'make'
      },

      'nvim-telescope/telescope-file-browser.nvim',
      'nvim-telescope/telescope-github.nvim',
      'nvim-telescope/telescope-z.nvim',

      'kyazdani42/nvim-web-devicons'
    }
  }

  use {
    'nvim-treesitter/nvim-treesitter',
    config   = config 'treesitter',
    disable  = false,
    requires = 'nvim-treesitter/playground'
  }

  use {
    'scrooloose/nerdtree',
    config   = config 'nerdtree',
    disable  = false,
    requires = {
     'Xuyuanp/nerdtree-git-plugin',
     'ryanoasis/vim-devicons'
    }
  }

  use {
    'easymotion/vim-easymotion',
    config   = config 'easymotion',
    disable = false
  }

  use {
    'hrsh7th/nvim-cmp',
    config   = config 'cmp',
    disable  = false,
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

  use {
    'mhanberg/elixir.nvim',
    disable  = false,
    requires = 'nvim-cmp'
  }

  use 'tpope/vim-fugitive'
  use 'tpope/vim-eunuch'
  use 'tpope/vim-abolish'
  use 'tpope/vim-characterize'

  use {
    'tpope/vim-unimpaired',
    requires = 'tpope/vim-repeat'
  }

  use {
    'tpope/vim-surround',
    requires = 'tpope/vim-repeat'
  }

  use {
    'scrooloose/nerdcommenter',
    config = config 'nerdcommenter'
  }

  use {
    'jpalardy/vim-slime',
    config = config 'slime'
  }

  use {
    'sjl/gundo.vim',
    config = config 'gundo'
  }

  use 'TamaMcGlinn/quickfixdd'

  use 'chaoren/vim-wordmotion'
  use 'FooSoft/vim-argwrap'

  use {
    'junegunn/vim-easy-align',
    config = config 'easyalign'
  }

  use {
    'bfredl/nvim-miniyank',
    config = config 'miniyank'
  }

  use 'sickill/vim-pasta'
  use 'Wolfy87/vim-syntax-expand'

  use 'elixir-editors/vim-elixir'
  use 'leafo/moonscript-vim'

  use {
    'andyl/vim-textobj-elixir',
    requires = 'kana/vim-textobj-user'
  }

  use {
    'rhysd/vim-textobj-ruby',
    requires = 'kana/vim-textobj-user'
  }
end)
