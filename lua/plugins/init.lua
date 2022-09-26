local fn   = vim.fn
local opts = require 'opts'

local ensure_packer = function()
  local install_path =
    fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

  if fn.empty(fn.glob(install_path)) > 0 then
    local repo = 'https://github.com/wbthomason/packer.nvim'

    fn.system({ 'git', 'clone', '--depth', '1', repo, install_path })
  end
end

local disabled = function(self, plugin)
  for _, disabled_plugin in ipairs(opts.disabled_plugins) do
    if plugin:find(disabled_plugin, 1 true) ~= nil then
      return true
    end
  end
  return false
end

local with_config = function(plugin)
  local config_path = 'plugins.config.' .. plugin

  return function()
    pcall(require, config_path)
  end
end

local plug = function(plugin)
  local plugin_name, merge_spec

  if type(plugin) == 'table' then
    plugin_name = plugin[1]
    merge_spec  = plugin
  else
    plugin_name = plugin
    merge_spec  = {
      plugin_name
    }
  end

  local config  = with_config(plugin_name)
  local disable = disabled(plugin_name)

  local spec = {
    config  = config,
    disable = disable
  }

  return vim.tbl_deep_extend('error', merge_spec, spec)
end

ensure_packer()

require'packer'.startup({
  function()
    local use_config = function(plugin_name)
      local config_path = 'plugins.config.' .. plugin_name
      return require(config_path)
    end

    use 'wbthomason/packer.nvim'

    use {
      'dracula/vim',
      as = 'dracula'
    }

    use 'cocopon/iceberg.vim'
    use 'mhinz/vim-startify'

    plug {
      'vim-airline/vim-airline',
      requires = 'vim-airline/vim-airline-themes'
    }

    use {
      'folke/which-key.nvim',
      config  = use_config 'which-key',
      disable = true
    }

    use {
      'nvim-telescope/telescope.nvim',
      config   = use_config 'telescope',
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
      config   = use_config 'treesitter',
      disable  = false,
      requires = 'nvim-treesitter/playground'
    }

    use {
      'scrooloose/nerdtree',
      config   = use_config 'nerdtree',
      disable  = false,
      requires = {
       'Xuyuanp/nerdtree-git-plugin',
       'ryanoasis/vim-devicons'
      }
    }

    use {
      'easymotion/vim-easymotion',
      config  = use_config 'easymotion',
      disable = false
    }

    use {
      'hrsh7th/nvim-cmp',
      config   = use_config 'cmp',
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
      config = use_config 'nerdcommenter'
    }

    use {
      'jpalardy/vim-slime',
      config = use_config 'slime'
    }

    use {
      'sjl/gundo.vim',
      config = use_config 'gundo'
    }

    use 'TamaMcGlinn/quickfixdd'

    use 'chaoren/vim-wordmotion'
    use 'FooSoft/vim-argwrap'

    use {
      'junegunn/vim-easy-align',
      config = use_config 'easyalign'
    }

    use {
      'bfredl/nvim-miniyank',
      config = use_config 'miniyank'
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
  end,
  config = {
    autoremove = true
  }
})
