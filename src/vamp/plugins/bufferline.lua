return {
  'akinsho/bufferline.nvim',

  opts = {
    highlights =
      require'catppuccin.groups.integrations.bufferline'.get(),

    options = {
      diagnostics     = 'nvim_lsp',
      numbers         = 'both',
      separator_style = 'thin',
      show_close_icon = false,

      diagnostics_indicator = function(count, level, diagnostics_dict, context)
        if context.buffer:current() then
          return ''
        end

        return ''
      end,

      offsets = {
        {
          filetype   = 'fern',
          text       = '󰌪',
          text_align = 'center'
        },
        {
          filetype   = 'Outline',
          text       = '󰊕',
          text_align = 'center'
        },
        {
          filetype   = 'undotree',
          text       = '󰕌',
          text_align = 'center',
        },
      },
    },
  },
}
