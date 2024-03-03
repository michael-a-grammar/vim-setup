local diagnostic = vim.diagnostic
local set_keymap = vim.keymap.set
local lsp = vim.lsp.buf

set_keymap(
  'c',
  '<a-left>',
  '<c-left>',
  { desc = 'Word backwards', noremap = true }
)

set_keymap(
  'c',
  '<a-right>',
  '<c-right>',
  { desc = 'Word forwards', noremap = true }
)

set_keymap(
  'i',
  '<esc>',
  '<esc><esc>',
  { desc = 'Return to normal mode', noremap = true }
)

set_keymap(
  'i',
  'jj',
  '<esc>',
  { desc = 'Return to normal mode', noremap = false }
)

set_keymap(
  { 'n', 'x' },
  '<c-down>',
  '<c-w>j',
  { desc = 'Move to bottom window', noremap = true }
)

set_keymap(
  { 'n', 'x' },
  '<c-up>',
  '<c-w>w',
  { desc = 'Move to top window', noremap = true }
)

set_keymap(
  { 'n', 'x' },
  '<c-left>',
  '<c-w>h',
  { desc = 'Move to left window', noremap = true }
)

set_keymap(
  { 'n', 'x' },
  '<c-right>',
  '<c-w>l',
  { desc = 'Move to right window', noremap = true }
)

set_keymap(
  { 'n', 'x' },
  '<c-f>',
  '<c-u>',
  { desc = 'Scroll up', noremap = true }
)

set_keymap(
  { 'n', 'x' },
  '<c-p>',
  '<c-d>',
  { desc = 'Scroll down', noremap = true }
)

set_keymap(
  { 'n', 'x' },
  '0',
  'g0',
  { desc = 'Beginning of line', noremap = true }
)

set_keymap({ 'n', 'x' }, '^', 'g^', { desc = 'Start of line', noremap = true })

set_keymap({ 'n', 'x' }, 'H', 'g^', { desc = 'Start of line', noremap = true })

set_keymap({ 'n', 'x' }, '$', 'g$', { desc = 'End of line', noremap = true })

set_keymap({ 'n', 'x' }, 'L', 'g$', { desc = 'End of line', noremap = true })

set_keymap(
  { 'n', 'x' },
  '-',
  'ddp',
  { desc = 'Move line down', noremap = true }
)

set_keymap(
  { 'n', 'x' },
  '_',
  'dd<up>P',
  { desc = 'Move line up', noremap = true }
)

set_keymap(
  { 'n', 'x' },
  'n',
  'nzzzv',
  { desc = 'Next match and centre', noremap = true }
)

set_keymap(
  { 'n', 'x' },
  'N',
  'Nzzzv',
  { desc = 'Previous match and centre', noremap = true }
)

set_keymap({ 'n', 'x' }, 'U', '<c-r>', { desc = 'Redo', noremap = true })

set_keymap(
  { 'n', 'x' },
  'gd',
  lsp.definition,
  { desc = 'Go to definition', noremap = true }
)

set_keymap(
  { 'n', 'x' },
  'gm',
  lsp.implementation,
  { desc = 'Go to implementation', noremap = true }
)

set_keymap(
  { 'n', 'x' },
  'gy',
  lsp.type_definition,
  { desc = 'Go to type definition', noremap = true }
)

set_keymap({ 'n', 'x' }, 'h', lsp.hover, { desc = 'Hover', noremap = true })

set_keymap(
  { 'n', 'x' },
  '<leader>!',
  ':!',
  { desc = 'Shell command', noremap = true }
)

set_keymap(
  { 'n', 'x' },
  '<leader><tab>',
  '<c-^>',
  { desc = 'Last buffer', noremap = true }
)

set_keymap(
  { 'n', 'x' },
  '<leader>di',
  diagnostic.open_float,
  { desc = 'Info', noremap = true }
)

set_keymap(
  { 'n', 'x' },
  '<leader>dl',
  diagnostic.setloclist,
  { desc = 'Set loclist with diagnostics', noremap = true }
)

set_keymap(
  { 'n', 'x' },
  '<leader>dn',
  diagnostic.goto_next,
  { desc = 'Next diagnostic', noremap = true }
)

set_keymap(
  { 'n', 'x' },
  '<leader>dp',
  diagnostic.goto_prev,
  { desc = 'Previous diagnostic', noremap = true }
)

set_keymap(
  { 'n', 'x' },
  '<leader>ea',
  lsp.code_action,
  { desc = 'Action', noremap = true }
)

