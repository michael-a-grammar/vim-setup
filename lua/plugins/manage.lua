local ensure_packer = function()
  local fn = vim.fn

  local install_path =
    fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

  if fn.empty(fn.glob(install_path)) > 0 then
    local repo = 'https://github.com/wbthomason/packer.nvim'

    local packer_bootstrap =
      fn.system({ 'git', 'clone', '--depth', '1', repo, install_path })
  end
end

local packer = function()
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
      disable = false
    }

    use {
      'vim-airline/vim-airline-themes',
      disable = false
    }

    use {
      'folke/which-key.nvim',
      disable = false
    }

    use 'nvim-lua/plenary.nvim'
    use 'nvim-telescope/telescope.nvim'

    use {
      'nvim-telescope/telescope-fzf-native.nvim',
      run = 'make'
    }

    use 'nvim-telescope/telescope-file-browser.nvim'
    use 'nvim-telescope/telescope-github.nvim'
    use 'nvim-telescope/telescope-z.nvim'

    use 'nvim-treesitter/nvim-treesitter'
    use 'nvim-treesitter/playground'

    use 'kyazdani42/nvim-web-devicons'

    use 'folke/lua-dev.nvim'

    use 'scrooloose/nerdtree'
    use 'Xuyuanp/nerdtree-git-plugin'

    use 'scrooloose/nerdcommenter'

    use 'honza/vim-snippets'

    use 'tpope/vim-fugitive'

    use 'TamaMcGlinn/quickfixdd'
    use 'jpalardy/vim-slime'

    use 'easymotion/vim-easymotion'

    use 'sjl/gundo.vim'

    use 'bfredl/nvim-miniyank'

    use 'tpope/vim-vinegar'
    use 'tpope/vim-repeat'
    use 'tpope/vim-eunuch'
    use 'tpope/vim-unimpaired'
    use 'tpope/vim-surround'
    use 'tpope/vim-abolish'
    use 'tpope/vim-characterize'

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

    use 'ryanoasis/vim-devicons'

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

    use 'mhanberg/elixir.nvim'
  end)
end

return function()
  ensure_packer()
  packer()
end
