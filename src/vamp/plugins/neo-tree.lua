return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v3.x',

  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'MunifTanjim/nui.nvim',
    '3rd/image.nvim',
    's1n7ax/nvim-window-picker',
  },

  opts = {
    close_if_last_window = true,

    commands = {}, -- TODO: Open with helix

    open_files_do_not_replace_types = {
      'terminal',
      'trouble',
      'qf',
    },

    window = {
      position = 'left',
      width = 30,

      mappings = {
        ['<space>'] = {
          'toggle_node',
          nowait = true,
        },

        ['a'] = {
          'add',
          config = {
            show_path = 'relative',
          },
        },

        ['<c-c>'] = {
          'copy',
          config = {
            show_path = 'relative',
          },
        },

        ['c'] = 'close_node',
        ['h'] = 'split_with_window_picker',
        ['k'] = 'show_file_details',
        ['l'] = 'focus_preview',
        ['r'] = 'rename',
        ['t'] = 'open_tabnew',
        ['v'] = 'vsplit_with_window_picker',
        ['w'] = 'open_with_window_picker',
        ['x'] = 'cut_to_clipboard',
        ['y'] = 'copy_to_clipboard',

        ['m'] = {
          'move',
          config = {
            show_path = 'relative',
          },
        },

        ['A'] = {
          'add_directory',

          config = {
            show_path = 'relative',
          },
        },

        ['<c-R>'] = 'refresh',
        ['C'] = 'close_all_subnodes',
        ['M'] = 'close_all_nodes',
        ['R'] = 'expand_all_nodes',

        -- ["<cr>"] = "open_drop",
        -- ["t"] = "open_tab_drop",
        -- ['v'] = 'paste_from_clipboard',
      },
    },
  },
}
