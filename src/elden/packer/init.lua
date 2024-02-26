require'elden.packer.ensure'()

require'packer'.startup({
  function(use)
    local packer_extensions = require'elden.packer.extensions'(use)
    local plugin_spec       = packer_extensions.plugin_spec
    local local_plugin_spec = packer_extensions.local_plugin_spec
    local local_plugin      = packer_extensions.local_plugin

    use 'wbthomason/packer.nvim'

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

    -- plugin_spec 'numToStr/Comment.nvim'
    plugin_spec 'bfredl/nvim-miniyank'

    plugin_spec 'easymotion/vim-easymotion'
    plugin_spec 'jpalardy/vim-slime'
    plugin_spec 'junegunn/vim-easy-align'
    plugin_spec 'terryma/vim-expand-region'

  end,

  config = {
    autoremove = true,
  },
})
