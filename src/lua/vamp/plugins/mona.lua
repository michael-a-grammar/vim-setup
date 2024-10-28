return {
  "michael-a-grammar/mona.nvim",

  dev = true,

  dependencies = {
    "folke/which-key.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },

  keys = {
    {
      "<localleader><localleader>",
      function()
        require("telescope").extensions.mona.pickers()
      end,
      desc = "Pickers",
      ft = "elixir",
      mode = { "n", "x" },
    },

    {
      "<localleader>a",
      function()
        require("telescope").extensions.mona.elixir_application_modules()
      end,
      desc = "Application Modules",
      ft = "elixir",
      mode = { "n", "x" },
    },

    {
      "<localleader>n",
      function()
        require("telescope").extensions.mona.elixir_buffer_directory_modules()
      end,
      desc = "Buffer Directory Modules",
      ft = "elixir",
      mode = { "n", "x" },
    },

    {
      "<localleader>p",
      function()
        require("telescope").extensions.mona.elixir_project_modules()
      end,
      desc = "Project Modules",
      ft = "elixir",
      mode = { "n", "x" },
    },

    {
      "<localleader>ta",
      function()
        require("telescope").extensions.mona.elixir_application_tests()
      end,
      desc = "Application Tests",
      ft = "elixir",
      mode = { "n", "x" },
    },

    {
      "<localleader>tn",
      function()
        require("telescope").extensions.mona.elixir_buffer_directory_tests()
      end,
      desc = "Buffer Directory Tests",
      ft = "elixir",
      mode = { "n", "x" },
    },

    {
      "<localleader>tp",
      function()
        require("telescope").extensions.mona.elixir_project_tests()
      end,
      desc = "Project Tests",
      ft = "elixir",
      mode = { "n", "x" },
    },

    {
      "<leader>zm",
      function()
        vim.print(vim.inspect(require("mona.__debug")()))
      end,
      desc = " ",
      mode = { "n", "x" },
    },
  },

  opts = {
    extensions = {
      bufferline = true,
      grug_far = true,
      toggleterm = true,
    },
  },

  config = function(_, opts)
    require("mona").setup(opts)

    local to_add = {
      {
        mode = {
          "n",
          "x",
        },

        {
          "<localleader>",
          group = " mona",
        },

        {
          "<localleader>t",
          "Modules"
        },

        {
          "<localleader>mt",
          group = "Tests",
        },
      },
    }

    local which_key = require("which-key")

    which_key.add(to_add)
  end,
}