set_keymap(
  { 'n', 'x' },
  '<leader>ef',
  lsp.format,
  { desc = 'Format', noremap = true }
)

set_keymap(
  { 'n', 'x' },
  '<leader>eh',
  lsp.hover,
  { desc = 'Hover', noremap = true }
)

set_keymap(
  { 'n', 'x' },
  '<leader>er',
  lsp.rename,
  { desc = 'Rename', noremap = true }
)

set_keymap(
  { 'n', 'x' },
  '<leader>es',
  lsp.signature_help,
  { desc = 'Signature help', noremap = true }
)

set_keymap({ 'n', 'x' }, '<leader>et', function()
  lsp.codelens.run()
end, { desc = 'Run test', noremap = true })

set_keymap(
  { 'n', 'x' },
  '<leader>fo',
  '<c-o>',
  { desc = 'Backwards', noremap = true }
)

set_keymap(
  { 'n', 'x' },
  '<leader>fi',
  '<c-i>',
  { desc = 'Forwards', noremap = true }
)

set_keymap(
  { 'n', 'x' },
  '<leader>kh',
  '<cmd>set nohlsearch<cr>',
  { desc = 'Disable highlighted search results', noremap = true }
)

set_keymap(
  { 'n', 'x' },
  '<leader>ki',
  '<cmd>set noincsearch<cr>',
  { desc = 'Disable incremental search', noremap = true }
)

set_keymap(
  { 'n', 'x' },
  '<leader>p/',
  ':s/',
  { desc = 'Substitute within line', noremap = true }
)

set_keymap(
  { 'n', 'x' },
  '<leader>p?',
  ':%s/',
  { desc = 'Substitute within buffer', noremap = true }
)

set_keymap(
  { 'n', 'x' },
  '<leader>pd',
  '<c-x>',
  { desc = 'Decrement', noremap = true }
)

set_keymap(
  { 'n', 'x' },
  '<leader>pi',
  '<c-a>',
  { desc = 'Increment', noremap = true }
)

set_keymap('x', '<leader>ps', ':sort<cr>', { desc = 'Sort', noremap = true })

set_keymap(
  { 'n', 'x' },
  '<leader>qq',
  '<cmd>quitall<cr>',
  { desc = 'Quit all', noremap = true }
)

set_keymap(
  { 'n', 'x' },
  '<leader>qQ',
  '<cmd>quitall!<cr>',
  { desc = '' .. ' Quit all', noremap = true }
)

set_keymap(
  { 'n', 'x' },
  '<leader>tc',
  '<cmd>new<cr>',
  { desc = 'New buffer', noremap = true }
)

set_keymap(
  { 'n', 'x' },
  '<leader>td',
  '<cmd>bdelete<cr>',
  { desc = 'Delete buffer', noremap = true }
)

set_keymap(
  { 'n', 'x' },
  '<leader>tD',
  '<cmd>bdelete!<cr>',
  { desc = '' .. ' Delete buffer', noremap = true }
)

set_keymap(
  { 'n', 'x' },
  '<leader>tn',
  '<cmd>bnext<cr>',
  { desc = 'Next buffer', noremap = true }
)

set_keymap(
  { 'n', 'x' },
  '<leader>tp',
  '<cmd>bprevious<cr>',
  { desc = 'Previous buffer', noremap = true }
)

set_keymap(
  { 'n', 'x' },
  '<leader>tw',
  '<cmd>vertical ball<cr>',
  { desc = 'Open buffers in vertical splits', noremap = true }
)

set_keymap(
  { 'n', 'x' },
  '<leader>tW',
  '<cmd>ball<cr>',
  { desc = 'Open buffers in horizontal splits', noremap = true }
)

set_keymap(
  { 'n', 'x' },
  '<leader>tx',
  '<cmd>%bdelete | edit#<cr>',
  { desc = 'Delete other buffers', noremap = true }
)

set_keymap(
  { 'n', 'x' },
  '<leader>tX',
  '<cmd>%bdelete! | edit#<cr>',
  { desc = '' .. ' Delete other buffers', noremap = true }
)

set_keymap(
  { 'n', 'x' },
  '<leader>ty',
  '<cmd>tab ball<cr>',
  { desc = 'Open buffers in tabs', noremap = true }
)

set_keymap(
  { 'n', 'x' },
  '<leader>w.',
  '<c-w>>',
  { desc = 'Increase window width', noremap = true }
)

set_keymap(
  { 'n', 'x' },
  '<leader>w,',
  '<c-w><',
  { desc = 'Decrease window width', noremap = true }
)

