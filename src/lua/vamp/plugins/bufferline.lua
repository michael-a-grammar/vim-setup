return {
  'akinsho/bufferline.nvim',

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

        return ' ' .. icon .. ' ' .. count
      end,

      offsets = {
        {
          filetype = 'neo-tree',
          text = '󰌪',
          text_align = 'center',
        },
        {
          filetype = 'undotree',
          text = '󰕌',
          text_align = 'center',
        },
        {
          filetype = 'NeogitStatus',
          text = '',
          text_align = 'center',
        },
        {
          filetype = 'Outline',
          text = '󰊕',
          text_align = 'center',
        },
      },
    },
  },

  config = function(_, opts)
    opts.highlights = require('catppuccin.groups.integrations.bufferline').get()

    require('bufferline').setup(opts)
  end,
}
