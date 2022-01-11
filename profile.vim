"Initialisation "{{{
let g:vim_directory = '~/.vim'

let g:is_nvim   = has('nvim')
let g:is_ide    = has('ide')
let g:is_win32  = has('win32')
let g:is_mac    = has('mac')
let g:is_macvim = has('gui_macvim')
let g:is_unix   = has('unix')

let g:has_gui  = has('gui_running') || empty($TERM)
let g:has_pwsh = executable('pwsh')

let g:use_arrow_keys_to_navigate_windows = 0
let g:auto_add_cwd_to_ctrlp_bookmarkdir  = exists(':CtrlP') && 1

if !g:is_nvim
  set nocompatible
  set background=dark

  if !exists("g:syntax_on")
    syntax enable
  endif

  filetype on
  filetype plugin on
  filetype indent on
endif
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
set wildignore+=*/.git/*,*/.idea/*,*/.meteor/*,*/node_modules/*
"}}}

" Settings - Indents "{{{
set autoindent
set breakindent
"}}}

" Settings - Lines "{{{
set nostartofline
set wrap
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
"}}}

" Settings - Line numbers "{{{
set number
set relativenumber
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

" Settings - Swap "{{{
set directory=~/.vim/swap/
"}}}

" Settings - Backup "{{{
set writebackup
set backupcopy=yes
set updatetime=750
set backupdir=~/.vim/backup/
"}}}

" Settings - Undo "{{{
set undodir=~/.vim/undo/
set undoreload=1000
set undolevels=1000
set undofile
"}}}

" Settings - viminfo "{{{
set shadafile=~/.vim/main.shada
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
  if g:is_macvim
    set macthinstrokes
    set macligatures
    set antialias
    set fullscreen
  endif

  set guifont=Hasklug\ Nerd\ Font\ Mono:h18

  set guioptions+=c

  set guioptions-=b
  set guioptions-=l
  set guioptions-=m
  set guioptions-=r
  set guioptions-=L
  set guioptions-=R
  set guioptions-=T

  set guicursor+=a:blinkon0

  let g:neovide_fullscreen           = v:true
  let g:neovide_remember_window_size = v:true
else
  set termguicolors
endif
"}}}

" Settings - netrw "{{{
let g:netrw_home    = g:vim_directory
let g:netrw_keepdir = 0
"}}}

" Bindings - Leader key "{{{
let g:mapleader = "<space>"
map <space> <leader>
"}}}

" Bindings - Insert mode escape "{{{
inoremap jj <esc>
"}}}

" Bindings - Search toggles "{{{
nnoremap <leader>/t :nohlsearch<cr>
nnoremap <leader>/i :noincsearch<cr>
"}}}

" Bindings - Remaps "{{{
noremap 0 g0
noremap ^ g^
noremap $ g$

noremap H g^
noremap L g$

nnoremap n nzzzv
nnoremap N Nzzzv
"}}}

" Bindings - Leader key + e "{{{
nnoremap <leader>ee :CtrlPQuickfix<cr>
"}}}

" Bindings - Leader key + f "{{{
nnoremap <leader>fl :CtrlPLine<cr>
nnoremap <leader>fr :CtrlPMRU<cr>
"}}}

" Bindings - Leader key + g "{{{
nnoremap <leader>gc :CtrlPChange<cr>
"}}}

" Bindings - Leader key + l "{{{
nnoremap <leader>l :NERDTreeFind<cr>
"}}}

" Bindings - Leader key + t "{{{
nnoremap <leader>tm :CtrlPBookmarkDir<cr>
nnoremap <leader>tt :CtrlPBuffer<cr>
nnoremap <leader>tM :CtrlPBookmarkDirAdd
"}}}

" Bindings - Leader key + v "{{{
nnoremap <leader>vv <c-v>
"}}}

" Bindings - Leader key + w "{{{
nnoremap <leader>wi <c-w>k
nnoremap <leader>we <c-w>j
nnoremap <leader>wn <c-w>h
nnoremap <leader>wo <c-w>l
"}}}

" Bindings - Leader key + z "{{{
nnoremap <leader>ze :edit $MYVIMRC<cr>
nnoremap <leader>zz :source $MYVIMRC<cr>
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

" Functions "{{{
function! OptionExists(option) abort
  return exists('&' . a:option)
endfunction

function! ToggleOption(option) abort
  if OptionExists(a:option)
    execute 'set ' . a:option . '!'
  endif
endfunction

function! GetBufferContents() abort
  return getline(1, '$')
endfunction

function! SearchBufferContents(expr) abort
  let l:buffer_contents = GetBufferContents()

  if empty(l:buffer_contents)
    return []
  endif

  function! MapBufferLine(idx, val) closure
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

  let l:mapped_buffer_contents =
        \ map(copy(l:buffer_contents), function('MapBufferLine'))

  let l:filtered_buffer_contents =
        \ filter(
          \ copy(l:mapped_buffer_contents),
          \ { _, val -> !empty(val) })

  return l:filtered_buffer_contents
endfunction

function! GetCurrentWord() abort
  return expand("<cword>")
endfunction

function! LookupCurrentWordInHelp() abort
  let l:current_word = GetCurrentWord()
  execute 'vertical botright help ' . l:current_word
endfunction

function! SetPowerShellAsShell() abort
  if g:has_pwsh
    set shell=pwsh
    set shellcmdflag=-NoLogo\ -NonInteractive\ -NoProfile\ -Command
    set shellxquote="- "
  endif
endfunction

function! AutoAddCwdToCtrlPBookmarkDir() abort
  if g:auto_add_cwd_to_ctrlp_bookmarkdir && &modifiable
    execute 'CtrlPBookmarkDirAdd! %:p:h'
  endif
endfunction
"}}}

" Commands "{{{
command! ToggleRelativeLineNumbers :call ToggleOption('relativenumber')
"}}}

" Autocommand groups "{{{
augroup vim_filetype_functions
  autocmd!
  autocmd FileType vim
        \ nnoremap <buffer> <leader>hh :call LookupCurrentWordInHelp()<cr>

  autocmd FileType vim
        \ command! LookupCurrentWordInHelp :call LookupCurrentWordInHelp()
augroup end

augroup powershell_filetype_functions
  autocmd!
  autocmd FileType ps1
        \ call SetPowerShellAsShell()
augroup end

augroup all_filetype_functions
  autocmd!
  autocmd FileType *
        \ call AutoAddCwdToCtrlPBookmarkDir()
augroup end
"}}}

" Plugins - Plug "{{{
call plug#begin('~/.vim/plugged')

Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'nanotech/jellybeans.vim'
Plug 'zeis/vim-kolor'

Plug 'mhinz/vim-startify'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'ctrlpvim/ctrlp.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'dense-analysis/ale'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'sirver/ultisnips'

Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

Plug 'scrooloose/nerdcommenter'

Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

Plug 'easymotion/vim-easymotion'

Plug 'machakann/vim-highlightedyank'

Plug 'sjl/gundo.vim'

Plug 'maxbrunsfeld/vim-yankstack'

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

Plug 'OmniSharp/omnisharp-vim'
Plug 'nickspoons/vim-sharpenup'

Plug 'ionide/Ionide-vim', {
      \ 'do':  'make fsautocomplete',
      \ }

" Always load last
Plug 'ryanoasis/vim-devicons'

call plug#end()
"}}}

" Colours "{{{
if g:has_gui
  colorscheme jellybeans
else
  let g:airline_theme = 'dracula'
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
if g:has_gui
  let g:airline_theme = 'jellybeans'
else
  let g:airline_theme = 'dracula'
endif
"}}}

" Plugins - CtrlP "{{{
let g:ctrlp_map                 = '<leader>f'
let g:ctrlp_regexp              = 0
let g:ctrlp_match_window        = 'bottom,order:ttb,min:1,max:10,results:10'
let g:ctrlp_root_markers        = ['.sln']
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_cache_dir           = '~/.vim/ctrlp'
let g:ctrlp_show_hidden         = 1
let g:ctrlp_open_new_file       = 'r'
let g:ctrlp_follow_symlinks     = 1
let g:ctrlp_line_prefix         = ' '

let g:ctrlp_extensions = ['quickfix', 'dir', 'rtscript', 'undo', 'line',
                          \ 'changes', 'mixed', 'bookmarkdir', 'autoignore']
"}}}

" Plugins - FZF "{{{
function! GetFolds() abort
  return SearchBufferContents('^"\s*\zs.*\ze "\%u007B\{3}')
endfunction

let g:folds = GetFolds()

function! FZFFoldSink(val)
endfunction

let g:fzf_folds = {
      \ 'source': map(g:folds, { _, val -> val.text }),
      \ 'sink': function('FZFFoldSink')
      \ }
"}}}

nnoremap <leader>aa :call fzf#run(g:fzf_folds)<cr>

" Plugins - EasyMotion "{{{
map <Enter> <Plug>(easymotion-prefix)

" Default - asdghklqwertyuiopzxcvbnmfj;
let g:EasyMotion_keys             = 'ARSTGQWFPMIOLUYNE;'
let g:EasyMotion_smartcase        = 1
let g:EasyMotion_use_smartsign_us = 1
let g:EasyMotion_use_upper        = 1
"}}}

" Auto-source local vim profile "{{{
if filereadable(expand('~/.vimrc.local'))
  source ~/.vimrc.local
endif
"}}}

" vim: foldmethod=marker foldlevel=0