set_keymap(
  { 'n', 'x' },
  '<leader>w|',
  '<c-w>|',
  { desc = 'Maximise window width', noremap = true }
)

set_keymap(
  { 'n', 'x' },
  '<leader>w+',
  '<c-w>+',
  { desc = 'Increase window height', noremap = true }
)

set_keymap(
  { 'n', 'x' },
  '<leader>w-',
  '<c-w>-',
  { desc = 'Decrease window height', noremap = true }
)

set_keymap(
  { 'n', 'x' },
  '<leader>w_',
  '<c-w>_',
  { desc = 'Maximise window height', noremap = true }
)

set_keymap(
  { 'n', 'x' },
  '<leader>w=',
  '<c-w>=',
  { desc = 'Equalise window size', noremap = true }
)

set_keymap(
  { 'n', 'x' },
  '<leader>wn',
  '<c-w>h',
  { desc = 'Move to left window', noremap = true }
)

set_keymap(
  { 'n', 'x' },
  '<leader>we',
  '<c-w>j',
  { desc = 'Move to bottom window', noremap = true }
)

set_keymap(
  { 'n', 'x' },
  '<leader>wi',
  '<c-w>w',
  { desc = 'Move to top window', noremap = true }
)

set_keymap(
  { 'n', 'x' },
  '<leader>wo',
  '<c-w>l',
  { desc = 'Move to right window', noremap = true }
)

set_keymap(
  { 'n', 'x' },
  '<leader>wN',
  '<c-w>H',
  { desc = 'Move window to left', noremap = true }
)

set_keymap(
  { 'n', 'x' },
  '<leader>wE',
  '<c-w>J',
  { desc = 'Move window to bottom', noremap = true }
)

set_keymap(
  { 'n', 'x' },
  '<leader>wI',
  '<c-w>w',
  { desc = 'Move window to top', noremap = true }
)

set_keymap(
  { 'n', 'x' },
  '<leader>wO',
  '<c-w>L',
  { desc = 'Move window to right', noremap = true }
)

set_keymap(
  { 'n', 'x' },
  '<leader>wd',
  '<cmd>close<cr>',
  { desc = 'Close window', noremap = true }
)

set_keymap(
  { 'n', 'x' },
  '<leader>wh',
  '<cmd>only<cr>',
  { desc = 'Close other windows', noremap = true }
)

set_keymap(
  { 'n', 'x' },
  '<leader>wr',
  '<c-w>r',
  { desc = 'Rotate window downwards/rightwards', noremap = true }
)

set_keymap(
  { 'n', 'x' },
  '<leader>wR',
  '<c-w>R',
  { desc = 'Rotate window upwards/leftwards', noremap = true }
)

set_keymap(
  { 'n', 'x' },
  '<leader>ws',
  '<cmd>vsplit<cr>',
  { desc = 'Split window vertically', noremap = true }
)

set_keymap(
  { 'n', 'x' },
  '<leader>wS',
  '<cmd>split<cr>',
  { desc = 'Split window horizontally', noremap = true }
)

set_keymap(
  { 'n', 'x' },
  '<leader>wt',
  '<cmd>tab split<cr>',
  { desc = 'Open window in new tab', noremap = true }
)

set_keymap(
  { 'n', 'x' },
  '<leader>ww',
  '<c-w>p',
  { desc = 'Previous window', noremap = true }
)

set_keymap(
  { 'n', 'x' },
  '<leader>wx',
  '<c-w>x',
  { desc = 'Exchange window', noremap = true }
)

set_keymap(
  { 'n', 'x' },
  '<leader>yc',
  '<cmd>tabnew<cr>',
  { desc = 'New tab', noremap = true }
)

set_keymap(
  { 'n', 'x' },
  '<leader>yd',
  '<cmd>tabclose<cr>',
  { desc = 'Close tab', noremap = true }
)

set_keymap(
  { 'n', 'x' },
  '<leader>yf',
  '<cmd>tabfirst<cr>',
  { desc = 'First tab', noremap = true }
)

set_keymap(
  { 'n', 'x' },
  '<leader>yl',
  '<cmd>tablast<cr>',
  { desc = 'Last tab', noremap = true }
)

set_keymap(
  { 'n', 'x' },
  '<leader>yn',
  '<cmd>tabnext<cr>',
  { desc = 'Next tab', noremap = true }
)

set_keymap(
  { 'n', 'x' },
  '<leader>yp',
  '<cmd>tabprevious<cr>',
  { desc = 'Previous tab', noremap = true }
)
