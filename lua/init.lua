local api    = vim.api
local g      = vim.g
local keymap = vim.keymap
local opt    = vim.opt
local neon   = require'neon'
local cmd    = neon.cmd
local t      = neon.t

local opts = {
  use = {
    coc         = false,
    dracula     = true,
    easymotion  = true,
    lsp         = false,
    tender      = false
  },
  cs_override = '',
  migration_point = true
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
opt.signcolumn     = 'yes:1'

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

require'plugins'(opts)
require'plugin-settings'(opts)

local nine_to_five = require'milque.nine-to-five'
local sludge       = require'milque.sludge'
local togs         = require'milque.togs'

cmd('colorscheme ' .. opts:get_cs())

api.nvim_create_user_command('Leader',
  function(opts)
    neon:leader(opts.fargs[1])
  end, {
    nargs = 1
  })

api.nvim_create_user_command('GetAllWds', nine_to_five.get_all_wds, {})
api.nvim_create_user_command('TgACD', togs.tg_autochdir, {})
api.nvim_create_user_command('TgList', togs.tg_list, {})
api.nvim_create_user_command('TgNU', togs.tg_number, {})
api.nvim_create_user_command('TgRNU', togs.tg_relativenumber, {})

local events_augroup = api.nvim_create_augroup('events', {})

api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group    = events_augroup,
  pattern  = '*'
})

if opts.migration_point then
  print('migration point active')
end
