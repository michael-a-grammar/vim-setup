vim.keymap.set(
  'c',
  '<a-left>',
  '<c-left>',
  { desc = 'Word backwards', noremap = true }
)

vim.keymap.set(
  'c',
  '<a-right>',
  '<c-right>',
  { desc = 'Word forwards', noremap = true }
)

vim.keymap.set(
  'i',
  '<esc>',
  '<esc><esc>',
  { desc = 'Return to normal mode', noremap = true }
)

vim.keymap.set(
  'i',
  'jj',
  '<esc>',
  { desc = 'Return to normal mode', noremap = false }
)

vim.keymap.set(
  { 'n', 'x' },
  '<c-down>',
  '<c-w>j',
  { desc = 'Move to bottom window', noremap = true }
)

vim.keymap.set(
  { 'n', 'x' },
  '<c-up>',
  '<c-w>w',
  { desc = 'Move to top window', noremap = true }
)

vim.keymap.set(
  { 'n', 'x' },
  '<c-left>',
  '<c-w>h',
  { desc = 'Move to left window', noremap = true }
)

vim.keymap.set(
  { 'n', 'x' },
  '<c-right>',
  '<c-w>l',
  { desc = 'Move to right window', noremap = true }
)

vim.keymap.set(
  { 'n', 'x' },
  '<c-f>',
  '<c-u>',
  { desc = 'Scroll up', noremap = true }
)

vim.keymap.set(
  { 'n', 'x' },
  '<c-p>',
  '<c-d>',
  { desc = 'Scroll down', noremap = true }
)

vim.keymap.set(
  { 'n', 'x' },
  '0',
  'g0',
  { desc = 'Beginning of line', noremap = true }
)

vim.keymap.set(
  { 'n', 'x' },
  '^',
  'g^',
  { desc = 'Start of line', noremap = true }
)

vim.keymap.set(
  { 'n', 'x' },
  'H',
  'g^',
  { desc = 'Start of line', noremap = true }
)

vim.keymap.set(
  { 'n', 'x' },
  '$',
  'g$',
  { desc = 'End of line', noremap = true }
)

vim.keymap.set(
  { 'n', 'x' },
  'L',
  'g$',
  { desc = 'End of line', noremap = true }
)

vim.keymap.set(
  { 'n', 'x' },
  '-',
  'ddp',
  { desc = 'Move line down', noremap = true }
)

vim.keymap.set(
  { 'n', 'x' },
  '_',
  'dd<up>P',
  { desc = 'Move line up', noremap = true }
)

vim.keymap.set(
  { 'n', 'x' },
  'n',
  'nzzzv',
  { desc = 'Next match and centre', noremap = true }
)

vim.keymap.set(
  { 'n', 'x' },
  'N',
  'Nzzzv',
  { desc = 'Previous match and centre', noremap = true }
)

vim.keymap.set({ 'n', 'x' }, 'U', '<c-r>', { desc = 'Redo', noremap = true })

vim.keymap.set(
  { 'n', 'x' },
  'gd',
  vim.lsp.buf.definition,
  { desc = 'Go to definition', noremap = true }
)

vim.keymap.set(
  { 'n', 'x' },
  'gm',
  vim.lsp.buf.implementation,
  { desc = 'Go to implementation', noremap = true }
)

vim.keymap.set(
  { 'n', 'x' },
  'gy',
  vim.lsp.buf.type_definition,
  { desc = 'Go to type definition', noremap = true }
)

vim.keymap.set(
  { 'n', 'x' },
  'h',
  vim.lsp.buf.hover,
  { desc = 'Hover', noremap = true }
)

vim.keymap.set(
  { 'n', 'x' },
  '<leader>!',
  ':!',
  { desc = 'Shell command', noremap = true }
)

vim.keymap.set(
  { 'n', 'x' },
  '<leader><tab>',
  '<c-^>',
  { desc = 'Last buffer', noremap = true }
)

vim.keymap.set(
  { 'n', 'x' },
  '<leader>di',
  vim.diagnostic.open_float,
  { desc = 'Info', noremap = true }
)

vim.keymap.set(
  { 'n', 'x' },
  '<leader>dl',
  vim.diagnostic.setloclist,
  { desc = 'Set loclist with diagnostics', noremap = true }
)

vim.keymap.set(
  { 'n', 'x' },
  '<leader>dn',
  vim.diagnostic.goto_next,
  { desc = 'Next diagnostic', noremap = true }
)

vim.keymap.set(
  { 'n', 'x' },
  '<leader>dp',
  vim.diagnostic.goto_prev,
  { desc = 'Previous diagnostic', noremap = true }
)

vim.keymap.set(
  { 'n', 'x' },
  '<leader>ea',
  vim.lsp.buf.code_action,
  { desc = 'Action', noremap = true }
)

