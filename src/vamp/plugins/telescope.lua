return {
  'nvim-telescope/telescope.nvim',

  dependencies = {
    'nvim-lua/plenary.nvim',

    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
    },

    'nvim-telescope/telescope-file-browser.nvim',
    'nvim-telescope/telescope-github.nvim',
    'nvim-telescope/telescope-z.nvim',
  },

  opts = function()
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
      'workspace_symbols',
    }

    local pickers_configuration = {}

    for _, picker in ipairs(pickers) do
      pickers_configuration[picker] = {
        theme = 'ivy',
      }
    end

    return {
      defaults = {
        path_display = {
          truncate = 1,
        },
      },
      extensions = {
        file_browser = {
          theme = 'ivy',
        },
      },
      pickers = pickers_configuration,
    }
  end,

  config = function(_, opts)
    local telescope = require('telescope')
    local builtin = require('telescope.builtin')
    local buffer_dir = require('telescope.utils').buffer_dir
    local file_browser =
      require('telescope').extensions.file_browser.file_browser
    local map = require('vamp.cartographer').map

    telescope.setup(opts)

    telescope.load_extension('file_browser')
    telescope.load_extension('fzf')
    telescope.load_extension('gh')
    telescope.load_extension('z')

    local create_get_buffers = function(only_cwd)
      return function()
        builtin.buffers({
          ignore_current_buffer = true,
          only_cwd = only_cwd,
          sort_mru = true,
        })
      end
    end

    local get_buffers_only_cwd = create_get_buffers(true)
    local get_buffers = create_get_buffers(false)

    local set_keymap = vim.keymap.set

    set_keymap(
      { 'n', 'x' },
      "<leader>'",
      builtin.resume,
      { desc = 'Resume Telescope', noremap = true }
    )

    set_keymap(
      { 'n', 'x' },
      '<leader><space>',
      builtin.find_files,
      { desc = 'Find files (cwd)', noremap = true }
    )

    set_keymap(
      { 'n', 'x' },
      '<leader>*',
      builtin.grep_string,
      { desc = 'Grep w/input (cwd)', noremap = true }
    )

    set_keymap(
      { 'n', 'x' },
      '<leader>,',
      get_buffers_only_cwd,
      { desc = 'Buffers (cwd)', noremap = true }
    )

    set_keymap(
      { 'n', 'x' },
      '<leader>/',
      builtin.live_grep,
      { desc = 'Grep (cwd)', noremap = true }
    )

    set_keymap(
      { 'n', 'x' },
      '<leader><',
      get_buffers,
      { desc = 'Buffers', noremap = true }
    )

    set_keymap(
      { 'n', 'x' },
      '<leader>ff',
      builtin.current_buffer_fuzzy_find,
      { desc = 'Fuzzy find', noremap = true }
    )

    set_keymap(
      { 'n', 'x' },
      '<leader>fs',
      builtin.lsp_document_symbols,
      { desc = 'Document symbols', noremap = true }
    )

    set_keymap(
      { 'n', 'x' },
      '<leader>ft',
      builtin.treesitter,
      { desc = 'Treesitter', noremap = true }
    )

    set_keymap(
      { 'n', 'x' },
      '<leader>gb',
      builtin.git_branches,
      { desc = 'Branches', noremap = true }
    )

    set_keymap(
      { 'n', 'x' },
      '<leader>gc',
      builtin.git_bcommits,
      { desc = 'Branch commits', noremap = true }
    )

    set_keymap(
      { 'n', 'x' },
      '<leader>gC',
      builtin.git_commits,
      { desc = 'Commits', noremap = true }
    )

    set_keymap(
      { 'n', 'x' },
      '<leader>gf',
      builtin.git_files,
      { desc = 'Files', noremap = true }
    )

    set_keymap(
      { 'n', 'x' },
      '<leader>gg',
      builtin.git_status,
      { desc = 'Status', noremap = true }
    )

    set_keymap(
      { 'n', 'x' },
      '<leader>gs',
      builtin.git_stash,
      { desc = 'Stash', noremap = true }
    )

    set_keymap(
      { 'n', 'x' },
      "<leader>h'",
      builtin.resume,
      { desc = 'Resume Telescope', noremap = true }
    )

    set_keymap(
      { 'n', 'x' },
      '<leader>h,',
      builtin.quickfixhistory,
      { desc = 'Quickfix', noremap = true }
    )

    set_keymap(
      { 'n', 'x' },
      '<leader>h.',
      builtin.pickers,
      { desc = 'Pickers', noremap = true }
    )

    set_keymap(
      { 'n', 'x' },
      '<leader>h:',
      builtin.command_history,
      { desc = 'Commands', noremap = true }
    )

    set_keymap(
      { 'n', 'x' },
      '<leader>h;',
      builtin.search_history,
      { desc = 'Searches', noremap = true }
    )

    set_keymap(
      { 'n', 'x' },
      '<leader>ne',
      builtin.diagnostics,
      { desc = 'Diagnostics', noremap = true }
    )

    set_keymap(
      { 'n', 'x' },
      '<leader>nd',
      builtin.lsp_definitions,
      { desc = 'Definitions', noremap = true }
    )

    set_keymap(
      { 'n', 'x' },
      '<leader>ni',
      builtin.lsp_implementations,
      { desc = 'Implementations', noremap = true }
    )

    set_keymap(
      { 'n', 'x' },
      '<leader>ns',
      builtin.lsp_dynamic_workspace_symbols,
      { desc = 'Dynamic workspace symbols', noremap = true }
    )

    set_keymap(
      { 'n', 'x' },
      '<leader>nt',
      builtin.lsp_type_definitions,
      { desc = 'Type definitions', noremap = true }
    )

    set_keymap(
      { 'n', 'x' },
      '<leader>nu',
      builtin.lsp_references,
      { desc = 'References', noremap = true }
    )

    set_keymap(
      { 'n', 'x' },
      '<leader>sc',
      builtin.quickfix,
      { desc = 'Quickfix', noremap = true }
    )

    set_keymap(
      { 'n', 'x' },
      '<leader>sd',
      file_browser,
      { desc = 'File browser', noremap = true }
    )

    set_keymap(
      { 'n', 'x' },
      '<leader>sf',
      builtin.find_files,
      { desc = 'Find files', noremap = true }
    )

    set_keymap(
      { 'n', 'x' },
      '<leader>sg',
      builtin.git_files,
      { desc = 'Git', noremap = true }
    )

    set_keymap(
      { 'n', 'x' },
      '<leader>sl',
      builtin.loclist,
      { desc = 'Loclist', noremap = true }
    )

    set_keymap(
      { 'n', 'x' },
      '<leader>sm',
      builtin.marks,
      { desc = 'Marks', noremap = true }
    )

    set_keymap(
      { 'n', 'x' },
      '<leader>sp',
      builtin.jumplist,
      { desc = 'Jumps', noremap = true }
    )

    set_keymap({ 'n', 'x' }, '<leader>sr', function()
      builtin.oldfiles({
        only_cwd = true,
      })
    end, { desc = 'Recent files (cwd)', noremap = true })

    set_keymap(
      { 'n', 'x' },
      '<leader>sR',
      builtin.oldfiles,
      { desc = 'Recent files (all)', noremap = true }
    )

    set_keymap(
      { 'n', 'x' },
      '<leader>ss',
      builtin.live_grep,
      { desc = 'Grep', noremap = true }
    )

    set_keymap(
      { 'n', 'x' },
      '<leader>sw',
      builtin.grep_string,
      { desc = 'Grep w/input', noremap = true }
    )

    set_keymap(
      { 'n', 'x' },
      '<leader>tt',
      get_buffers_only_cwd,
      { desc = 'Buffers (cwd)', noremap = true }
    )

    set_keymap({ 'n', 'x' }, '<leader>ud', function()
      file_browser({
        path = buffer_dir(),
      })
    end, { desc = 'File browser', noremap = true })

    set_keymap({ 'n', 'x' }, '<leader>uf', function()
      builtin.find_files({
        cwd = buffer_dir(),
      })
    end, { desc = 'Find files', noremap = true })

    set_keymap({ 'n', 'x' }, '<leader>us', function()
      builtin.live_grep({
        cwd = buffer_dir(),
      })
    end, { desc = 'Grep', noremap = true })

    set_keymap({ 'n', 'x' }, '<leader>uw', function()
      builtin.grep_string({
        cwd = buffer_dir(),
      })
    end, { desc = 'Grep w/input', noremap = true })

    set_keymap(
      { 'n', 'x' },
      '<leader>z:',
      builtin.commands,
      { desc = 'Commands', noremap = true }
    )
    set_keymap(
      { 'n', 'x' },
      '<leader>zh',
      builtin.help_tags,
      { desc = 'Help tags', noremap = true }
    )
    set_keymap(
      { 'n', 'x' },
      '<leader>zk',
      builtin.keymaps,
      { desc = 'Keymaps', noremap = true }
    )
    set_keymap(
      { 'n', 'x' },
      '<leader>zk',
      builtin.reloader,
      { desc = 'Lua modules', noremap = true }
    )
    set_keymap(
      { 'n', 'x' },
      '<leader>zo',
      builtin.vim_options,
      { desc = 'Options', noremap = true }
    )
    set_keymap(
      { 'n', 'x' },
      '<leader>zr',
      builtin.registers,
      { desc = 'Registers', noremap = true }
    )
    set_keymap(
      { 'n', 'x' },
      '<leader>zs',
      builtin.spell_suggest,
      { desc = 'Spelling suggestions', noremap = true }
    )
    set_keymap(
      { 'n', 'x' },
      '<leader>zt',
      builtin.colorscheme,
      { desc = 'Colourschemes', noremap = true }
    )

    local get_file_info = function()
      local buffer_number = vim.api.nvim_get_current_buf()
      local file_type = vim.filetype.match({ buf = buffer_number })

      if not file_type then
        return false
      end

      local file_extension = vim.fn.expand('%:e')

      return {
        type = file_type,
        extension = file_extension,
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
        type_filter = file_info.type,
      }

      if cwd then
        filters.cwd = buffer_dir()
      end

      return filters
    end

    set_keymap({ 'n', 'x' }, '<leader>stf', function()
      builtin.find_files({
        find_command = get_find_command(),
      })
    end, { desc = 'Find files', noremap = true })

    set_keymap({ 'n', 'x' }, '<leader>sts', function()
      builtin.live_grep(get_filters(false))
    end, { desc = 'Grep', noremap = true })

    set_keymap({ 'n', 'x' }, '<leader>utf', function()
      builtin.find_files({
        find_command = get_find_command(),
        cwd = buffer_dir(),
      })
    end, { desc = 'Find files', noremap = true })

    set_keymap({ 'n', 'x' }, '<leader>uts', function()
      builtin.live_grep(get_filters(true))
    end, { desc = 'Grep', noremap = true })
  end,
}
