return function()
  local telescope    = require'telescope'
  local builtin      = require'telescope.builtin'
  local buffer_dir   = require'telescope.utils'.buffer_dir
  local file_browser = require'telescope'.extensions.file_browser.file_browser
  local map          = require'bundled.cartographer'.map

  local pickers = {
    'buffers',
    'colorscheme',
    'command_history',
    'commands',
    'current_buffer_fuzzy_find',
    'diagnostics',
    'find_files',
    'git_bcommits',
    'git_branches',
    'git_commits',
    'git_files',
    'git_stash',
    'git_status',
    'grep_string',
    'highlights',
    'help_tags',
    'jumplist',
    'keymaps',
    'live_grep',
    'loclist',
    'lsp_definitions',
    'lsp_document_symbols',
    'lsp_dynamic_workspace_symbols',
    'lsp_implementations',
    'lsp_references',
    'lsp_workspace_symbols',
    'marks',
    'oldfiles',
    'pickers',
    'quickfix',
    'quickfixhistory',
    'registers',
    'search_history',
    'spell_suggest',
    'treesitter',
    'vim_options',
    'workspace_symbols'
  }

  local pickers_configuration = {}

  for _, picker in ipairs(pickers) do
    pickers_configuration[picker] = {
      theme = 'ivy'
    }
  end

  telescope.setup {
    defaults = {
      path_display = {
        truncate = 1
      }
    },
    extensions = {
      file_browser = {
        theme = "ivy"
      }
    },
    pickers = pickers_configuration
  }

  telescope.load_extension('file_browser')
  telescope.load_extension('fzf')
  telescope.load_extension('gh')
  telescope.load_extension('z')

  local create_get_buffers = function(only_cwd)
    return function()
      builtin.buffers {
        ignore_current_buffer = true,
        only_cwd              = only_cwd,
        sort_mru              = true,
      }
    end
  end

  local buffers_only_cwd = create_get_buffers(true)
  local buffers          = create_get_buffers(false)

  map(function()
    nx_leader {
      '\'', builtin.resume, 'Resume picker',

      spc, builtin.find_files, 'Find files (cwd)',

      '*', builtin.grep_string, 'Grep w/ input (cwd)',
      ',', buffers_only_cwd,    'Buffers (cwd)',
      '/', builtin.live_grep,   'Grep (cwd)',
      '<', buffers,             'Buffers',
    }

    nx_leader_with 'f' {
      'f', builtin.current_buffer_fuzzy_find, 'Fuzzy find',
      's', builtin.lsp_document_symbols,      'Document symbols',
      't', builtin.treesitter,                'Treesitter'
    }

    nx_leader_with 'g' {
      'b', builtin.git_branches, 'Branches',
      'c', builtin.git_bcommits, 'Branch commits',
      'C', builtin.git_commits,  'Commits',
      'f', builtin.git_files,    'Files',
      'g', builtin.git_status,   'Status',
      's', builtin.git_stash,    'Stash'
    }

    nx_leader_with 'h' {
      ',', builtin.quickfixhistory, 'Quickfix',
      '.', builtin.pickers,         'Pickers',
      ':', builtin.command_history, 'Commands',
      ';', builtin.search_history,  'Searches',
      'T', builtin.resume,          'Resume picker'
    }

    nx_leader_with 'n' {
      'e', builtin.diagnostics,                   'Diagnostics',
      'd', builtin.lsp_definitions,               'Definitions',
      'i', builtin.lsp_implementations,           'Implementations',
      's', builtin.lsp_dynamic_workspace_symbols, 'Dynamic workspace symbols',
      't', builtin.lsp_type_definitions,          'Type definitions',
      'u', builtin.lsp_references,                'References'
    }

    nx_leader_with 's' {
      'c', builtin.quickfix,   'Quickfix',
      'd', file_browser,       'File browser',
      'f', builtin.find_files, 'Find files',
      'g', builtin.git_files,  'Git',
      'l', builtin.loclist,    'Loclist',
      'm', builtin.marks,      'Marks',
      'p', builtin.jumplist,   'Jumps',

      'r',
      function()
        builtin.oldfiles{
          only_cwd = true
        }
      end,
      'Recent files (cwd)',

      'R', builtin.oldfiles,    'Recent files (all)',
      's', builtin.live_grep,   'Grep',
      'w', builtin.grep_string, 'Grep w/ input',
    }

    nx_leader_with 't' {
      't', buffers_only_cwd, 'Buffers (cwd)'
    }

    nx_leader_with 'u' {
      'd',
      function()
        file_browser {
          path = buffer_dir()
        }
      end,
      'File browser',

      'f',
      function()
        builtin.find_files {
          cwd = buffer_dir()
        }
      end,
      'Find files',

      's',
      function()
        builtin.live_grep {
          cwd = buffer_dir()
        }
      end,
      'Grep',

      'w',
      function()
        builtin.grep_string {
          cwd = buffer_dir()
        }
      end,
      'Grep w/ input'
    }

    nx_leader_with 'z' {
      ':', builtin.commands,      'Commands',
      'h', builtin.help_tags,     'Help tags',
      'k', builtin.keymaps,       'Keymaps',
      'k', builtin.reloader,      'Lua modules',
      'o', builtin.vim_options,   'Options',
      'r', builtin.registers,     'Registers',
      's', builtin.spell_suggest, 'Spelling suggestions',
      't', builtin.colorscheme,   'Colourschemes'
    }
  end)

  local get_file_info = function()
    local buffer_number = vim.api.nvim_get_current_buf()
    local file_type     = vim.filetype.match({ buf = buffer_number })

    if not file_type then
      return false
    end

    local file_extension = vim.fn.expand('%:e')

    return {
      type      = file_type,
      extension = file_extension
    }
  end

  local get_find_command = function()
    return { 'rg', '--type', get_file_info().type, '--files' }
  end

  local get_filters = function(cwd)
    local file_info = get_file_info()

    if not file_info then
      return {}
    end

    local filters = {
      glob_pattern = '*.' .. file_info.extension .. '*',
      type_filter  = file_info.type
    }

    if cwd then
      filters.cwd = buffer_dir()
    end

    return filters
  end

  map(function()
    nx_local_leader_with 's' {
      'f',
      function()
        builtin.find_files {
          find_command = get_find_command()
        }
      end,
      'Find files',

      's',
      function()
        builtin.live_grep(get_filters(false))
      end,
      'Grep'
    }

    nx_local_leader_with 'u' {
      'f',
      function()
        builtin.find_files {
          find_command = get_find_command(),
          cwd          = buffer_dir()
        }
      end,
      'Find files',

      's',
      function()
        builtin.live_grep(get_filters(true))
      end,
      'Grep'
    }
  end)
end
