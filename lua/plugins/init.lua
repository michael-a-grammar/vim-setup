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

local disabled = function(plugin)
  for _, disabled_plugin in ipairs(opts.disabled_plugins) do
    if plugin:find(disabled_plugin, 1, true) ~= nil then
      return true
    end
  end
  return false
end

local with_config = function(plugin)
  local to_strip = {
    '.*/',
    '%.nvim',
    '%-nvim',
    'nvim%.',
    'nvim%-',
    '%.vim',
    '%-vim',
    'vim%.',
    'vim%-'
  }

  local stripped = plugin

  for _, strip in ipairs(to_strip) do
    stripped = stripped:gsub(strip, '')
  end

  local config_path = 'plugins.config.' .. stripped

  local success, module = pcall(require, config_path)

  if success then
    return module
  end
end

local plug = function(spec)
  local plugin, merge_spec

  if type(spec) == 'table' then
    plugin      = spec[1]
    merge_spec  = spec
  else
    plugin      = spec
    merge_spec  = {
      plugin
    }
  end

  local config  = with_config(plugin)
  local disable = disabled(plugin)

  local new_spec = {
    config  = config,
    disable = disable
  }

  return vim.tbl_deep_extend('error', merge_spec, new_spec)
end

ensure_packer()

require'packer'.startup({
  function()
    local use_config = function(plugin_name)
      local config_path = 'plugins.config.' .. plugin_name

      return require(config_path)
    end

    local use_plug = function(plugin)
      local plug_plugin = plug(plugin)

      use(plug_plugin)
    end

    use 'wbthomason/packer.nvim'

    use {
      'dracula/vim',
      as = 'dracula'
    }

    use 'cocopon/iceberg.vim'
    use 'mhinz/vim-startify'

    use_plug {
      'vim-airline/vim-airline',
      requires = 'vim-airline/vim-airline-themes'
    }

    use_plug 'folke/which-key.nvim'

    use_plug {
      'nvim-telescope/telescope.nvim',
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

    use_plug {
      'nvim-treesitter/nvim-treesitter',
      requires = 'nvim-treesitter/playground'
    }

    use_plug {
      'scrooloose/nerdtree',
      requires = {
       'Xuyuanp/nerdtree-git-plugin',
       'ryanoasis/vim-devicons'
      }
    }

    use_plug 'easymotion/vim-easymotion'

    use_plug {
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

    use_plug {
      'mhanberg/elixir.nvim',
      ft = 'elixir'
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

    use_plug 'scrooloose/nerdcommenter'

    use_plug 'jpalardy/vim-slime'

    use_plug 'sjl/gundo.vim'

    use 'TamaMcGlinn/quickfixdd'

    use 'chaoren/vim-wordmotion'
    use 'FooSoft/vim-argwrap'

    use_plug 'junegunn/vim-easy-align'

    use_plug 'bfredl/nvim-miniyank'

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
