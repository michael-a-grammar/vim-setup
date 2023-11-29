return function()
  local lsp        = vim.lsp.buf
  local diagnostic = vim.diagnostic
  local map        = require'bundled.cartographer'.map

  map(function()
    leader       '<space>'
    local_leader ','

    c {
      alt 'left',  ctrl 'left',  'Word backwards',
      alt 'right', ctrl 'right', 'Word forwards',
    }

    i {
      'jj', esc, 'Return to normal mode',
    }

    nx {
      spc, nop, 'nop',
      bs,  nop, 'nop',
      ',', nop, 'nop',

      ',,', ',',       'Previous match',
      '0',  'g0',      'Beginning of line',
      '^',  'g^',      'Start of line',
      'H',  'g^',      'Start of line',
      '$',  'g$',      'End of line',
      'L',  'g$',      'End of line',
      '-',  'ddp',     'Move line down',
      '_',  'dd<up>P', 'Move line up',
      'n',  'nzzzv',   'Next match and centre',
      'N',  'Nzzzv',   'Previous match and centre',
      'U',  ctrl 'r',  'Redo',

      'gd', lsp.definition,      'Go to definition',
      'gD', lsp.declaration,     'Go to declaration',
      'gm', lsp.implementation,  'Go to implementation',
      'gr', lsp.references,      'Go to references',
      'gy', lsp.type_definition, 'Go to type definition',
    }

    nx_leader {
      '!', cmd_mode '!', 'Shell command',
      tab, ctrl '^',     'Last buffer',

      -- TODO: Not working
      -- 'n', expr [[&diff ? ']c' ? <nop>]], 'Next diff',
      -- 'p', expr [[&diff ? '[c' ? <nop>]], 'Previous diff',

      'p', ctrl 'o', 'Backwards',
      'P', ctrl 'i', 'Forwards',
    }

    nx_leader_with 'c' {
      'a', lsp.code_action,       'Action',
      'c', lsp.rename,            'Rename',
      'd', lsp.definition,        'Go to definition',
      'D', lsp.declaration,       'Go to declaration',
      'f', lsp.format,            'Format',
      'h', lsp.hover,             'Hover',
      'm', lsp.implementation,    'Go to implementation',
      'r', lsp.references,        'Go to references',
      's', lsp.signature_help,    'Signature help',

      't',
      function()
        lsp.codelens.run()
      end,
      'Run test',

      'y', lsp.type_definition,   'Go to type definition',
    }

    nx_leader_with 'd' {
      'f', diagnostic.open_float, 'Info',
      'l', diagnostic.setloclist, 'Set loclist with diagnostics',
      'n', diagnostic.goto_next,  'Next diagnostic',
      'p', diagnostic.goto_prev,  'Previous diagnostic',
    }

    nx_leader_with 'k' {
      'i', exe 'set noincsearch', 'Disable incremental search',
      't', exe 'nohlsearch',      'Disable highlighted search results',
      's', cmd_mode 's/',         'Substitute within line',
      'S', cmd_mode '%s/',        'Substitute',
    }

    nx_leader_with 't' {
      'c', exe 'new',               'New buffer',
      'd', exe 'bdelete',           'Delete buffer',
      'D', exe 'bdelete!',          'Delete buffer (force)',
      'n', exe 'bnext',             'Next buffer',
      'p', exe 'bprevious',         'Previous buffer',
      'w', exe 'vertical ball',     'Open buffers in vertical splits',
      'W', exe 'ball',              'Open buffers in horizontal splits',
      'x', exe '%bdelete | edit#',  'Delete other buffers',
      'X', exe '%bdelete! | edit#', 'Delete other buffers (force)',
      'y', exe 'tab ball',          'Open buffers in tabs',
    }

    nx_leader_with 'q' {
      'q', exe 'quitall',  'Quit all',
      'Q', exe 'quitall!', 'Force quit all',
    }

    nx_leader_with 'w' {
      '.', ctrl 'w' :with '>', 'Increase window width',
      ',', ctrl 'w' :with '<', 'Decrease window width',
      '|', ctrl 'w' :with '|', 'Maximise window width',
      '+', ctrl 'w' :with '+', 'Increase window height',
      '-', ctrl 'w' :with '-', 'Decrease window height',
      '_', ctrl 'w' :with '_', 'Maximise window height',
      '=', ctrl 'w' :with '=', 'Equalise window size',

      'd', exe 'close', 'Close window',
      'h', exe 'only',  'Close other windows',

      'e', ctrl 'w' :with 'j', 'Move to bottom window',
      'i', ctrl 'w' :with 'k', 'Move to top window',
      'n', ctrl 'w' :with 'h', 'Move to left window',
      'o', ctrl 'w' :with 'l', 'Move to right window',
      'r', ctrl 'w' :with 'r', 'Rotate window downwards/rightwards',
      'w', ctrl 'w' :with 'p', 'Previous window',
      'x', ctrl 'w' :with 'x', 'Exchange window',

      'E', ctrl 'w' :with 'J', 'Move window to bottom',
      'I', ctrl 'w' :with 'K', 'Move window to top',
      'N', ctrl 'w' :with 'H', 'Move window to left',
      'O', ctrl 'w' :with 'L', 'Move window to right',
      'R', ctrl 'w' :with 'R', 'Rotate window upwards/leftwards',

      's', exe 'vsplit',    'Split window vertically',
      'S', exe 'split',     'Split window horizontally',
      't', exe 'tab split', 'Open window in new tab',
    }

    nx_leader_with 'x' {
      'm', ctrl 'a',        'Increment',
      'M', ctrl 'x',        'Decrement',
      's', cmd_mode 'sort', 'Sort',
    }

    nx_leader_with 'y' {
      'c', exe 'tabnew',      'New tab',
      'd', exe 'tabclose',    'Close tab',
      'f', exe 'tabfirst',    'First tab',
      'l', exe 'tablast',     'Last tab',
      'n', exe 'tabnext',     'Next tab',
      'p', exe 'tabprevious', 'Previous tab',
    }
  end)
end
