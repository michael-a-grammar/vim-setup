local opt = vim.opt

opt.clipboard:append('unnamed')
opt.guioptions:append('M')

opt.spelllang = { 'en_gb', 'en' }

opt.fileencoding = 'utf-8'
opt.nobomb       = true

opt.backspace   = { 'indent', 'eol', 'start' }
opt.expandtab   = true
opt.shiftwidth  = 2
opt.softtabstop = 2
opt.tabstop     = 2

opt.list      = false
opt.listchars = {
  eol      = '¬',
  extends  = '>',
  precedes = '<',
  space    = '␣',
  tab      = '>·',
  trail    = '~'
}

opt.hidden     = true
opt.lazyredraw = true
opt.switchbuf  = {
  'uselast',
  'useopen',
  'vsplit'
}

opt.hlsearch   = true
opt.splitbelow = true
opt.wrapscan   = true

opt.ignorecase = true
opt.smartcase  = true

opt.autochdir = false
opt.path:append('**')
opt.wildignore = {
 '*/.git/*',
 '*/.idea/*',
 '*/.meteor/*',
 '*/node_modules/*'
}

opt.autoindent  = true
opt.breakindent = true

opt.startofline = false
opt.wrap        = true

opt.completeopt = {
  'menuone',
  'noinsert',
  'noselect',
  'preview'
}

opt.history  = 1000
opt.wildmenu = true

opt.cmdheight  = 1
opt.laststatus = 2
opt.ruler      = true
opt.shortmess:append('c')
opt.showcmd    = true
opt.showmode   = false

opt.number         = true
opt.relativenumber = true
opt.signcolumn     = 'yes:1'

opt.colorcolumn:append(80)
opt.cursorline = true
opt.matchtime  = 2
opt.showmatch  = true

opt.timeout     = false
opt.ttimeout    = true
opt.ttimeoutlen = 50

opt.backupcopy = 'yes'
opt.updatetime = 300
opt.writeback  = true

opt.undofile   = true
opt.undolevel  = 1000
opt.undoreload = 1000

opt.concealcursor = 'nvic'
opt.conceallevel  = 1

opt.visualbell = true
vim.api.nvim_set_option('t_vb')

vim.cmd([[runtime macros/matchit.vim]])

opt.mouse         = 'a'
opt.termguicolors = true

require('leader')

