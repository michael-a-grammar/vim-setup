" Initialisation "{{{
let g:is_nvim      = has('nvim')
let g:is_macvim    = has('gui_macvim')
let g:has_gui      = has('gui_running') || empty($TERM)
let g:has_terminal = !g:has_gui

let g:gui_theme      = 'tender'
let g:terminal_theme = 'dracula'
let g:override_theme = ''

let g:use_easymotion = v:true
let g:use_polyglot   = v:true

if !g:is_nvim
  set nocompatible
endif

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

let g:host_theme               = GetHostTheme()
let g:host_theme_is_dracula    = g:host_theme ==# 'dracula'
let g:host_theme_is_jellybeans = g:host_theme ==# 'jellybeans'
let g:host_theme_is_tender     = g:host_theme ==# 'tender'

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
set noautochdir
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
  if g:is_macvim
    set antialias
    set fullscreen
    set macligatures
    set macthinstrokes
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
let g:netrw_keepdir = 0
"}}}

" Bindings - Leader key "{{{
nnoremap <space> <nop>
let g:mapleader = "\<space>"
let maplocalleader = "\\"
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

function! GetCurrentWORD() abort
  return expand('<cWORD>')
endfunction

function! LookupWordInHelp(arg) abort
  execute 'vertical botright help ' . a:arg
endfunction

function! LookupCurrentWordInHelp() abort
  let l:current_word = GetCurrentWord()
  call LookupWordInHelp(l:current_word)
endfunction

function! LookupCurrentWORDInHelp() abort
  let l:current_word = GetCurrentWORD()
  call LookupWordInHelp(l:current_word)
endfunction

function! ReplaceWord(arg) abort
  call feedkeys(':%s/' . a:arg . '//g' . "\<left>\<left>")
endfunction

function! ReplaceCurrentWord() abort
  let l:current_word = GetCurrentWord()
  call ReplaceWord(l:current_word)
endfunction

function! ReplaceCurrentWORD() abort
  let l:current_word = GetCurrentWORD()
  call ReplaceWord(l:current_word)
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
"}}}

" Commands "{{{
command! ToggleAutoChangeDirectory  :call ToggleOption('autochdir')
command! ToggleWhiteSpaceVisibility :call ToggleOption('list')
command! ToggleRelativeLineNumbers  :call ToggleOption('relativenumber')
"}}}

" Autocommand groups "{{{
augroup vim_filetype_commands
  autocmd!
  autocmd FileType vim
        \ nnoremap <buffer> <localleader>hw <cmd>call LookupCurrentWordInHelp()<cr>

  autocmd FileType vim
        \ nnoremap <buffer> <localleader>hW <cmd>call LookupCurrentWORDInHelp()<cr>

  autocmd FileType vim
        \ command! LookupCurrentWordInHelp :call LookupCurrentWordInHelp()

  autocmd FileType vim
        \ command! LookupCurrentWORDInHelp :call LookupCurrentWORDInHelp()
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
Plug 'folke/lua-dev.nvim'

Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

Plug 'scrooloose/nerdcommenter'

Plug 'honza/vim-snippets'

Plug 'tpope/vim-fugitive'
Plug 'lewis6991/gitsigns.nvim'

Plug 'jpalardy/vim-slime'

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

Plug 'elixir-editors/vim-elixir'
Plug 'mhinz/vim-mix-format'

Plug 'andyl/vim-textobj-elixir'
Plug 'rhysd/vim-textobj-ruby'

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
      \  'coc-elixir',
      \  'coc-html',
      \  'coc-json',
      \  'coc-markdown-preview-enhanced',
      \  'coc-markdownlint',
      \  'coc-prettier',
      \  'coc-snippets',
      \  'coc-solargraph',
      \  'coc-spell-checker',
      \  'coc-sumneko-lua',
      \  'coc-vimlsp',
      \  'coc-webview',
      \  'coc-yank']

" autocmd CursorHold * silent call CocActionAsync('definitionHover')

inoremap <silent><expr> <c-space> coc#refresh()

if g:has_terminal
  inoremap <silent><expr> <nul> coc#refresh()
endif

"inoremap <silent><expr> <esc> pumvisible() ? coc#float#close_all(1) : "\<esc>"

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

" Plugins - vim-slime "{{{
let g:slime_target = "tmux"
let g:slime_no_mappings = 1
"}}}

" Plugins - EasyMotion "{{{
if g:use_easymotion
  " Default - asdghklqwertyuiopzxcvbnmfj;
  let g:EasyMotion_keys             = 'ARSTGQWFPMIOLUYNE;'
  let g:EasyMotion_do_mapping       = 0
  let g:EasyMotion_smartcase        = 1
  let g:EasyMotion_use_smartsign_us = 1
  let g:EasyMotion_use_upper        = 1
  let g:EasyMotion_enter_jump_first = 1
  let g:EasyMotion_space_jump_first = 1
  let g:EasyMotion_inc_highlight    = 1
  let g:EasyMotion_move_highlight   = 1
  let g:EasyMotion_verbose          = 1

  if g:host_theme_is_dracula
    hi link EasyMotionTarget DraculaOrange
    hi link EasyMotionTarget2First DraculaGreen
    hi link EasyMotionTarget2Second DraculaGreen
  elseif g:host_theme_is_tender
    hi link EasyMotionTarget Operator
    hi link EasyMotionTarget2First Character
    hi link EasyMotionTarget2Second Character
  else
    hi link EasyMotionTarget Type
    hi link EasyMotionTarget2First Title
    hi link EasyMotionTarget2Second Title
  endif

  hi link EasyMotionShade  Comment

  hi link EasyMotionMoveHL Search
  hi link EasyMotionIncSearch Search

  nnoremap ,, ,

  map ,f <plug>(easymotion-bd-fl)
  map ,F <plug>(easymotion-bd-f)
  map ,t <plug>(easymotion-bd-tl)
  map ,T <plug>(easymotion-bd-t)

  map ,ke <plug>(easymotion-iskeyword-bd-e)
  map ,kw <plug>(easymotion-iskeyword-bd-w)

  map ,s/ <plug>(easymotion-sn)
  map ,sa <plug>(easymotion-lineanywhere)
  map ,sA <plug>(easymotion-jumptoanywhere)
  map ,se <plug>(easymotion-bd-el)
  map ,sE <plug>(easymotion-bd-e)
  map ,sf <plug>(easymotion-bd-f2)
  map ,st <plug>(easymotion-bd-t2)
  map ,sw <plug>(easymotion-bd-wl)
  map ,sW <plug>(easymotion-bd-w)
  map ,sn <plug>(easymotion-next)
  map ,sN <plug>(easymotion-prev)
  map ,ss <plug>(easymotion-s2)
  map ,sS <plug>(easymotion-s)

  map ,s<up>    <plug>(easymotion-k)
  map ,s<down>  <plug>(easymotion-j)
  map ,s<left>  <plug>(easymotion-lineforward)
  map ,s<right> <plug>(easymotion-linebackward)

  map ,Sf <plug>(easymotion-overwin-f)
  map ,SF <plug>(easymotion-overwin-f2)
  map ,Sl <plug>(easymotion-overwin-line)
  map ,Sw <plug>(easymotion-overwin-w)
endif
"}}}

" Plugins - Gundo "{{{
let g:gundo_preview_bottom   = 1
let g:gundo_right            = 1
let g:gundo_help             = 0
let g:gundo_map_move_older   = 'n'
let g:gundo_map_move_newer   = 'e'
let g:gundo_return_on_revert = 1
let g:gundo_prefer_python3   = 1
"}}}

" Bindings - Command Line mode "{{{
cnoremap <c-bs> <c-w>
cnoremap      <c-w>
"}}}

" Bindings - Insert mode "{{{
inoremap <c-bs> <c-w>
inoremap      <c-w>
inoremap jj     <esc>

imap <c-c> <plug>NERDCommenterInsert
"}}}

" Bindings - Visual mode "{{{
xmap <leader>xa <plug>(EasyAlign)
"}}}

" Bindings - Normal mode - Remaps "{{{
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

" Bindings - Normal mode - Search "{{{
nnoremap <leader>// :%s/
nnoremap <leader>/h <cmd>Telescope search_history<cr>
nnoremap <leader>/i <cmd>noincsearch<cr>
nnoremap <leader>/r <cmd>call ReplaceCurrentWord()<cr>
nnoremap <leader>/R <cmd>call ReplaceCurrentWORD()<cr>
nnoremap <leader>/s :s/
nnoremap <leader>/t <cmd>nohlsearch<cr>
"}}}

" Bindings - Normal mode - Commands "{{{
nnoremap <leader>; <cmd>Telescope commands<cr>
nnoremap <leader>: <cmd>Telescope command_history<cr>
"}}}

" Bindings - Normal mode - Leader key + d "{{{
nnoremap <leader>dh <cmd>call CocActionAsync('definitionHover')<cr>
nnoremap <leader>ds <cmd>call CocActionAsync('showSignatureHelp')<cr>
"}}}

" Bindings - Normal mode - Leader key + e "{{{
nmap     <leader>ed <plug>(coc-diagnostic-info)
nnoremap <leader>ee <cmd>Telescope coc diagnostics<cr>
nnoremap <leader>eE <cmd>Telescope coc workspace_diagnostics<cr>
nmap     <leader>en <plug>(coc-diagnostic-next-error)
nmap     <leader>eN <plug>(coc-diagnostic-next)
nmap     <leader>ep <plug>(coc-diagnostic-prev-error)
nmap     <leader>eP <plug>(coc-diagnostic-prev)
nnoremap <leader>er <cmd>call CocActionAsync('diagnosticRefresh')<cr>
"}}}

" Bindings - Normal mode - Leader key + f "{{{
nnoremap <leader>ff <cmd>Telescope current_buffer_fuzzy_find<cr>
nnoremap <leader>fo <cmd>CocList outline<cr>
nnoremap <leader>fs <cmd>Telescope coc document_symbols<cr>
nnoremap <leader>ft <cmd>Telescope treesitter<cr>
"}}}

" Bindings - Normal mode - Leader key + g "{{{
nnoremap <leader>gb <cmd>Telescope git_branches<cr>
nnoremap <leader>gc <cmd>Telescope git_bcommits<cr>
nnoremap <leader>gC <cmd>Telescope git_commits<cr>
nnoremap <leader>gf <cmd>Telescope git_files<cr>
nnoremap <leader>gs <cmd>Telescope git_status<cr>
"}}}

" Bindings - Normal mode - Leader key + h "{{{
nnoremap <leader>h <cmd>Telescope help_tags<cr>
"}}}

" Bindings - Normal mode - Leader key + l "{{{
nnoremap <leader>l <cmd>NERDTreeFind<cr>
"}}}

" Bindings - Normal mode - Leader key + i "{{{
function! g:IExSlimeBuffer(file_type, focus_on_slime_window)
  let g:slime_buffer_name = 'iex_slime.exs'

  let l:focus_on_slime_window = a:focus_on_slime_window
  let l:vim_height            = &lines
  let l:current_window_number = winnr()
  let l:slime_buffer_exists   = bufexists(g:slime_buffer_name)

  if l:slime_buffer_exists == 0
    let l:slime_buffer_number = bufadd(g:slime_buffer_name)
    call setbufvar(l:slime_buffer_number, '&filetype', a:file_type)
    call setbufvar(l:slime_buffer_number, '&bufhidden', 'hide')
    call setbufvar(l:slime_buffer_number, '&swapfile', 0)
    call setbufvar(l:slime_buffer_number, '&buflisted', 0)
    call setbufvar(l:slime_buffer_number, '&number', 0)
    call setbufvar(l:slime_buffer_number, '&relativenumber', 0)
    call setbufvar(l:slime_buffer_number, '&list', 0)
  else
    let l:focus_on_slime_window = v:true
    let l:slime_buffer_number   = bufnr(g:slime_buffer_name)
  endif

  let l:slime_window_number = bufwinnr(l:slime_buffer_number)

  if l:slime_window_number == -1
    let l:slime_window_height = l:vim_height / 4

    let l:split_command  = 'split' . '+buffer' . l:slime_buffer_number
    let l:resize_command = 'resize' . l:slime_window_height

    execute l:split_command
    execute l:resize_command

    let l:slime_window_number = bufwinnr(l:slime_buffer_number)
  endif

  let l:focus_window_number =
        \ l:focus_on_slime_window ?
        \ l:slime_window_number   :
        \ l:current_window_number

  execute l:focus_window_number . 'wincmd w'
endfunction

let g:slime_default_config = {"socket_name": get(split($TMUX, ","), 0), "target_pane": ":0.{last}"}

xmap <leader>ii <Plug>SlimeRegionSend
nmap <leader>ii <Plug>SlimeParagraphSend
nmap <leader>iv <Plug>SlimeConfig
"}}}

" Bindings - Normal mode - Leader key + n "{{{
nnoremap <leader>nd <cmd>Telescope coc definitions<cr>
nnoremap <leader>ni <cmd>Telescope coc implementations<cr>
nnoremap <leader>nu <cmd>Telescope coc references<cr>
"}}}

" Bindings - Normal mode - Leader key + p "{{{
map <leader>pn <plug>(miniyank-cycle)
map <leader>pN <plug>(miniyank-cycleback)
map <leader>pp <plug>(miniyank-startput)
map <leader>pP <plug>(miniyank-startPut)
"}}}

" Bindings - Normal mode - Leader key + r "{{{
nnoremap <leader>ra <cmd>Telescope coc line_code_actions<cr>
nnoremap <leader>rA <cmd>Telescope coc file_code_actions<cr>
nmap     <leader>rf <plug>(coc-format)
nmap     <leader>rn <plug>(coc-rename)
nmap     <leader>rr <plug>(coc-refactor)
"}}}

" Bindings - Normal mode - Leader key + t "{{{
nnoremap <leader>td <cmd>bdelete<cr>
nnoremap <leader>tt <cmd>Telescope buffers<cr>
nnoremap <Leader>T :lua require'telescope.builtin'.resume()<cr>
"}}}

" Bindings - Normal mode - Leader key + s "{{{
nnoremap <leader>sf <cmd>Telescope find_files<cr>
nnoremap <leader>sg <cmd>Telescope live_grep<cr>
nnoremap <leader>sl <cmd>Telescope loclist<cr>
nnoremap <leader>sm <cmd>Telescope marks<cr>
nnoremap <leader>sp <cmd>Telescope jumplist<cr>
nnoremap <leader>sr <cmd>Telescope oldfiles<cr>
nnoremap <leader>ss :lua require'telescope'.extensions.coc.workspace_symbols({file_ignore_patterns = {'.asdf/', 'deps/'}})<cr>
nnoremap <leader>sS <cmd>Telescope coc workspace_symbols<cr>
nnoremap <leader>sw <cmd>Telescope grep_string<cr>
"}}}

" Bindings - Normal mode - Leader key + u "{{{
nnoremap <leader>u <cmd>GundoToggle<cr>
"}}}

" Bindings - Normal mode - Leader key + v "{{{
nnoremap <leader>vv <c-v>
"}}}

" Bindings - Normal mode - Leader key + w "{{{
nnoremap <leader>wc <cmd>close<cr>
nnoremap <leader>wh <cmd>only<cr>
nnoremap <leader>wi <c-w>k
nnoremap <leader>wI <c-w>K
nnoremap <leader>we <c-w>j
nnoremap <leader>wE <c-w>J
nnoremap <leader>wn <c-w>h
nnoremap <leader>wN <c-w>H
nnoremap <leader>wo <c-w>l
nnoremap <leader>wO <c-w>L
"}}}

" Bindings - Normal mode - Leader key + x "{{{
nmap     <leader>xa <plug>(EasyAlign)
nnoremap <leader>xm <c-a>
nnoremap <leader>xM <c-x>
"}}}

" Bindings - Normal mode - Leader key + z "{{{
nnoremap <leader>ze <cmd>edit $MYVIMRC<cr>
nnoremap <leader>zz <cmd>source $MYVIMRC<cr>
"}}}

" Bindings - Normal mode - Control modifier "{{{
nnoremap <c-k> <c-w>k
nnoremap <c-j> <c-w>j
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l
"}}}

" Bindings - Normal mode - Arrow keys "{{{
if g:use_arrow_keys_to_navigate_windows
  nnoremap <up>    <c-w>k
  nnoremap <down>  <c-w>j
  nnoremap <left>  <c-w>h
  nnoremap <right> <c-w>l
endif
"}}}

" Lua "{{{
if g:is_nvim
  lua require('profile')
endif
"}}}

" Auto-source local vim profile "{{{
if filereadable(expand('~/.vimrc.local'))
  source ~/.vimrc.local
endif
"}}}

" vim: foldmethod=marker foldlevel=0

