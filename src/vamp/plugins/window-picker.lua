return {
  's1n7ax/nvim-window-picker',

  opts = {
    filter_rules = {
      autoselect_one = true,

      bo = {
        buftype = {
          'terminal',
          'quickfix',
        },

        filetype = {
          'neo-tree',
          'neo-tree-popup',
          'notify',
        },
      },

      include_current_win = false,
    },
  },
}
