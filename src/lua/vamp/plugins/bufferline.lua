return {
  'akinsho/bufferline.nvim',

  after = 'catppuccin',

  opts = {
    options = {
      diagnostics = 'nvim_lsp',
      numbers = 'both',
      separator_style = 'thin',
      show_buffer_close_icons = false,
      show_close_icon = false,

      custom_filter = function(buf, _)
        return vim.fn.bufname(buf):match('[No Name]')
          or vim.bo[buf].filetype == 'help'
      end,

      diagnostics_indicator = function(count, level, _, context)
        if context.buffer:current() then
          return ''
        end

        local icon = level:match('error') and ''
          or level:match('hint') and '󰮥'
          or level:match('info') and ''
          or level:match('warn') and ''

        return ' ' .. icon .. ' ' .. count
      end,

      offsets = {
        {
          filetype = 'grug-far',
          separator = true,
          text = '󰣎',
          text_align = 'center',
        },

        {
          filetype = 'neo-tree',
          separator = true,
          text = '󰌪',
          text_align = 'center',
        },

        {
          filetype = 'toggleterm',
          separator = true,
          text = '',
          text_align = 'center',
        },

        {
          filetype = 'undotree',
          separator = true,
          text = '󰕌',
          text_align = 'center',
        },

        {
          filetype = 'NeogitStatus',
          separator = true,
          text = '',
          text_align = 'center',
        },

        {
          filetype = 'Outline',
          separator = true,
          text = '󰊕',
          text_align = 'center',
        },
      },
    },
  },

  config = function(_, opts)
    local catppuccin =
      require('catppuccin.palettes').get_palette(_G.catppuccin_theme)

    opts.highlights = require('catppuccin.groups.integrations.bufferline').get()

    opts.options.groups = {
      items = {
        require('bufferline.groups').builtin.pinned:with({
          icon = ' 󰐃 ',
        }),

        {
          auto_close = true,
          icon = '  ',
          name = ' Tests',
          priority = 1,

          highlight = {
            sp = catppuccin.mauve,
          },

          matcher = function(buf)
            return buf.name:match('_test') or buf.name:match('_spec')
          end,
        },

        {
          auto_close = true,
          icon = ' 󰪰 ',
          name = '󰪰 Aggregates',
          priority = 2,

          highlight = {
            sp = catppuccin.red,
          },

          matcher = function(buf)
            return buf.path:match('/aggregates/')
          end,
        },

        {
          auto_close = true,
          icon = '  ',
          name = ' Commands',
          priority = 3,

          highlight = {
            sp = catppuccin.peach,
          },

          matcher = function(buf)
            return buf.path:match('/commands/')
          end,
        },

        {
          auto_close = true,
          name = '󰨦 Events',
          icon = ' 󰨦 ',
          priority = 4,

          highlight = {
            sp = catppuccin.yellow,
          },

          matcher = function(buf)
            return buf.path:match('/events/')
          end,
        },

        {
          auto_close = true,
          icon = ' 󰐮 ',
          name = '󰐮 Projectors',
          priority = 5,

          highlight = {
            sp = catppuccin.green,
          },

          matcher = function(buf)
            return buf.path:match('/projectors/')
          end,
        },

        {
          auto_close = true,
          icon = '   ',
          name = '  Read models',
          priority = 6,

          highlight = {
            sp = catppuccin.blue,
          },

          matcher = function(buf)
            return buf.path:match('/read_models/')
          end,
        },

        {
          auto_close = true,
          icon = ' 󰪭  ',
          name = '󰪭  Services',
          priority = 7,

          highlight = {
            sp = catppuccin.lavender,
          },

          matcher = function(buf)
            return buf.path:match('/services/')
          end,
        },
      },
    }

    require('bufferline').setup(opts)

    vim.keymap.set(
      { 'n', 'x' },
      '<leader>ti',
      '<cmd>BufferLineTogglePin<cr>',
      { desc = 'Pin buffer', noremap = true }
    )

    vim.keymap.set(
      { 'n', 'x' },
      '<leader>tn',
      '<cmd>BufferLineCycleNext<cr>',
      { desc = 'Next buffer', noremap = true }
    )

    vim.keymap.set(
      { 'n', 'x' },
      '<leader>tp',
      '<cmd>BufferLineCyclePrev<cr>',
      { desc = 'Previous buffer', noremap = true }
    )

    vim.keymap.set(
      { 'n', 'x' },
      '<leader>tdd',
      '<cmd>BufferLinePickClose<cr>',
      { desc = 'Choose buffer to close', noremap = true }
    )

    vim.keymap.set(
      { 'n', 'x' },
      '<leader>tdn',
      '<cmd>BufferLineCloseLeft<cr>',
      { desc = 'Close buffers to the left', noremap = true }
    )

    vim.keymap.set(
      { 'n', 'x' },
      '<leader>tdo',
      '<cmd>BufferLineCloseRight<cr>',
      { desc = 'Close buffers to the right', noremap = true }
    )

    vim.keymap.set(
      { 'n', 'x' },
      '<leader>tdt',
      '<cmd>BufferLineCloseOthers<cr>',
      { desc = 'Close other buffers', noremap = true }
    )

    vim.keymap.set(
      { 'n', 'x' },
      '<leader>tgd',
      ':BufferLineGroupClose ',
      { desc = 'Close buffer group', noremap = true }
    )

    vim.keymap.set(
      { 'n', 'x' },
      '<leader>tgg',
      ':BufferLineGroupToggle ',
      { desc = 'Toggle buffer group', noremap = true }
    )

    vim.keymap.set(
      { 'n', 'x' },
      '<leader>tt',
      '<cmd>BufferLinePick<cr>',
      { desc = 'Buffers', noremap = true }
    )

    vim.keymap.set(
      { 'n', 'x' },
      '<leader>tse',
      '<cmd>BufferLineSortByExtension<cr>',
      { desc = 'Sort buffers by extension', noremap = true }
    )

    vim.keymap.set(
      { 'n', 'x' },
      '<leader>tsr',
      '<cmd>BufferLineSortByRelativeDirectory<cr>',
      { desc = 'Sort buffers by relative directory', noremap = true }
    )

    vim.keymap.set(
      { 'n', 'x' },
      '<leader>tss',
      '<cmd>BufferLineSortByDirectory<cr>',
      { desc = 'Sort buffers by directory', noremap = true }
    )

    vim.keymap.set(
      { 'n', 'x' },
      '<leader>tst',
      '<cmd>BufferLineSortByTabs<cr>',
      { desc = 'Sort buffers by tabs', noremap = true }
    )

    vim.keymap.set(
      { 'n', 'x' },
      '<leader>yr',
      ':BufferLineTabRename ',
      { desc = 'Rename tab', noremap = true }
    )

    vim.api.nvim_set_hl(0, 'BufferLineOffsetSeparator', {
      fg = catppuccin.blue,
    })
  end,
}
