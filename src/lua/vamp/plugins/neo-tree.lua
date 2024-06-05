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
    close_if_last_window = false,

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

          ['d'] = 'buffer_delete',
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
          ['<bs>'] = 'navigate_up',

          ['.'] = 'set_root',
          ['/'] = 'filter_on_submit',

          ['g'] = {
            'show_help',

            config = {
              prefix_key = 'g',
              title = '',
            },

            nowait = false,
          },

          ['gn'] = 'next_git_modified',
          ['gp'] = 'prev_git_modified',

          ['h'] = 'toggle_hidden',
          ['f'] = 'fuzzy_finder',

          ['s'] = {
            'show_help',

            config = {
              prefix_key = 's',
              title = 'Search',
            },

            nowait = true,
          },

          ['sd'] = 'fuzzy_finder_directory',
          ['sf'] = 'filter_on_submit',
          ['ss'] = 'fuzzy_sorter',
          ['sx'] = 'clear_filter',
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
          ['g'] = {
            'show_help',

            config = {
              prefix_key = 'g',
              title = '',
            },

            nowait = false,
          },

          ['ga'] = 'git_add_all',
          ['gc'] = 'git_commit',
          ['gg'] = 'git_commit_and_push',
          ['gp'] = 'git_push',
          ['gr'] = 'git_revert_file',
          ['gs'] = 'git_add_file',
          ['gu'] = 'git_unstage_file',
        },
      },
    },

    window = {
      position = 'left',
      width = 30,

      mappings = {
        ['='] = 'toggle_auto_expand_width',

        ['<cr>'] = {
          'show_help',

          config = {
            prefix_key = '<cr>',
            title = 'Open',
          },
        },

        ['<cr><cr>'] = 'open',

        ['<cr>h'] = 'split_with_window_picker',
        ['<cr>t'] = 'open_tabnew',
        ['<cr>v'] = 'vsplit_with_window_picker',
        ['<cr>w'] = 'open_with_window_picker',

        ['<space>'] = {
          'show_help',

          config = {
            prefix_key = '<space>',
            title = 'Actions',
          },

          nowait = false,
        },

        ['<space><space>'] = 'toggle_node',

        ['<space>c'] = 'close_all_subnodes',
        ['<space>m'] = 'close_all_nodes',
        ['<space>r'] = 'expand_all_nodes',

        ['a'] = {
          'show_help',

          config = {
            prefix_key = 'a',
            title = 'Add',
          },
        },

        ['ad'] = {
          'add_directory',

          config = {
            show_path = 'relative',
          },
        },

        ['af'] = {
          'add',
          config = {
            show_path = 'relative',
          },
        },

        ['c'] = 'toggle_node',

        ['e'] = {
          'show_help',

          config = {
            prefix_key = 'e',
            title = 'Modify',
          },

          nowait = true,
        },

        ['ec'] = {
          'copy',
          config = {
            show_path = 'relative',
          },
        },

        ['ed'] = 'delete',

        ['ei'] = 'show_file_details',

        ['em'] = {
          'move',
          config = {
            show_path = 'relative',
          },
        },

        ['er'] = 'rename',
        ['ev'] = 'paste_from_clipboard',
        ['ex'] = 'cut_to_clipboard',
        ['ey'] = 'copy_to_clipboard',

        ['p'] = {
          'toggle_preview',
          config = {
            use_float = true,
            use_image_nvim = true,
          },
        },

        ['r'] = 'refresh',

        ['P'] = 'focus_preview',
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
