return function()
  local api     = vim.api
  local exec    = vim.api.nvim_exec
  local g       = vim.g
  local fn      = vim.fn
  local opt     = vim.opt

  exec('packadd cfilter', false)

  opt.background = 'dark'

  opt.clipboard:append('unnamed')

  opt.spelllang = { 'en_gb', 'en', }

  opt.fileencoding = 'utf-8'
  opt.bomb         = true

  opt.backspace    = { 'indent', 'eol', 'start', }
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
    trail    = '~',
  }

  opt.hidden     = true
  opt.lazyredraw = true
  opt.switchbuf  = {
    'uselast',
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
    '*/node_modules/*',
  }

  opt.autoindent  = true
  opt.breakindent = true

  opt.startofline = false
  opt.wrap        = true

  opt.completeopt = {
    'menu',
    'menuone',
    'noinsert',
    'noselect',
    'preview',
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
  opt.signcolumn     = 'yes'

  opt.colorcolumn:append('120')
  opt.cursorline = true
  opt.matchtime  = 2
  opt.showmatch  = true

  opt.timeout     = true
  opt.timeoutlen  = 800
  opt.ttimeout    = true
  opt.ttimeoutlen = 80

  opt.backup      = false
  opt.backupcopy  = 'auto'
  opt.updatetime  = 300
  opt.writebackup = false

  opt.undofile   = true
  opt.undolevels = 1000
  opt.undoreload = 1000

  opt.concealcursor = 'nvic'
  opt.conceallevel  = 1

  opt.visualbell = true
  api.nvim_set_option('t_vb', '')

  exec('runtime macros/matchit.vim', false)

  opt.mouse         = 'a'
  opt.termguicolors = true

  local define_sign = function(name, icon)
    name = 'DiagnosticSign' .. name

    vim.fn.sign_define(name, {
      texthl = name,
      text   = icon,
      numhl  = ''
    })
  end

  define_sign('Error', '')
  define_sign('Warn',  '')
  define_sign('Hint',  '')
  define_sign('Info',  '')

  vim.lsp.handlers['textDocument/hover'] =
    vim.lsp.with(vim.lsp.handlers.hover, {
      border = 'rounded',
    })

  vim.lsp.handlers['textDocument/signatureHelp'] =
    vim.lsp.with(vim.lsp.handlers.signature_help, {
      border = 'rounded',
    })

  vim.diagnostic.config {
    float = {
      border = 'rounded',
    },
  }

  local events_augroup = api.nvim_create_augroup('events', {})

  api.nvim_create_autocmd('TextYankPost', {
    group    = events_augroup,
    pattern  = '*',
    callback = function()
      vim.highlight.on_yank()
    end
  })
end
