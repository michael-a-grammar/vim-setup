return function()
  local telescope = require'telescope'

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
    'git_status',
    'grep_string',
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

  telescope.setup({
    defaults = {
      path_display = {
        truncate = 1
      }
    },
    extensions = {
      coc = {
        theme = "ivy"
      },
      file_browser = {
        theme = "ivy"
      }
    },
    pickers = pickers_configuration
  })

  telescope.load_extension('file_browser')
  telescope.load_extension('fzf')
  telescope.load_extension('gh')
  telescope.load_extension('z')
end
