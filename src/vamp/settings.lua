vim.api.nvim_exec('packadd cfilter', false)

vim.opt.background = 'dark'

vim.opt.clipboard:append('unnamed')

vim.opt.spelllang = { 'en_gb', 'en' }

vim.opt.fileencoding = 'utf-8'
vim.opt.bomb = true

vim.opt.backspace = { 'indent', 'eol', 'start' }
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.tabstop = 2
vim.opt.fixendofline = true

vim.opt.list = false

vim.opt.listchars = {
  eol = '¬',
  extends = '>',
  precedes = '<',
  space = '␣',
  tab = '>·',
  trail = '~',
}

vim.opt.hidden = true

vim.opt.switchbuf = {
  'uselast',
}

vim.opt.hlsearch = true
vim.opt.splitbelow = true
vim.opt.wrapscan = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.autochdir = false

vim.opt.path:append('**')

vim.opt.wildignore = {
  '*/.git/*',
  '*/.idea/*',
  '*/.meteor/*',
  '*/node_modules/*',
}

vim.opt.autoindent = true
vim.opt.breakindent = true

vim.opt.startofline = false
vim.opt.wrap = true

vim.opt.completeopt = {
  'menu',
  'menuone',
  'noinsert',
  'noselect',
  'preview',
}

vim.opt.history = 1000
vim.opt.wildmenu = true

vim.opt.cmdheight = 1
vim.opt.laststatus = 2

vim.opt.shortmess:append('c')
vim.opt.showcmd = true
vim.opt.showmode = false
vim.opt.ruler = true

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = 'yes'

vim.opt.colorcolumn:append('120')
vim.opt.cursorline = true
vim.opt.matchtime = 2
vim.opt.showmatch = true

vim.opt.timeout = true
vim.opt.timeoutlen = 800
vim.opt.ttimeout = true
vim.opt.ttimeoutlen = 80

vim.opt.backup = false
vim.opt.backupcopy = 'auto'
vim.opt.updatetime = 300
vim.opt.writebackup = false

vim.opt.undofile = true
vim.opt.undolevels = 1000
vim.opt.undoreload = 1000

vim.opt.concealcursor = 'nvic'
vim.opt.conceallevel = 1

vim.opt.visualbell = true
vim.api.nvim_set_option('t_vb', '')

vim.api.nvim_exec('runtime macros/matchit.vim', false)

vim.opt.mouse = 'a'
vim.opt.termguicolors = true

local define_sign = function(name, icon)
  name = 'DiagnosticSign' .. name

  vim.fn.sign_define(name, {
    texthl = name,
    text = icon,
    numhl = '',
  })
end

define_sign('Error', '')
define_sign('Warn', '')
define_sign('Hint', '')
define_sign('Info', '')

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = 'rounded',
})

vim.lsp.handlers['textDocument/signatureHelp'] =
  vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = 'rounded',
  })

vim.diagnostic.config({
  float = {
    border = 'rounded',
  },
})

local events_augroup = vim.api.nvim_create_augroup('events', {})

vim.api.nvim_create_autocmd('TextYankPost', {
  group = events_augroup,
  pattern = '*',
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.g['mapleader'] = vim.api.nvim_replace_termcodes('<space>', true, true, true)
vim.g['maplocalleader'] = vim.api.nvim_replace_termcodes('\\', true, true, true)
