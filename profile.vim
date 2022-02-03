" Initialisation "{{{
let g:is_ide    = has('ide')
let g:is_win32  = has('win32')
let g:is_unix   = has('unix')

let g:has_gui      = has('gui_running') || empty($TERM)
let g:has_terminal = !g:has_gui
let g:has_pwsh     = executable('pwsh')

let g:gui_theme      = 'tender'
let g:terminal_theme = 'dracula'
let g:override_theme = 'dracula'

let g:use_easymotion = v:false

let g:use_polyglot  = v:false
let g:use_omnisharp = v:false
let g:use_sharpenup = v:false
let g:use_ionide    = v:false

function! GetHostTheme() abort
  if !empty(g:override_theme)
    return g:override_theme
  endif

  if g:has_gui
    return g:gui_theme
  else
    return g:terminal_theme
  endif
endfunction

let g:host_theme            = GetHostTheme()
let g:host_theme_is_tender  = g:host_theme ==# 'tender'

let g:override_vbol_veol_mappings        = v:false
let g:use_arrow_keys_to_navigate_windows = v:false
"}}}

" Settings - Before anything else! "{{{
set guioptions+=M
set clipboard+=unnamed
"}}}

" Settings - Spelling "{{{
set spelllang=en_gb,en
syntax spell toplevel
"}}}

" Settings - File encoding "{{{
setglobal fileencoding=utf-8
set nobomb
"}}}

" Settings - Tabs and spaces "{{{
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set backspace=indent,eol,start
"}}}

" Settings - Whitespace visibility "{{{
set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣
set nolist
"}}}

" Settings - Buffers "{{{
set hidden
set lazyredraw
"}}}

" Settings - Splits "{{{
set splitbelow
"}}}

" Settings - Search "{{{
set hlsearch
set incsearch
set wrapscan
"}}}

" Settings - Patterns "{{{
set ignorecase
set smartcase
"}}}

" Settings - Working directory and paths "{{{
set autochdir
set path+=**
set wildignore+=*/.git/*,*/.idea/*,*/bin/*,*/obj/*,*/.meteor/*,*/node_modules/*
"}}}

" Settings - Indents "{{{
set autoindent
set breakindent
"}}}

" Settings - Lines "{{{
set nostartofline
set wrap
"}}}

" Settings - Autocompletion "{{{
set completeopt=menuone,noinsert,noselect,preview
"}}}

" Settings - Command-line "{{{
set wildmenu
set history=1000
"}}}

" Settings - Modeline "{{{
set laststatus=2
set cmdheight=1
set showcmd
set noshowmode
set ruler
set shortmess+=c
"}}}

" Settings - Line numbers "{{{
set number
set relativenumber
set signcolumn=yes:1
"}}}

" Settings - Editor guides "{{{
set cursorline
set colorcolumn+=80
set showmatch
set matchtime=2
"}}}

" Settings - Command timeouts "{{{
set ttimeout
set ttimeoutlen=50
set notimeout
"}}}

" Settings - Backup "{{{
set writebackup
set backupcopy=yes
set updatetime=300
"}}}

" Settings - Undo "{{{
set undoreload=1000
set undolevels=1000
set undofile
"}}}

" Settings - Conceal syntax "{{{
set conceallevel=1
set concealcursor=nvic
"}}}

" Settings - Visual bell "{{{
set visualbell
set t_vb=
"}}}

" Settings - Runtime "{{{
runtime macros/matchit.vim
"}}}

" Settings - GUI "{{{
if g:has_gui
  set guifont=Hasklug\ Nerd\ Font\ Mono:h16

  set guioptions+=c

  set guioptions-=b
  set guioptions-=l
  set guioptions-=m
  set guioptions-=r
  set guioptions-=L
  set guioptions-=R
  set guioptions-=T

  set guicursor+=a:blinkon0
else
  set termguicolors
endif
"}}}

" Settings - Neovim "{{{
set mouse=a
"}}}

" Settings - netrw "{{{
let g:netrw_keepdir = 0
"}}}

" Bindings - Leader key "{{{
nnoremap <space> <nop>
let g:mapleader = "\<space>"
"}}}

" Functions "{{{
let s:string_type  = type('')
let s:list_type    = type([])
let s:map_type     = type({})
let s:funcref_type = type(function('tr'))
let s:lambda_type  = type({ -> v:false })

function! IsString(val) abort
  return CompareTypes(a:val, s:string_type)
endfunction

function! IsList(val) abort
  return CompareTypes(a:val, s:list_type)
endfunction

function! IsMap(val) abort
  return CompareTypes(a:val, s:map_type)
endfunction

function! IsFuncref(val) abort
  return CompareTypes(a:val, s:funcref_type)
endfunction

function! IsLambda(val) abort
  return CompareTypes(a:val, s:lambda_type)
endfunction

function! CompareTypes(val, type_to_compare) abort
  return type(a:val) ==# a:type_to_compare
endfunction

function! Invoke(val) abort
  if IsFuncref(a:val) || IsLambda(a:val)
    call a:val()
  endif
endfunction

function! OptionExists(option) abort
  return exists('&' . a:option)
endfunction

function! ToggleOption(option) abort
  if OptionExists(a:option)
    execute 'set ' . a:option . '!'
  endif
endfunction

function! SetColorScheme(colorScheme) abort
  execute 'colorscheme ' . a:colorScheme
endfunction

function GetCurrentLine() abort
  return getline('.')
endfunction

function GetCurrentColumn() abort
  return col('.')
endfunction

function GetPreviousColumn() abort
  return GetCurrentColumn() - 1
endfunction

function GetPreviousCharacter() abort
  return GetCurrentLine()[GetPreviousColumn() - 1]
endfunction

function! GetAllLines() abort
  return getline(1, '$')
endfunction

function! SearchAllLines(expr) abort
  let l:all_lines = GetAllLines()

  if empty(l:all_lines)
    return []
  endif

  function! MapLine(idx, val) abort closure
    let l:matchstr = matchstr(a:val, a:expr)

    if empty(l:matchstr)
      return {}
    endif

    let result = {
          \ 'line_number': a:idx + 1,
          \ 'text': l:matchstr
          \ }

    return result
  endfunction

  let l:mapped_lines =
        \ map(copy(l:all_lines), function('MapLine'))

  let l:filtered_lines =
        \ filter(
          \ copy(l:mapped_lines),
          \ { _, val -> !empty(val) })

  return l:filtered_lines
endfunction

function! GetCurrentWord() abort
  return expand('<cword>')
endfunction

function! LookupCurrentWordInHelp() abort
  let l:current_word = GetCurrentWord()
  execute 'vertical botright help ' . l:current_word
endfunction

function! PreviousCharacterIsEmptyOrWhitespace() abort
  let l:previous_character = GetPreviousCharacter()

  let l:result = empty(l:previous_character) || l:previous_character =~# '\s'

  return l:result
endfunction

function! GetFolds() abort
  return SearchAllLines('\m\C^"\s*\zs.*\ze\s*"\%u007B\{3}')
endfunction

function! GetFunctions() abort
  return SearchAllLines('\m\C^\s*\<function\>!*\zs.*\ze(.*')
endfunction

function! GetOptions() abort
  return SearchAllLines('\m\C^\s*\<set\>\s*\zs\w*\ze[=\-+]*')
endfunction

function! SetPowerShellAsShell() abort
  if g:has_pwsh
    set shell=pwsh
    set shellcmdflag=-NoLogo\ -NonInteractive\ -NoProfile\ -Command
    set shellxquote="- "
  endif
endfunction
"}}}

" Commands "{{{
command! ToggleWhiteSpaceVisibility :call ToggleOption('list')
command! ToggleRelativeLineNumbers  :call ToggleOption('relativenumber')
"}}}

" Autocommand groups "{{{
augroup vim_filetype_functions
  autocmd!
  autocmd FileType vim
        \ nnoremap <buffer> <leader>hh <cmd>call LookupCurrentWordInHelp()<cr>

  autocmd FileType vim
        \ command! LookupCurrentWordInHelp :call LookupCurrentWordInHelp()
augroup end

augroup powershell_filetype_functions
  autocmd!
  autocmd FileType ps1
        \ call SetPowerShellAsShell()
augroup end

augroup events
  autocmd!
  autocmd TextYankPost * silent! lua vim.highlight.on_yank()
augroup end
"}}}

" Plugins - Plug "{{{
call plug#begin()

Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'nanotech/jellybeans.vim'
Plug 'zeis/vim-kolor'
Plug 'jacoborus/tender.vim'

Plug 'mhinz/vim-startify'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-treesitter/nvim-treesitter'

Plug 'fannheyward/telescope-coc.nvim'

Plug 'neoclide/coc.nvim', { 'branch': 'release' }

Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

Plug 'scrooloose/nerdcommenter'

Plug 'tpope/vim-fugitive'
Plug 'lewis6991/gitsigns.nvim'

if g:use_easymotion
  Plug 'easymotion/vim-easymotion'
endif

Plug 'sjl/gundo.vim'

Plug 'bfredl/nvim-miniyank'

Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-characterize'

Plug 'chaoren/vim-wordmotion'

Plug 'junegunn/vim-easy-align'
Plug 'FooSoft/vim-argwrap'

Plug 'sickill/vim-pasta'

Plug 'Wolfy87/vim-syntax-expand'

Plug 'kana/vim-textobj-user'

if g:use_polyglot
  Plug 'sheerun/vim-polyglot'
endif

Plug 'rhysd/vim-textobj-ruby'

if g:use_omnisharp
  Plug 'OmniSharp/omnisharp-vim'
endif

if g:use_sharpenup
  Plug 'nickspoons/vim-sharpenup'
endif

if g:use_ionide
  let ionide_do = g:is_win32 ? 'powershell -ExecutionPolicy Unrestricted .\install.ps1' : 'make fsautocomplete'

  Plug 'ionide/Ionide-vim', {
        \ 'do': ionide_do,
        \ }
endif

" Always load last
Plug 'ryanoasis/vim-devicons'

call plug#end()
"}}}

" Colours "{{{
call SetColorScheme(g:host_theme)
"}}}

" Plugins - Tender "{{{
if g:host_theme_is_tender
  let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
endif
"}}}

" Plugins - Airline "{{{
let g:airline_left_sep  = ''
let g:airline_right_sep = ''

let g:airline#extensions#tabline#enabled = 0

let g:airline_powerline_fonts     = 1
let g:airline_skip_empty_sections = 1
"}}}

" Plugins - Airline Themes "{{{
let g:airline_theme = g:host_theme
"}}}

" Plugins - Treesitter {{{
" }}}

" Plugins - CoC "{{{
let g:coc_global_extensions = [
      \  'coc-fsharp',
      \  'coc-html',
      \  'coc-json',
      \  'coc-markdown-preview-enhanced',
      \  'coc-markdownlint',
      \  'coc-omnisharp',
      \  'coc-powershell',
      \  'coc-prettier',
      \  'coc-snippets',
      \  'coc-solargraph',
      \  'coc-spell-checker',
      \  'coc-tsserver',
      \  'coc-vimlsp',
      \  'coc-webview',
      \  'coc-yank']

inoremap <silent><expr> <c-space> coc#refresh()

if g:has_terminal
  inoremap <silent><expr> <nul> coc#refresh()
endif

inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<c-g>u\<cr>"

inoremap <silent><expr> <tab>
      \ pumvisible() ?
        \ "\<c-n>" :
        \ PreviousCharacterIsEmptyOrWhitespace() ?
          \ "\<tab>" :
          \ coc#refresh()

inoremap <expr> <s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"
"}}}

" Plugins - NERDCommenter "{{{
let g:NERDCreateDefaultMappings = 1
"}}}

" Plugins - EasyMotion "{{{
if g:use_easymotion
  " Default - asdghklqwertyuiopzxcvbnmfj;
  let g:EasyMotion_keys             = 'ARSTGQWFPMIOLUYNE;'
  let g:EasyMotion_smartcase        = 1
  let g:EasyMotion_use_smartsign_us = 1
  let g:EasyMotion_use_upper        = 1

  map <leader><enter> <plug>(easymotion-prefix)
endif
"}}}

" Plugins - Gundo "{{{
let g:gundo_preview_bottom   = v:true
let g:gundo_right            = v:true
let g:gundo_help             = v:false
let g:gundo_map_move_older   = 'n'
let g:gundo_map_move_newer   = 'e'
let g:gundo_return_on_revert = v:true
let g:gundo_prefer_python3   = v:true
"

" Bindings - Insert mode "{{{
inoremap <c-bs> <c-w>
inoremap jj <esc>

imap <c-c> <plug>NERDCommenterInsert
"}}}

" Bindings - Remaps "{{{
if g:override_vbol_veol_mappings
  noremap $ g$
  noremap ^ g^
  noremap 0 g0
endif

noremap H g^
noremap L g$

nnoremap n nzzzv
nnoremap N Nzzzv
"}}}

" Bindings - Search "{{{
nnoremap <leader>/h <cmd>Telescope search_history<cr>

nnoremap <leader>/i <cmd>noincsearch<cr>
nnoremap <leader>/t <cmd>nohlsearch<cr>
"}}}

" Bindings - Commands "{{{
nnoremap <leader>; <cmd>Telescope commands<cr>
nnoremap <leader>: <cmd>Telescope command_history<cr>
"}}}

" Bindings - Leader key + b "{{{
nnoremap <leader>bd <cmd>bdelete<cr>
"}}}

" Bindings - Leader key + e "{{{
nnoremap <leader>ee <cmd>Telescope coc workspace_diagnostics<cr>
nnoremap <leader>eE <cmd>Telescope coc diagnostics<cr>
nmap     <leader>en <plug>(coc-diagnostic-next-error)
nmap     <leader>eN <plug>(coc-diagnostic-next)
nmap     <leader>ep <plug>(coc-diagnostic-prev-error)
nmap     <leader>eP <plug>(coc-diagnostic-prev)
"}}}

" Bindings - Leader key + f "{{{
nnoremap <leader>ff <cmd>Telescope grep_string<cr>
nnoremap <leader>fs <cmd>Telescope coc document_symbols<cr>
nnoremap <leader>fw <cmd>Telescope treesitter<cr>
"}}}

" Bindings - Leader key + g "{{{
nnoremap <leader>gb <cmd>Telescope git_branches<cr>
nnoremap <leader>gc <cmd>Telescope git_bcommits<cr>
nnoremap <leader>gC <cmd>Telescope git_commits<cr>
nnoremap <leader>gf <cmd>Telescope git_files<cr>
nnoremap <leader>gs <cmd>Telescope git_status<cr>
"}}}

" Bindings - Leader key + l "{{{
nnoremap <leader>l <cmd>NERDTreeFind<cr>
"}}}

" Bindings - Leader key + n "{{{
nnoremap <leader>nd <cmd>Telescope coc definitions<cr>
nnoremap <leader>ni <cmd>Telescope coc implementations<cr>
nnoremap <leader>no <cmd>CocList outline<cr>
nnoremap <leader>nu <cmd>Telescope coc references<cr>
"}}}

" Bindings - Leader key + p "{{{
map <leader>pn <plug>(miniyank-cycle)
map <leader>pN <plug>(miniyank-cycleback)
map <leader>pp <plug>(miniyank-startput)
map <leader>pP <plug>(miniyank-startPut)
"}}}

" Bindings - Leader key + r "{{{
nnoremap <leader>ra <cmd>Telescope coc line_code_actions<cr>
nnoremap <leader>rA <cmd>Telescope coc file_code_actions<cr>
nmap     <leader>rf <plug>(coc-format)
nmap     <leader>rn <plug>(coc-rename)
nmap     <leader>rr <plug>(coc-refactor)
"}}}

" Bindings - Leader key + t "{{{
nnoremap <leader>tf <cmd>Telescope find_files<cr>
nnoremap <leader>tg <cmd>Telescope live_grep<cr>
nnoremap <leader>th <cmd>Telescope help_tags<cr>
nnoremap <leader>tl <cmd>Telescope loclist<cr>
nnoremap <leader>tm <cmd>Telescope marks<cr>
nnoremap <leader>tp <cmd>Telescope jumplist<cr>
nnoremap <leader>tr <cmd>Telescope oldfiles<cr>
nnoremap <leader>ts <cmd>Telescope coc workspace_symbols<cr>
nnoremap <leader>tt <cmd>Telescope buffers<cr>
"}}}

" Bindings - Leader key + u "{{{
nnoremap <leader>u <cmd>GundoToggle<cr>
"}}}

" Bindings - Leader key + v "{{{
nnoremap <leader>vv <c-v>
"}}}

" Bindings - Leader key + w "{{{
nnoremap <leader>wc <cmd>close<cr>
nnoremap <leader>wh <cmd>only<cr>
nnoremap <leader>wi <c-w>k
nnoremap <leader>we <c-w>j
nnoremap <leader>wn <c-w>h
nnoremap <leader>wo <c-w>l
"}}}

" Bindings - Leader key + z "{{{
nnoremap <leader>ze <cmd>edit $MYVIMRC<cr>
nnoremap <leader>zz <cmd>source $MYVIMRC<cr>
"}}}

" Bindings - Control modifier "{{{
nnoremap <c-k> <c-w>k
nnoremap <c-j> <c-w>j
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l
"}}}

" Bindings - Arrow keys "{{{
if g:use_arrow_keys_to_navigate_windows
  nnoremap <up>    <c-w>k
  nnoremap <down>  <c-w>j
  nnoremap <left>  <c-w>h
  nnoremap <right> <c-w>l
endif
"}}}

" Lua "{{{
lua require('profile')
"}}}

" Auto-source local vim profile "{{{
if filereadable(expand('~/.vimrc.local'))
  source ~/.vimrc.local
endif
"}}}

" vim: foldmethod=marker foldlevel=0

