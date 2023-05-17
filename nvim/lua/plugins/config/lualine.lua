return function()
  local catppuccin = require'catppuccin.palettes'.get_palette('mocha')
  local lualine    = require'lualine'

  local colors = {
    bg       = catppuccin.base,
    fg       = catppuccin.text,
    dark_fg  = catppuccin.surface2,
    yellow   = catppuccin.yellow,
    cyan     = catppuccin.teal,
    darkblue = catppuccin.blue,
    green    = catppuccin.green,
    orange   = catppuccin.peach,
    violet   = catppuccin.lavender,
    magenta  = catppuccin.mauve,
    blue     = catppuccin.sapphire,
    red      = catppuccin.red,
  }

  local conditions = {
    is_buffer_empty = function()
      return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
    end,

    hide = function()
      return vim.fn.winwidth(0) > 80
    end,
  }

  local config = {
    options = {
      component_separators = '',
      section_separators   = '',

      disabled_filetypes = {
        'fern',
        'packer',
        'undotree',
        'qf',
        'Outline',
        'NeogitHelpPopup',
        'NeogitLogPopup',
        'NeogitStatus',
        'Trouble',
      },

      theme = {
        normal   = { c = { fg = colors.fg, bg = colors.bg }, },
        inactive = { c = { fg = colors.fg, bg = colors.bg }, },
      },
    },

    sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_y = {},
      lualine_z = {},
      lualine_c = {},
      lualine_x = {},
    },

    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_y = {},
      lualine_z = {},
      lualine_c = {},
      lualine_x = {},
    },
  }

  local insert_into_left_section = function(component)
    table.insert(config.sections.lualine_c, component)
  end

  local insert_into_right_section = function(component)
    table.insert(config.sections.lualine_x, component)
  end

  insert_into_left_section {
    function()
      return '▊'
    end,

    color   = { fg   = colors.blue,  },
    padding = { left = 0, right = 1, },
  }

  insert_into_left_section {
    function()
      return '󰣐'
    end,

    color = function()
      local mode_color = {
        n      = colors.red,
        i      = colors.green,
        v      = colors.blue,
        [''] = colors.blue,
        V      = colors.blue,
        c      = colors.magenta,
        no     = colors.red,
        s      = colors.orange,
        S      = colors.orange,
        [''] = colors.orange,
        ic     = colors.yellow,
        R      = colors.violet,
        Rv     = colors.violet,
        cv     = colors.red,
        ce     = colors.red,
        r      = colors.cyan,
        rm     = colors.cyan,
        ['r?'] = colors.cyan,
        ['!']  = colors.red,
        t      = colors.red,
      }

      return { fg = mode_color[vim.fn.mode()], }
    end,

    padding = { right = 1, },
  }

  insert_into_left_section {
    'filesize',
    cond  = conditions.is_buffer_empty,
    color = { fg = colors.dark_fg, gui = 'bold', },
  }

  insert_into_left_section {
    'filename',
    cond  = conditions.is_buffer_empty,
    color = { fg = colors.magenta, gui = 'bold', },
  }

  insert_into_left_section { 'location', color = { fg = colors.dark_fg, }, }

  insert_into_left_section { 'progress', color = { fg = colors.dark_fg, }, }

  insert_into_left_section {
    'diagnostics',

    sources = { 'nvim_diagnostic', },

    symbols = { error = ' ', warn = ' ', info = ' ', },

    diagnostics_color = {
      color_error = { fg = colors.red,    },
      color_warn  = { fg = colors.yellow, },
      color_info  = { fg = colors.cyan,   },
    },
  }

  insert_into_left_section {
    function()
      return '%='
    end,
  }

  insert_into_left_section {
    function()
      local msg     = 'No Active LSP'
      local buf_ft  = vim.api.nvim_buf_get_option(0, 'filetype')
      local clients = vim.lsp.get_active_clients()

      if next(clients) == nil then
        return msg
      end

      for _, client in ipairs(clients) do
        local filetypes = client.config.filetypes
        if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
          return client.name
        end
      end

      return msg
    end,

    icon  = ' LSP:',
    color = { fg = colors.dark_fg, gui = 'bold', },
  }

  insert_into_right_section {
    'o:encoding',
    cond  = conditions.hide,
    color = { fg = colors.green, gui = 'bold', },
  }

  insert_into_right_section {
    'fileformat',

    icons_enabled = false,

    color = { fg = colors.green, gui = 'bold', },
  }

  insert_into_right_section {
    'branch',

    icon  = '',

    fmt = function(section)
      if string.len(section) > 1 then
        local split = vim.split(section, '/')

        if table.maxn(split) > 1 then
          return split[1]
        end
      end

      return section
    end,

    color = { fg = colors.violet, gui = 'bold', },
  }

  insert_into_right_section {
    'diff',

    symbols = {
      added    = ' ',
      modified = '󰝤 ',
      removed  = ' ',
    },

    diff_color = {
      added    = { fg = colors.green  },
      modified = { fg = colors.orange },
      removed  = { fg = colors.red    },
    },

    cond = conditions.hide,
  }

  lualine.setup(config)
end
