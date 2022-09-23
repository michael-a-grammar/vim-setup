local api     = vim.api
local g       = vim.g
local fn      = vim.fn
local keymap  = vim.keymap
local opt     = vim.opt
local neon    = require'milque.neon'
local cmd     = neon.cmd
local t       = neon.t

cmd('packadd cfilter')

opt.background = 'dark'

opt.clipboard:append('unnamed')

opt.spelllang = { 'en_gb', 'en' }

opt.fileencoding = 'utf-8'
opt.bomb         = true

opt.backspace    = { 'indent', 'eol', 'start' }
opt.expandtab    = true
opt.shiftwidth   = 2
opt.softtabstop  = 2
opt.tabstop      = 2
opt.fixendofline = true

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
  'vsplit',
  'useopen',
  'uselast'
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

opt.shortmess:append('c')
opt.showcmd         = true
opt.showmode        = false
opt.ruler           = true

opt.number         = true
opt.relativenumber = true
opt.signcolumn     = 'no'

opt.colorcolumn:append('120')
opt.cursorline = true
opt.matchtime  = 2
opt.showmatch  = true

opt.timeout     = true
opt.timeoutlen  = 800
opt.ttimeout    = true
opt.ttimeoutlen = 80

opt.backupcopy  = 'yes'
opt.updatetime  = 300
opt.writebackup = true

opt.undofile   = true
opt.undolevels = 1000
opt.undoreload = 1000

opt.concealcursor = 'nvic'
opt.conceallevel  = 1

opt.visualbell = true
api.nvim_set_option('t_vb', '')

cmd('runtime macros/matchit.vim')

opt.mouse         = 'a'
opt.termguicolors = true

keymap.set({ 'n', 'x' }, '<space>', '<nop>')
g.mapleader = t'<space>'

keymap.set({ 'n', 'x' }, '..', '.')
g.maplocalleader = '.'

require'keymappings'
require'plugins'
require'milque.mona'()

cmd('colorscheme iceberg')

local events_augroup = api.nvim_create_augroup('events', {})

api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group   = events_augroup,
  pattern = '*'
})

api.nvim_create_autocmd('BufWritePost', {
  callback = function()
    print('saved')
  end,
  group   = events_augroup,
  pattern = '*plugins/**/*.lua'
})

if g.vv then
  local vv = fn.VVset

  vv('fullscreen=1')
  vv([[fontfamily=Hasklug\ Nerd\ Font\ Mono]])
  vv('fontsize=18')
end
