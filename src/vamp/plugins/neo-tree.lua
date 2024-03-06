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

  keys = {
    {
      '<leader>l',
      '<cmd>Neotree reveal<cr>',
      desc = 'Neotree',
    },
    {
      '<leader>L',
      '<cmd>Neotree toggle reveal<cr>',
      desc = 'Neotree toggle',
    },
  },

  opts = {
    close_if_last_window = true,

    commands = {}, -- TODO: Open with helix

    filesystem = {
      follow_current_file = {
        enabled = true,
        leave_dirs_open = true,
      },

      window = {
        mappings = {
          ['<bs>'] = 'navigate_up',
          ['f'] = 'filter_on_submit',

          ['.'] = 'set_root',
          ['H'] = 'toggle_hidden',
          ['/'] = 'fuzzy_finder',
          ['D'] = 'fuzzy_finder_directory',
          ['#'] = 'fuzzy_sorter',
          ['<c-x>'] = 'clear_filter',
          ['[g'] = 'prev_git_modified',
          [']g'] = 'next_git_modified',

          ['s'] = {
            'show_help',
            nowait = true,
            config = {
              title = 'Order by',
              prefix_key = 's',
            },
          },

          ['sc'] = {
            'order_by_created',
            nowait = true,
          },

          ['sd'] = {
            'order_by_diagnostics',
            nowait = true,
          },

          ['sg'] = {
            'order_by_git_status',
            nowait = true,
          },

          ['sm'] = {
            'order_by_modified',
            nowait = true,
          },

          ['sn'] = {
            'order_by_name',
            nowait = true,
          },

          ['ss'] = {
            'order_by_size',
            nowait = true,
          },

          ['st'] = {
            'order_by_type',
            nowait = true,
          },
        },

        fuzzy_finder_mappings = {
          ['<c-f>'] = 'move_cursor_up',
          ['<c-p>'] = 'move_cursor_down',
        },
      },
    },

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

        ['<c-c>'] = {
          'copy',
          config = {
            show_path = 'relative',
          },
        },

        ['<c-r>'] = 'refresh',
        ['<c-v>'] = 'paste_from_clipboard',
        ['<c-x>'] = 'cut_to_clipboard',
        ['<c-y>'] = 'copy_to_clipboard',

        ['a'] = {
          'add',
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

        ['C'] = 'close_all_subnodes',
        ['M'] = 'close_all_nodes',
        ['R'] = 'expand_all_nodes',
      },
    },
  },
}
