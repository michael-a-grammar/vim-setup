return {
  'michael-a-grammar/mona.nvim',

  dev = true,

  dependencies = {
    'folke/which-key.nvim',
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
  },

  keys = {
    {
      '<localleader>p',
      function()
        require('telescope').extensions.mona.elixir_project_modules()
      end,
      desc = 'Browse Project Modules',
      ft = 'elixir',
      mode = { 'n', 'x' },
    },

    {
      '<localleader>a',
      function()
        require('telescope').extensions.mona.elixir_application_modules()
      end,
      desc = 'Browse Application Modules',
      ft = 'elixir',
      mode = { 'n', 'x' },
    },

    {
      '<localleader>b',
      function()
        require('telescope').extensions.mona.elixir_buffer_directory_modules()
      end,
      desc = 'Browse Buffer Directory Modules',
      ft = 'elixir',
      mode = { 'n', 'x' },
    },

    {
      '<localleader>tp',
      function()
        require('telescope').extensions.mona.elixir_project_tests()
      end,
      desc = 'Browse Project Tests',
      ft = 'elixir',
      mode = { 'n', 'x' },
    },

    {
      '<localleader>ta',
      function()
        require('telescope').extensions.mona.elixir_application_tests()
      end,
      desc = 'Browse Application Tests',
      ft = 'elixir',
      mode = { 'n', 'x' },
    },

    {
      '<localleader>tb',
      function()
        require('telescope').extensions.mona.elixir_buffer_directory_tests()
      end,
      desc = 'Browse Buffer Directory Tests',
      ft = 'elixir',
      mode = { 'n', 'x' },
    },
  },

  config = function(_, _)
    local to_add = {
      {
        mode = {
          'n',
          'x',
        },

        {
          '<localleader>',
          group = ' mona',
        },

        {
          '<localleader>t',
          group = 'Tests',
        },
      },
    }

    local which_key = require('which-key')

    which_key.add(to_add)
  end,
}
