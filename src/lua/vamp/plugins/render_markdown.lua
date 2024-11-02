return {
  "MeanderingProgrammer/render-markdown.nvim",

  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },

  opts = {
    heading = {
      border = true,
      icons = { " ", " ", " ", " ", " ", " " },
      left_pad = 0.5,
    },

    link = {
      image = "",
    },
  },
}
