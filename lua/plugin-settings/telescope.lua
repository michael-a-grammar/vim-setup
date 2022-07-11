return function(opts)
  local telescope = require('telescope')

  local pickers = {
    'buffers',
    'command_history',
    'commands',
    'current_buffer_fuzzy_find',
    'diagnostics',
    'find_files',
    'git_bcommits',
    'git_branches',
    'git_commits',
    'git_files',
    'git_status',
    'grep_string',
    'jumplist',
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
    'quickfix',
    'quickfixhistory',
    'search_history',
    'treesitter',
    'workspace_symbols'
  }

  local pickers_configuration = {}

  for _, picker in ipairs(pickers) do
    pickers_configuration[picker] = {
      theme = 'ivy'
    }
  end

  telescope.setup({
    defaults = {
      path_display = {
        truncate = 1
      }
    },
    pickers = pickers_configuration
  })

  telescope.load_extension('fzf')
  telescope.load_extension('gh')
  telescope.load_extension('z')

  if opts.use.coc then
    telescope.load_extension('coc')
  end
end