vim.keymap.set(
  { 'n', 'x' },
  '<leader>ef',
  vim.lsp.buf.format,
  { desc = 'Format', noremap = true }
)

vim.keymap.set(
  { 'n', 'x' },
  '<leader>eh',
  vim.lsp.buf.hover,
  { desc = 'Hover', noremap = true }
)

vim.keymap.set(
  { 'n', 'x' },
  '<leader>er',
  vim.lsp.buf.rename,
  { desc = 'Rename', noremap = true }
)

vim.keymap.set(
  { 'n', 'x' },
  '<leader>es',
  vim.lsp.buf.signature_help,
  { desc = 'Signature help', noremap = true }
)

vim.keymap.set({ 'n', 'x' }, '<leader>et', function()
  vim.lsp.buf.codelens.run()
end, { desc = 'Run test', noremap = true })

vim.keymap.set(
  { 'n', 'x' },
  '<leader>fo',
  '<c-o>',
  { desc = 'Backwards', noremap = true }
)

vim.keymap.set(
  { 'n', 'x' },
  '<leader>fi',
  '<c-i>',
  { desc = 'Forwards', noremap = true }
)

vim.keymap.set(
  { 'n', 'x' },
  '<leader>kh',
  '<cmd>set nohlsearch<cr>',
  { desc = 'Disable highlighted search results', noremap = true }
)

vim.keymap.set(
  { 'n', 'x' },
  '<leader>ki',
  '<cmd>set noincsearch<cr>',
  { desc = 'Disable incremental search', noremap = true }
)

vim.keymap.set(
  { 'n', 'x' },
  '<leader>p/',
  ':s/',
  { desc = 'Substitute within line', noremap = true }
)

vim.keymap.set(
  { 'n', 'x' },
  '<leader>p?',
  ':%s/',
  { desc = 'Substitute within buffer', noremap = true }
)

vim.keymap.set(
  { 'n', 'x' },
  '<leader>pd',
  '<c-x>',
  { desc = 'Decrement', noremap = true }
)

vim.keymap.set(
  { 'n', 'x' },
  '<leader>pi',
  '<c-a>',
  { desc = 'Increment', noremap = true }
)

vim.keymap.set(
  'x',
  '<leader>ps',
  ':sort<cr>',
  { desc = 'Sort', noremap = true }
)

vim.keymap.set(
  { 'n', 'x' },
  '<leader>qq',
  '<cmd>quitall<cr>',
  { desc = 'Quit all', noremap = true }
)

vim.keymap.set(
  { 'n', 'x' },
  '<leader>qQ',
  '<cmd>quitall!<cr>',
  { desc = '' .. ' Quit all', noremap = true }
)

vim.keymap.set(
  { 'n', 'x' },
  '<leader>tc',
  '<cmd>new<cr>',
  { desc = 'New buffer', noremap = true }
)

vim.keymap.set(
  { 'n', 'x' },
  '<leader>td',
  '<cmd>bdelete<cr>',
  { desc = 'Delete buffer', noremap = true }
)

vim.keymap.set(
  { 'n', 'x' },
  '<leader>tD',
  '<cmd>bdelete!<cr>',
  { desc = '' .. ' Delete buffer', noremap = true }
)

vim.keymap.set(
  { 'n', 'x' },
  '<leader>tn',
  '<cmd>bnext<cr>',
  { desc = 'Next buffer', noremap = true }
)

vim.keymap.set(
  { 'n', 'x' },
  '<leader>tp',
  '<cmd>bprevious<cr>',
  { desc = 'Previous buffer', noremap = true }
)

vim.keymap.set(
  { 'n', 'x' },
  '<leader>tw',
  '<cmd>vertical ball<cr>',
  { desc = 'Open buffers in vertical splits', noremap = true }
)

vim.keymap.set(
  { 'n', 'x' },
  '<leader>tW',
  '<cmd>ball<cr>',
  { desc = 'Open buffers in horizontal splits', noremap = true }
)

vim.keymap.set(
  { 'n', 'x' },
  '<leader>tx',
  '<cmd>%bdelete | edit#<cr>',
  { desc = 'Delete other buffers', noremap = true }
)

vim.keymap.set(
  { 'n', 'x' },
  '<leader>tX',
  '<cmd>%bdelete! | edit#<cr>',
  { desc = '' .. ' Delete other buffers', noremap = true }
)

vim.keymap.set(
  { 'n', 'x' },
  '<leader>ty',
  '<cmd>tab ball<cr>',
  { desc = 'Open buffers in tabs', noremap = true }
)

vim.keymap.set(
  { 'n', 'x' },
  '<leader>w.',
  '<c-w>>',
  { desc = 'Increase window width', noremap = true }
)

vim.keymap.set(
  { 'n', 'x' },
  '<leader>w,',
  '<c-w><',
  { desc = 'Decrease window width', noremap = true }
)

