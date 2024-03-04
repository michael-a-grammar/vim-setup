return {
  {
    'utilyre/barbecue.nvim',
    name = 'barbecue',

    dependencies = {
      'SmiteshP/nvim-navic',
      'nvim-tree/nvim-web-devicons',
    },

    opts = {
      show_basename = false,
      theme = 'catppuccin',

      symbols = {
        separator = '',
      },
    },

    config = function(_, opts)
      require('barbecue').setup(opts)

      vim.keymap.set({ 'n', 'x' }, '<leader>kb', function()
        require('barbecue.ui').toggle()
      end, { desc = 'Toggle barbecue', noremap = true })
    end,
  },

  {
    'akinsho/bufferline.nvim',
    version = '*',

    opts = {
      options = {
        diagnostics = 'nvim_lsp',
        numbers = 'both',
        separator_style = 'thin',
        show_close_icon = false,

        diagnostics_indicator = function(count, level, _, context)
          if context.buffer:current() then
            return ''
          end

          local icon = level:match('error') and '' or ''

          return ' ' .. icon .. count
        end,

        offsets = {
          {
            filetype = 'fern',
            text = '󰌪',
            text_align = 'center',
          },
          {
            filetype = 'Outline',
            text = '󰊕',
            text_align = 'center',
          },
          {
            filetype = 'undotree',
            text = '󰕌',
            text_align = 'center',
          },
        },
      },
    },

    config = function(_, opts)
      opts.highlights =
        require('catppuccin.groups.integrations.bufferline').get()

      require('bufferline').setup(opts)
    end,
  },
}
