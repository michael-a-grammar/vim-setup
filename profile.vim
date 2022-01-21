"Initialisation "{{{
let g:vim_directory = '~/.vim'

function! GetChildVimDirectory(child_directory) abort
  return g:vim_directory . a:child_directory
endfunction

let g:is_nvim   = has('nvim')
let g:is_ide    = has('ide')
let g:is_win32  = has('win32')
let g:is_mac    = has('mac')
let g:is_macvim = has('gui_macvim')
let g:is_unix   = has('unix')

let g:has_gui     = has('gui_running') || empty($TERM)
let g:has_pwsh    = executable('pwsh')
let g:has_python3 = has('python3')

let g:gui_theme      = 'dracula'
let g:terminal_theme = 'dracula'
let g:override_theme = 'jellybeans'

let g:use_ctrlp        = v:false
let g:use_fzf          = v:false
let g:use_utilsnips    = v:false
let g:use_asyncomplete = g:has_python3 && v:false
let g:use_easymotion   = v:false

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
let g:host_theme_is_dracula = g:host_theme ==# 'dracula'

let g:use_arrow_keys_to_navigate_windows = 0
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

  if g:is_nvim
    let g:neovide_fullscreen           = v:true
    let g:neovide_remember_window_size = v:true
  endif

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
let g:netrw_home    = g:vim_directory
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
let s:lambda_type  = type({ -> 0 })

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
        \ nnoremap <buffer> <leader>hh :call LookupCurrentWordInHelp()<cr>

  autocmd FileType vim
        \ command! LookupCurrentWordInHelp :call LookupCurrentWordInHelp()
augroup end

augroup powershell_filetype_functions
  autocmd!
  autocmd FileType ps1
        \ call SetPowerShellAsShell()
augroup end

"}}}

" Plugins - Plug "{{{
call plug#begin(g:vim_directory . '/plugged')

Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'nanotech/jellybeans.vim'
Plug 'zeis/vim-kolor'

Plug 'mhinz/vim-startify'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'ctrlpvim/ctrlp.vim'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

Plug 'dense-analysis/ale'

Plug 'sirver/ultisnips'
Plug 'honza/vim-snippets'

Plug 'neoclide/coc.nvim', { 'branch': 'release' }

Plug 'prabirshrestha/asyncomplete.vim'
Plug 'Shougo/neco-vim'
Plug 'prabirshrestha/asyncomplete-necovim.vim'
Plug 'prabirshrestha/asyncomplete-ultisnips.vim'

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
call SetColorScheme(g:host_theme)
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

" Plugins - CtrlP "{{{
if g:use_ctrlp
  let g:auto_add_cwd_to_ctrlp_bookmarkdir = 1

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

  let g:ctrlp_extensions =
        \ ['quickfix', 'dir', 'rtscript', 'undo', 'line',
        \ 'changes', 'mixed', 'bookmarkdir', 'autoignore']

  function! AutoAddCwdToCtrlPBookmarkDir() abort
    if g:auto_add_cwd_to_ctrlp_bookmarkdir && &modifiable
      execute 'CtrlPBookmarkDirAdd! %:p:h'
    endif
  endfunction

  augroup all_filetype_functions
    autocmd!
    autocmd FileType *
          \ call AutoAddCwdToCtrlPBookmarkDir()
  augroup end
endif
"}}}

" Plugins - FZF "{{{
if g:use_fzf
  if g:host_theme_is_dracula
    let g:fzf_colors = {
          \ 'fg':      ['fg', 'DraculaFg'],
          \ 'bg':      ['bg', 'DraculaSubtle'],
          \ 'hl':      ['fg', 'DraculaOrange'],
          \ 'fg+':     ['fg', 'DraculaGreen'],
          \ 'bg+':     ['bg', 'DraculaSubtle'],
          \ 'hl+':     ['fg', 'DraculaOrange'],
          \ 'info':    ['fg', 'DraculaPurple'],
          \ 'border':  ['fg', 'DraculaGreen'],
          \ 'prompt':  ['fg', 'DraculaGreen'],
          \ 'pointer': ['fg', 'DraculaPink'],
          \ 'marker':  ['fg', 'Keyword'],
          \ 'spinner': ['fg', 'Label'],
          \ 'header':  ['fg', 'Comment'] }
  endif

  function! GetFolds() abort
    return SearchAllLines('\m\C^"\s*\zs.*\ze\s*"\%u007B\{3}')
  endfunction

  function! GetFunctions() abort
    return SearchAllLines('\m\C^\s*\<function\>!*\zs.*\ze(.*')
  endfunction

  function! GetOptions() abort
    return SearchAllLines('\m\C^\s*\<set\>\s*\zs\w*\ze[=\-+]*')
  endfunction

  function! FZFFolds() abort
    call CreateFZFLineJump(function('GetFolds'), 'Folds', { -> execute('foldopen') })
  endfunction

  function! FZFFunctions() abort
    call CreateFZFLineJump(function('GetFunctions'), 'Functions')
  endfunction

  function! FZFOptions() abort
    call CreateFZFLineJump(function('GetOptions'), 'Options')
  endfunction

  function! CreateFZFLineJump(get_lines, name, after_jump = 0) abort
    let l:lines = a:get_lines()

    let l:fzf_config = {
          \ 'source': map(copy(l:lines), { _, val -> val.text }),
          \ 'sink': CreateFZFLineJumpSink(l:lines, a:after_jump)
          \ }

    let l:fzf_config_wrapped = fzf#wrap(a:name, l:fzf_config, 0)

    call fzf#run(l:fzf_config_wrapped)
  endfunction

  function! CreateFZFLineJumpSink(dict, after_jump) abort
    function! FZFLineJumpSink(val) abort closure
      let l:line =
            \ filter(
              \ copy(a:dict),
              \ { _, val -> val.text ==# a:val })[0]

      if !empty(l:line)
        let l:line_number = l:line.line_number
        execute l:line_number
        call Invoke(a:after_jump)
        call feedkeys('zz')
      endif
    endfunction

    return function('FZFLineJumpSink')
  endfunction
endif
"}}}

" Plugins - UtilSnips "{{{
if g:use_utilsnips
  let g:UltiSnipsExpandTrigger='<c-c>'
  let g:UltiSnipsJumpForwardTrigger='<c-n>'
  let g:UltiSnipsJumpBackwardTrigger='<c-p>'
endif
"}}}

" Plugins - asyncomplete.vim "{{{
if g:use_asyncomplete
  let g:asyncomplete_auto_popup       = 1
  let g:asyncomplete_auto_completeopt = 1

  function! PreviousCharacterIsEmptyOrWhitespace() abort
    let l:previous_character = GetPreviousCharacter()

    let l:result = empty(l:previous_character) || l:previous_character =~# '\s'

    return l:result
  endfunction

  inoremap <silent><expr><tab>
        \ pumvisible() ?
          \ "\<c-n>" :
          \ PreviousCharacterIsEmptyOrWhitespace() ?
            \ "\<tab>" :
            \ asyncomplete#force_refresh()

  inoremap <expr><s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"
  inoremap <expr><cr> pumvisible() ? asyncomplete#close_popup() : "\<cr>"

  autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

  autocmd! User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#necovim#get_source_options({
        \ 'name': 'necovim',
        \ 'allowlist': ['vim'],
        \ 'completor': function('asyncomplete#sources#necovim#completor'),
        \ }))

  autocmd! User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#ultisnips#get_source_options({
        \ 'name': 'ultisnips',
        \ 'allowlist': ['*'],
        \ 'completor': function('asyncomplete#sources#ultisnips#completor'),
        \ }))
endif
"}}}

" Plugins - EasyMotion "{{{
if g:use_easymotion
  " Default - asdghklqwertyuiopzxcvbnmfj;
  let g:EasyMotion_keys             = 'ARSTGQWFPMIOLUYNE;'
  let g:EasyMotion_smartcase        = 1
  let g:EasyMotion_use_smartsign_us = 1
  let g:EasyMotion_use_upper        = 1

  map <Enter> <Plug>(easymotion-prefix)
endif
"}}}

" Bindings - Insert mode "{{{
inoremap <c-bs> <c-w>
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

" Auto-source local vim profile "{{{
if filereadable(expand('~/.vimrc.local'))
  source ~/.vimrc.local
endif
"}}}

" vim: foldmethod=marker foldlevel=0

