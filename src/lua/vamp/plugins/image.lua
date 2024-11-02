return {
  "3rd/image.nvim",

  dependencies = {
    "leafo/magick",
    "nvim-treesitter/nvim-treesitter",

    {
      "vhyrro/luarocks.nvim",
      opts = {
        rocks = {
          hererocks = true,
        },
      },
    },
  },

  opts = {
    backend = "kitty",
    integrations = {
      markdown = {
        enabled = true,
        clear_in_insert_mode = false,
        download_remote_images = true,
        only_render_image_at_cursor = false,
        filetypes = {
          "markdown",
          "vimwiki",
        },
      },
      neorg = {
        enabled = true,
        clear_in_insert_mode = false,
        download_remote_images = true,
        only_render_image_at_cursor = false,
        filetypes = {
          "norg",
        },
      },
    },
    max_width = nil,
    max_height = nil,
    max_width_window_percentage = nil,
    max_height_window_percentage = 50,
    kitty_method = "normal",
  },
}
