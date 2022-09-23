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

require'packer'.startup(function()
  use 'wbthomason/packer.nvim'

  use {
    'dracula/vim',
    as = 'dracula'
  }

  use 'cocopon/iceberg.vim'

  use 'mhinz/vim-startify'

  use {
    'vim-airline/vim-airline',
    disable  = false,
    requires = 'vim-airline/vim-airline-themes'
  }

  use {
    'folke/which-key.nvim',
    disable = true
  }

  use {
    'nvim-telescope/telescope.nvim',
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

      use 'kyazdani42/nvim-web-devicons'
    }
  }

  use {
    'nvim-treesitter/nvim-treesitter',
    disable  = false,
    requires = 'nvim-treesitter/playground'
  }

  use {
    'scrooloose/nerdtree',
    disable  = false,
    requires = {
     'Xuyuanp/nerdtree-git-plugin',
     'ryanoasis/vim-devicons'
    }
  }

  use {
    'easymotion/vim-easymotion',
    disable = false
  }

  use {

  }


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



  use 'tpope/vim-repeat'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-eunuch'
  use 'tpope/vim-unimpaired'
  use 'tpope/vim-surround'
  use 'tpope/vim-abolish'
  use 'tpope/vim-characterize'

  use 'scrooloose/nerdcommenter'
  use 'TamaMcGlinn/quickfixdd'
  use 'jpalardy/vim-slime'
  use 'sjl/gundo.vim'
  use 'bfredl/nvim-miniyank'

  use 'chaoren/vim-wordmotion'

  use 'junegunn/vim-easy-align'
  use 'FooSoft/vim-argwrap'

  use 'sickill/vim-pasta'

  use 'Wolfy87/vim-syntax-expand'

  use 'kana/vim-textobj-user'

  use 'elixir-editors/vim-elixir'
  use 'leafo/moonscript-vim'

  use 'andyl/vim-textobj-elixir'
  use 'rhysd/vim-textobj-ruby'

  use 'mhanberg/elixir.nvim'
end)
