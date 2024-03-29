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

    default_component_configs = {
      diagnostics = {
        symbols = {
          error = '',
          hint = '󰮥',
          info = '',
          warn = '',
        },

        highlights = {
          error = 'DiagnosticSignError',
          hint = 'DiagnosticSignHint',
          info = 'DiagnosticSignInfo',
          warn = 'DiagnosticSignWarn',
        },
      },

      git_status = {
        symbols = {
          added = '',
          conflict = '󰶇',
          deleted = '󰛌',
          ignored = '',
          modified = '',
          renamed = '',
          staged = '',
          unstaged = '󰄱',
          untracked = '󱜸',
        },
      },

      modified = {
        symbol = '󰝤',
      },
    },

    open_files_do_not_replace_types = {
      'terminal',
      'trouble',
      'qf',
    },

    buffers = {
      window = {
        mappings = {
          ['<bs>'] = 'navigate_up',

          ['.'] = 'set_root',

          ['s'] = {
            'show_help',

            config = {
              prefix_key = 'o',
              title = 'Order by',
            },

            nowait = true,
          },

          ['x'] = 'buffer_delete',

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
      },
    },

    filesystem = {
      follow_current_file = {
        enabled = true,
        leave_dirs_open = true,
      },

      window = {
        mappings = {
          ['<c-x>'] = 'clear_filter',

          ['<bs>'] = 'navigate_up',

          ['#'] = 'fuzzy_sorter',
          [','] = 'fuzzy_finder_directory',
          ['.'] = 'set_root',
          ['/'] = 'fuzzy_finder',

          ['[g'] = 'prev_git_modified',
          [']g'] = 'next_git_modified',

          ['f'] = 'filter_on_submit',
          ['u'] = 'toggle_hidden',

          ['s'] = {
            'show_help',

            config = {
              prefix_key = 's',
              title = 'Order by',
            },

            nowait = true,
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

    git_status = {
      window = {
        position = 'float',
        mappings = {
          ['ga'] = 'git_add_all',
          ['gc'] = 'git_commit',
          ['gg'] = 'git_commit_and_push',
          ['gp'] = 'git_push',
          ['gr'] = 'git_revert_file',
          ['gs'] = 'git_add_file',
          ['gu'] = 'git_unstage_file',

          ['s'] = {
            'show_help',

            config = {
              prefix_key = 's',
              title = 'Order by',
            },

            nowait = true,
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
      },
    },

    window = {
      position = 'left',
      width = 30,

      mappings = {
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

        ['c'] = 'close_node',
        ['h'] = 'split_with_window_picker',
        ['i'] = 'show_file_details',
        ['l'] = 'focus_preview',

        ['m'] = {
          'move',
          config = {
            show_path = 'relative',
          },
        },

        ['p'] = 'toggle_preview',
        ['r'] = 'rename',
        ['t'] = 'open_tabnew',
        ['v'] = 'vsplit_with_window_picker',
        ['w'] = 'open_with_window_picker',

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

  config = function(_, opts)
    require('neo-tree').setup(opts)

    local catppuccin = require('catppuccin.palettes').get_palette('mocha')

    vim.api.nvim_set_hl(0, 'NeoTreeModified', {
      fg = catppuccin.yellow,
    })

    vim.api.nvim_set_hl(0, 'NeoTreeNormal', {
      bg = catppuccin.base,
    })

    vim.api.nvim_set_hl(0, 'NeoTreeNormalNC', {
      bg = catppuccin.base,
    })

    vim.keymap.set(
      { 'n', 'x' },
      '<leader>l',
      '<cmd>Neotree reveal<cr>',
      { desc = 'Neotree', noremap = true }
    )

    vim.keymap.set(
      { 'n', 'x' },
      '<leader>L',
      '<cmd>Neotree toggle reveal<cr>',
      { desc = 'Neotree toggle', noremap = true }
    )
  end,
}