vim.keymap.set(
  { 'n', 'x' },
  '<leader>w|',
  '<c-w>|',
  { desc = 'Maximise window width', noremap = true }
)

vim.keymap.set(
  { 'n', 'x' },
  '<leader>w+',
  '<c-w>+',
  { desc = 'Increase window height', noremap = true }
)

vim.keymap.set(
  { 'n', 'x' },
  '<leader>w-',
  '<c-w>-',
  { desc = 'Decrease window height', noremap = true }
)

vim.keymap.set(
  { 'n', 'x' },
  '<leader>w_',
  '<c-w>_',
  { desc = 'Maximise window height', noremap = true }
)

vim.keymap.set(
  { 'n', 'x' },
  '<leader>w=',
  '<c-w>=',
  { desc = 'Equalise window size', noremap = true }
)

vim.keymap.set(
  { 'n', 'x' },
  '<leader>wn',
  '<c-w>h',
  { desc = 'Move to left window', noremap = true }
)

vim.keymap.set(
  { 'n', 'x' },
  '<leader>we',
  '<c-w>j',
  { desc = 'Move to bottom window', noremap = true }
)

vim.keymap.set(
  { 'n', 'x' },
  '<leader>wi',
  '<c-w>w',
  { desc = 'Move to top window', noremap = true }
)

vim.keymap.set(
  { 'n', 'x' },
  '<leader>wo',
  '<c-w>l',
  { desc = 'Move to right window', noremap = true }
)

vim.keymap.set(
  { 'n', 'x' },
  '<leader>wN',
  '<c-w>H',
  { desc = 'Move window to left', noremap = true }
)

vim.keymap.set(
  { 'n', 'x' },
  '<leader>wE',
  '<c-w>J',
  { desc = 'Move window to bottom', noremap = true }
)

vim.keymap.set(
  { 'n', 'x' },
  '<leader>wI',
  '<c-w>w',
  { desc = 'Move window to top', noremap = true }
)

vim.keymap.set(
  { 'n', 'x' },
  '<leader>wO',
  '<c-w>L',
  { desc = 'Move window to right', noremap = true }
)

vim.keymap.set(
  { 'n', 'x' },
  '<leader>wd',
  '<cmd>close<cr>',
  { desc = 'Close window', noremap = true }
)

vim.keymap.set(
  { 'n', 'x' },
  '<leader>wh',
  '<cmd>only<cr>',
  { desc = 'Close other windows', noremap = true }
)

vim.keymap.set(
  { 'n', 'x' },
  '<leader>wr',
  '<c-w>r',
  { desc = 'Rotate window downwards/rightwards', noremap = true }
)

vim.keymap.set(
  { 'n', 'x' },
  '<leader>wR',
  '<c-w>R',
  { desc = 'Rotate window upwards/leftwards', noremap = true }
)

vim.keymap.set(
  { 'n', 'x' },
  '<leader>ws',
  '<cmd>vsplit<cr>',
  { desc = 'Split window vertically', noremap = true }
)

vim.keymap.set(
  { 'n', 'x' },
  '<leader>wS',
  '<cmd>split<cr>',
  { desc = 'Split window horizontally', noremap = true }
)

vim.keymap.set(
  { 'n', 'x' },
  '<leader>wt',
  '<cmd>tab split<cr>',
  { desc = 'Open window in new tab', noremap = true }
)

vim.keymap.set(
  { 'n', 'x' },
  '<leader>ww',
  '<c-w>p',
  { desc = 'Previous window', noremap = true }
)

vim.keymap.set(
  { 'n', 'x' },
  '<leader>wx',
  '<c-w>x',
  { desc = 'Exchange window', noremap = true }
)

vim.keymap.set(
  { 'n', 'x' },
  '<leader>yc',
  '<cmd>tabnew<cr>',
  { desc = 'New tab', noremap = true }
)

vim.keymap.set(
  { 'n', 'x' },
  '<leader>yd',
  '<cmd>tabclose<cr>',
  { desc = 'Close tab', noremap = true }
)

vim.keymap.set(
  { 'n', 'x' },
  '<leader>yf',
  '<cmd>tabfirst<cr>',
  { desc = 'First tab', noremap = true }
)

vim.keymap.set(
  { 'n', 'x' },
  '<leader>yl',
  '<cmd>tablast<cr>',
  { desc = 'Last tab', noremap = true }
)

vim.keymap.set(
  { 'n', 'x' },
  '<leader>yn',
  '<cmd>tabnext<cr>',
  { desc = 'Next tab', noremap = true }
)

vim.keymap.set(
  { 'n', 'x' },
  '<leader>yp',
  '<cmd>tabprevious<cr>',
  { desc = 'Previous tab', noremap = true }
)
