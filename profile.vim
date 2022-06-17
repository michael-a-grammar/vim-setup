" Initialisation "{{{
let g:is_nvim      = has('nvim')
let g:is_macvim    = has('gui_macvim')
let g:has_gui      = has('gui_running') || empty($TERM)
let g:has_terminal = !g:has_gui

let g:gui_theme      = 'tender'
let g:terminal_theme = 'dracula'
let g:override_theme = ''

let g:use_lsp        = v:true
let g:use_coc        = v:false
let g:use_easymotion = v:true

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
let s:dict_type    = type({})
let s:funcref_type = type(function('tr'))
let s:lambda_type  = type({ -> v:false })

function! IsString(val) abort
  return CompareTypes(a:val, s:string_type)
endfunction

function! IsList(val) abort
  return CompareTypes(a:val, s:list_type)
endfunction

function! IsDict(val) abort
  return CompareTypes(a:val, s:dict_type)
endfunction

function! IsFuncref(val) abort
  return CompareTypes(a:val, s:funcref_type)
endfunction

function! IsLambda(val) abort
  return CompareTypes(a:val, s:lambda_type)
endfunction

function! CompareTypes(val, type_to_compare) abort
  if type(a:val) ==# a:type_to_compare
    return v:true
  else
    return v:false
  endif
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

function! GetCurrentWindowNumber() abort
  return winnr()
endfunction

function! GetCurrentBufferName() abort
  return bufname('')
endfunction

function! BufferExists(buffer_name) abort
  return bufexists(a:buffer_name)
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

function! GetCurrentlyEditedFileDirectory() abort
  return expand('%:h')
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

function! Leader(suffix)
  let l:leader = get(g:, 'mapleader', '\\')

  if l:leader == ' '
    let l:leader = '1' . l:leader
  endif

  execute 'normal ' . l:leader . a:suffix
endfunction

function! GetCurrentBasicMode() abort
  let l:current_mode = mode()

  if l:current_mode ==# 'n'
    return { 'normal': v:true }
  elseif l:current_mode ==? 'v' || l:current_mode ==# 'CTRL-V'
    return { 'visual': v:true }
  endif
endfunction

function! SetWorkingDirectoryToCurrentlyEditedFileDirectory() abort
  let l:currently_edited_file_directory = GetCurrentlyEditedFileDirectory()
  cd l:currently_edited_file_directory
endfunction
"}}}

" Commands "{{{
command! ToggleAutoChangeDirectory  :call ToggleOption('autochdir')
command! ToggleWhiteSpaceVisibility :call ToggleOption('list')
command! ToggleRelativeLineNumbers  :call ToggleOption('relativenumber')
command! -nargs=1 Leader :call Leader(<f-args>)
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
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'nvim-telescope/telescope-github.nvim'
Plug 'nvim-telescope/telescope-z.nvim'

Plug 'nvim-treesitter/nvim-treesitter'

if g:use_coc
  Plug 'fannheyward/telescope-coc.nvim'
  Plug 'neoclide/coc.nvim', { 'branch': 'release' }
endif

Plug 'kyazdani42/nvim-web-devicons'

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

let g:airline#extensions#tabline#enabled = 1

let g:airline_powerline_fonts     = 1
let g:airline_skip_empty_sections = 1
"}}}

" Plugins - Airline Themes "{{{
let g:airline_theme = g:host_theme
"}}}

" Plugins - CoC "{{{
if g:use_coc
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

  " inoremap <silent><expr> <esc> pumvisible() ? coc#float#close_all(1) : "\<esc>"

  inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<c-g>u\<cr>"

  inoremap <silent><expr> <tab>
        \ pumvisible() ?
          \ "\<c-n>" :
          \ PreviousCharacterIsEmptyOrWhitespace() ?
            \ "\<tab>" :
            \ coc#refresh()

  inoremap <expr> <s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"
endif
"}}}

" Plugins - NERDCommenter "{{{
let g:NERDCreateDefaultMappings = 1
"}}}

" Plugins - vim-slime "{{{
let g:slime_target         = "tmux"
let g:slime_no_mappings    = 1
let g:slime_default_config = {"socket_name": get(split($TMUX, ","), 0), "target_pane": ":0.{last}"}

function! GetSlimeBufferName(buffer_prefix, file_type) abort
  return a:buffer_prefix . '_slime.' . a:file_type
endfunction

function! GetSlimeState(buffer_prefix, file_type) abort
  let l:state        = {}

  let l:current_buffer_name   = GetCurrentBufferName()
  let l:current_window_number = GetCurrentWindowNumber()

  let l:slime_buffer_name   = GetSlimeBufferName(a:buffer_prefix, a:file_type)
  let l:slime_buffer_number = bufnr(l:slime_buffer_name)
  let l:slime_window_number = bufwinnr(l:slime_buffer_number)

  if l:slime_buffer_name !=# l:current_buffer_name
    if l:slime_buffer_number ==# -1
      let l:state.slime_buffer_does_not_exist = v:true
    else
      let l:state.slime_buffer_number = l:slime_buffer_number
    endif
  else
    let l:state.slime_buffer_is_selected = v:true
  endif

  if l:slime_window_number !=# l:current_window_number
    if l:slime_window_number ==# -1
      let l:state.slime_window_does_not_exist = v:true
    else
      let l:state.slime_window_exists = v:true
      let l:state.slime_window_number = l:slime_window_number
    endif
  endif

  let l:state.file_type         = a:file_type
  let l:state.slime_buffer_name = l:slime_buffer_name

  return l:state
endfunction

function! CreateSlimeWindow(state) abort
  let l:vim_height          = &lines
  let l:slime_window_height = l:vim_height / 4

  let l:split_command  = 'split' . '+buffer' . a:state.slime_buffer_number
  let l:resize_command = 'resize' . l:slime_window_height

  execute l:split_command
  execute l:resize_command
endfunction

function! SelectSlimeWindow(state) abort
  execute a:state.slime_window_number . 'wincmd w'
endfunction

function! CreateSlimeBuffer(state) abort
  let l:state               = a:state
  let l:slime_buffer_number = bufadd(l:state.slime_buffer_name)

  call setbufvar(l:slime_buffer_number, '&filetype', l:state.file_type)
  call setbufvar(l:slime_buffer_number, '&bufhidden', 'hide')
  call setbufvar(l:slime_buffer_number, '&swapfile', 0)
  call setbufvar(l:slime_buffer_number, '&buflisted', 0)
  call setbufvar(l:slime_buffer_number, '&number', 0)
  call setbufvar(l:slime_buffer_number, '&relativenumber', 0)
  call setbufvar(l:slime_buffer_number, '&list', 0)

  let l:state.slime_buffer_number = l:slime_buffer_number

  return l:state
endfunction

function! Slime(buffer_prefix, file_type) abort
  let l:state = GetSlimeState(a:buffer_prefix, a:file_type)

  if has_key(l:state, 'slime_buffer_is_selected')
    call Leader('ii')
  endif

  if has_key(l:state, 'slime_window_exists')
    call SelectSlimeWindow(l:state)
  endif

  if has_key(l:state, 'slime_buffer_does_not_exist')
    call CreateSlimeBuffer(l:state)
  endif

  if has_key(l:state, 'slime_window_does_not_exist')
    call CreateSlimeWindow(l:state)
  endif
endfunction
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

  hi link EasyMotionShade Comment

  hi link EasyMotionMoveHL Search
  hi link EasyMotionIncSearch Search

  nnoremap ,, ,

  noremap ,f <plug>(easymotion-bd-fl)
  noremap ,F <plug>(easymotion-bd-f)
  noremap ,t <plug>(easymotion-bd-tl)
  noremap ,T <plug>(easymotion-bd-t)

  noremap ,ke <plug>(easymotion-iskeyword-bd-e)
  noremap ,kw <plug>(easymotion-iskeyword-bd-w)

  noremap ,s/ <plug>(easymotion-sn)
  noremap ,sa <plug>(easymotion-lineanywhere)
  noremap ,sA <plug>(easymotion-jumptoanywhere)
  noremap ,se <plug>(easymotion-bd-el)
  noremap ,sE <plug>(easymotion-bd-e)
  noremap ,sf <plug>(easymotion-bd-f2)
  noremap ,st <plug>(easymotion-bd-t2)
  noremap ,sw <plug>(easymotion-bd-wl)
  noremap ,sW <plug>(easymotion-bd-w)
  noremap ,sn <plug>(easymotion-next)
  noremap ,sN <plug>(easymotion-prev)
  noremap ,ss <plug>(easymotion-s2)
  noremap ,sS <plug>(easymotion-s)

  noremap ,s<up>    <plug>(easymotion-k)
  noremap ,s<down>  <plug>(easymotion-j)
  noremap ,s<left>  <plug>(easymotion-lineforward)
  noremap ,s<right> <plug>(easymotion-linebackward)

  noremap ,Sf <plug>(easymotion-overwin-f)
  noremap ,SF <plug>(easymotion-overwin-f2)
  noremap ,Sl <plug>(easymotion-overwin-line)
  noremap ,Sw <plug>(easymotion-overwin-w)
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
cnoremap <m-bs> <c-w>
cnoremap      <c-w>
"}}}

" Bindings - Operator pending mode "{{{
onoremap silent fp :<c-u>normal! f(vi(<cr>
"}}}

" Bindings - Insert mode "{{{
inoremap <m-bs> <c-w>
inoremap      <c-w>
inoremap jj     <esc>

inoremap <c-c> <plug>NERDCommenterInsert
"}}}

" Bindings - Mixed modes - Remaps "{{{
if g:override_vbol_veol_mappings
  noremap $ g$
  noremap ^ g^
  noremap 0 g0
endif

noremap H g^
noremap L g$

noremap n nzzzv
noremap N Nzzzv
"}}}

" Bindings - Mixed modes - Control modifier "{{{
noremap <c-k> <c-w>k
noremap <c-j> <c-w>j
noremap <c-h> <c-w>h
noremap <c-l> <c-w>l
"}}}

" Bindings - Mixed modes - Arrow keys "{{{
if g:use_arrow_keys_to_navigate_windows
  noremap <up>    <c-w>k
  noremap <down>  <c-w>j
  noremap <left>  <c-w>h
  noremap <right> <c-w>l
endif
"}}}

" Bindings - Normal mode - Symbols "{{{
nnoremap - ddp
nnoremap _ dd<up>P
"}}}

" Bindings - Normal mode - Search "{{{
nnoremap <leader>// %s/
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
if g:use_coc
  nnoremap <leader>dh <cmd>call CocActionAsync('definitionHover')<cr>
  nnoremap <leader>ds <cmd>call CocActionAsync('showSignatureHelp')<cr>
endif
"}}}

" Bindings - Normal mode - Leader key + e "{{{
if g:use_coc
  nnoremap <leader>ed <plug>(coc-diagnostic-info)
  nnoremap <leader>ee <cmd>Telescope coc diagnostics<cr>
  nnoremap <leader>eE <cmd>Telescope coc workspace_diagnostics<cr>
  nnoremap <leader>en <plug>(coc-diagnostic-next-error)
  nnoremap <leader>eN <plug>(coc-diagnostic-next)
  nnoremap <leader>ep <plug>(coc-diagnostic-prev-error)
  nnoremap <leader>eP <plug>(coc-diagnostic-prev)
  nnoremap <leader>er <cmd>call CocActionAsync('diagnosticRefresh')<cr>
endif
"}}}

" Bindings - Normal mode - Leader key + f "{{{
nnoremap <leader>ff <cmd>Telescope current_buffer_fuzzy_find<cr>

if g:use_coc
  nnoremap <leader>fo <cmd>CocList outline<cr>
  nnoremap <leader>fs <cmd>Telescope coc document_symbols<cr>
endif

if g:use_lsp
  nnoremap <leader>fs <cmd>Telescope lsp_document_symbols<cr>
endif

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
nnoremap <leader>ii <plug>SlimeParagraphSend
nnoremap <leader>iv <plug>SlimeConfig
"}}}

" Bindings - Visual mode - Leader key + i "{{{
xnoremap <leader>ii <plug>SlimeRegionSend
"}}}

" Bindings - Normal mode - Leader key + m "{{{
nnoremap <leader>mm <cmd>call Slime('iex', 'exs')<cr>
"}}}

" Bindings - Visual mode - Leader key + m "{{{
xnoremap <leader>mm <cmd>call Slime('iex', 'exs')<cr>
"}}}

" Bindings - Normal mode - Leader key + n "{{{
if g:use_coc
  nnoremap <leader>nd <cmd>Telescope coc definitions<cr>
  nnoremap <leader>ni <cmd>Telescope coc implementations<cr>
  nnoremap <leader>nu <cmd>Telescope coc references<cr>
endif

if g:use_lsp
  nnoremap <leader>nd <cmd>Telescope lsp_definitions<cr>
  nnoremap <leader>ni <cmd>Telescope lsp_implementations<cr>
  nnoremap <leader>nu <cmd>Telescope lsp_references<cr>
endif
"}}}

" Bindings - Normal mode - Leader key + p "{{{
noremap <leader>pn <plug>(miniyank-cycle)
noremap <leader>pN <plug>(miniyank-cycleback)
noremap <leader>pp <plug>(miniyank-startput)
noremap <leader>pP <plug>(miniyank-startPut)
"}}}

" Bindings - Normal mode - Leader key + r "{{{
if g:use_coc
  nnoremap <leader>ra <cmd>Telescope coc line_code_actions<cr>
  nnoremap <leader>rA <cmd>Telescope coc file_code_actions<cr>
  nnoremap <leader>rf <plug>(coc-format)
  nnoremap <leader>rn <plug>(coc-rename)
  nnoremap <leader>rr <plug>(coc-refactor)
endif
"}}}

" Bindings - Normal mode - Leader key + t "{{{
nnoremap <leader>td <cmd>bdelete<cr>
nnoremap <leader>tt <cmd>Telescope buffers<cr>
nnoremap <Leader>T :lua require('telescope.builtin').resume()<cr>
"}}}

" Bindings - Normal mode - Leader key + s "{{{
nnoremap <leader>sf <cmd>Telescope find_files<cr>
nnoremap <leader>sg <cmd>Telescope live_grep<cr>
nnoremap <leader>sl <cmd>Telescope loclist<cr>
nnoremap <leader>sm <cmd>Telescope marks<cr>
nnoremap <leader>sp <cmd>Telescope jumplist<cr>
nnoremap <leader>sr <cmd>Telescope oldfiles<cr>

if g:use_coc
  nnoremap <leader>ss :lua require('telescope').extensions.coc.workspace_symbols({file_ignore_patterns = {'.asdf/', 'deps/'}})<cr>
  nnoremap <leader>sS <cmd>Telescope coc workspace_symbols<cr>
endif

if g:use_lsp
  nnoremap <leader>ss <cmd>Telescope lsp_workspace_symbols<cr>
  nnoremap <leader>sS <cmd>Telescope lsp_dynamic_workspace_symbols<cr>
end

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
nnoremap <leader>xa <plug>(EasyAlign)
nnoremap <leader>xm <c-a>
nnoremap <leader>xM <c-x>
"}}}

" Bindings - Visual mode - Leader key + x "{{{
xnoremap <leader>xa <plug>(EasyAlign)
"}}}

" Bindings - Normal mode - Leader key + z "{{{
nnoremap <leader>ze <cmd>edit $MYVIMRC<cr>
nnoremap <leader>zz <cmd>source $MYVIMRC<cr>
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

