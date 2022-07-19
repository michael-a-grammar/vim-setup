local api    = vim.api
local g      = vim.g
local keymap = vim.keymap
local opt    = vim.opt
local neon   = require'milque.neon'
local cmd    = neon.cmd
local t      = neon.t

local opts = {
  use = {
    airline     = false,
    cmp         = false,
    coc         = false,
    dracula     = true,
    easymotion  = true,
    elixir_nvim = false,
    lsp         = false,
    tender      = false
  },
  cs_override = 'solarized'
}

function opts:get_cs(opts)
  if self.use.dracula then
    return 'dracula'
  elseif self.use.tender then
    return 'tender'
  else
    return self.cs_override
  end
end

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
opt.signcolumn     = 'no'

opt.colorcolumn:append('80')
opt.cursorline = true
opt.matchtime  = 2
opt.showmatch  = true

opt.timeout     = false
opt.ttimeout    = true
opt.ttimeoutlen = 50

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

keymap.set('n', '<space>', '<nop>')
g.mapleader = t'<space>'

keymap.set('n', '..', '.')
g.maplocalleader = '.'

opt.background = 'dark'

require'plugins'(opts)
require'plugin-settings'(opts)

cmd('colorscheme ' .. opts:get_cs())

require'keymappings'(opts)
require'plugin-keymappings'(opts)
require'auto-commands'(opts)
require'user-commands'(opts)
