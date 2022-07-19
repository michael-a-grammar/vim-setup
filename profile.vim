let g:host_theme_is_dracula = v:true
let g:host_theme_is_tender  = v:false
let g:host_theme = 'tender'

let g:use_lsp        = v:false
let g:use_coc        = v:false
let g:use_easymotion = v:true

lua require('init')

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

function! GetCurrentTabPageNumber() abort
  return tabpagenr()
endfunction

function! GetCurrentWindowNumber() abort
  return winnr()
endfunction

function! SelectWindow(window_number) abort
  execute a:window_number . 'wincmd w'
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

"}}}
"

" Plugins - Tender "{{{
if g:host_theme_is_tender
  let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
endif
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

  inoremap <silent><expr> <c-space> coc#refresh()

  inoremap <silent><expr> <nul> coc#refresh()

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

" Plugins - EasyMotion "{{{
"if g:use_easymotion
  "" Default - asdghklqwertyuiopzxcvbnmfj;
  "let g:EasyMotion_keys             = 'ARSTGQWFPMIOLUYNE;'
  "let g:EasyMotion_do_mapping       = 0
  "let g:EasyMotion_smartcase        = 1
  "let g:EasyMotion_use_smartsign_us = 1
  "let g:EasyMotion_use_upper        = 1
  "let g:EasyMotion_enter_jump_first = 1
  "let g:EasyMotion_space_jump_first = 1
  "let g:EasyMotion_inc_highlight    = 1
  "let g:EasyMotion_move_highlight   = 1
  "let g:EasyMotion_verbose          = 1

  "if g:host_theme_is_dracula
    "hi link EasyMotionTarget DraculaOrange
    "hi link EasyMotionTarget2First DraculaGreen
    "hi link EasyMotionTarget2Second DraculaGreen
  "elseif g:host_theme_is_tender
    "hi link EasyMotionTarget Operator
    "hi link EasyMotionTarget2First Character
    "hi link EasyMotionTarget2Second Character
  "else
    "hi link EasyMotionTarget Type
    "hi link EasyMotionTarget2First Title
    "hi link EasyMotionTarget2Second Title
  "endif

  "hi link EasyMotionShade Comment

  "hi link EasyMotionMoveHL Search
  "hi link EasyMotionIncSearch Search

  "nnoremap ,, ,

  "noremap ,F <plug>(easymotion-bd-f)
  "noremap ,SF <plug>(easymotion-overwin-f2)
  "noremap ,Sf <plug>(easymotion-overwin-f)
  "noremap ,Sl <plug>(easymotion-overwin-line)
  "noremap ,Sw <plug>(easymotion-overwin-w)
  "noremap ,T <plug>(easymotion-bd-t)

  "noremap ,f  <plug>(easymotion-bd-fl
  "noremap ,ke <plug>(easymotion-iskeyword-bd-e)
  "noremap ,kw <plug>(easymotion-iskeyword-bd-w)

  "noremap ,s/ <plug>(easymotion-sn)

  "noremap ,s<down>  <plug>(easymotion-j)
  "noremap ,s<left>  <plug>(easymotion-lineforward)
  "noremap ,s<right> <plug>(easymotion-linebackward)
  "noremap ,s<up>    <plug>(easymotion-k)

  "noremap ,sA <plug>(easymotion-jumptoanywhere)
  "noremap ,sE <plug>(easymotion-bd-e)
  "noremap ,sN <plug>(easymotion-prev)
  "noremap ,sS <plug>(easymotion-s)
  "noremap ,sW <plug>(easymotion-bd-w)

  "noremap ,sa <plug>(easymotion-lineanywhere)
  "noremap ,se <plug>(easymotion-bd-el)
  "noremap ,sf <plug>(easymotion-bd-f2)
  "noremap ,sn <plug>(easymotion-next)
  "noremap ,ss <plug>(easymotion-s2)
  "noremap ,st <plug>(easymotion-bd-t2)
  "noremap ,sw <plug>(easymotion-bd-wl)
  "noremap ,t <plug>(easymotion-bd-tl)
"endif
"}}}

" Plugins - Gundo "{{{
"let g:gundo_preview_bottom   = 1
"let g:gundo_right            = 1
"let g:gundo_help             = 0
"let g:gundo_map_move_older   = 'p'
"let g:gundo_map_move_newer   = 'f'
"let g:gundo_return_on_revert = 1
"let g:gundo_prefer_python3   = 1
"}}}

" Bindings - Command line mode "{{{
"cnoremap         <c-w>
"cnoremap <m-left>  <c-left>
"cnoremap <m-right> <c-right>
"}}}

" Bindings - Insert mode "{{{
"inoremap  <c-w>
"inoremap jj <esc>

inoremap <c-c> <plug>NERDCommenterInsert
"}}}

" Bindings - Mixed modes - Remaps "{{{
"if g:override_vbol_veol_mappings
  "noremap $ g$
  "noremap 0 g0
  "noremap ^ g^

"noremap H g^
"noremap L g$

"noremap N Nzzzv
"noremap n nzzzv
"}}}

" Bindings - Normal mode - Arrow keys - Navigate within buffer "{{{
"noremap <m-left>  <c-u>
"noremap <m-right> <c-d>
"}}}

" Bindings - Normal mode - Symbols - Move text "{{{
"nnoremap - ddp
"nnoremap _ dd<up>P
"}}}

" Bindings - Normal mode - Alphanumeric - Goto "{{{
"nnoremap gD <cmd>lua vim.lsp.buf.declaration()<cr>
"nnoremap gd <cmd>lua vim.lsp.buf.definition()<cr>
"nnoremap gi <cmd>lua vim.lsp.buf.implementation()<cr>
"nnoremap gr <cmd>lua vim.lsp.buf.references()<cr>
"nnoremap gt <cmd>lua vim.lsp.buf.type_definition()<cr>
"}}}

" Bindings - Normal mode - Leader key + / - Search "{{{
"nnoremap <leader>// :%s/
"nnoremap <leader>/R <cmd>call ReplaceCurrentWORD()<cr>
"nnoremap <leader>/h <cmd>Telescope search_history<cr>
"nnoremap <leader>/i <cmd>noincsearch<cr>
"nnoremap <leader>/r <cmd>call ReplaceCurrentWord()<cr>
"nnoremap <leader>/s :s/
"nnoremap <leader>/t <cmd>nohlsearch<cr>
"}}}

" Bindings - Normal mode - Leader key + : - Commands "{{{
"nnoremap <leader>: <cmd>Telescope command_history<cr>
"nnoremap <leader>; <cmd>Telescope commands<cr>
"}}}

" Bindings - Normal mode - Leader key + a "{{{
nnoremap <leader>aa <cmd>verbose pwd<cr>
nnoremap <leader>aG <cmd>call SetGlobalWorkingDirectoryToPreviousGlobalWorkingDirectory()<cr>
nnoremap <leader>ag <cmd>call SetGlobalWorkingDirectoryToCurrentlyEditedFileDirectory()<cr>
nnoremap <leader>aT <cmd>call SetTabWorkingDirectoryToPreviousTabWorkingDirectory()<cr>
nnoremap <leader>at <cmd>call SetTabWorkingDirectoryToCurrentlyEditedFileDirectory()<cr>
nnoremap <leader>aW <cmd>call SetLocalWorkingDirectoryToPreviousTabWorkingDirectory()<cr>
nnoremap <leader>aw <cmd>call SetLocalWorkingDirectoryToCurrentlyEditedFileDirectory()<cr>
"}}}

" Bindings - Normal mode - Leader key + b "{{{
"}}}

" Bindings - Normal mode - Leader key + c - Comments "{{{
"}}}

" Bindings - Normal mode - Leader key + d - Definitions "{{{
if g:use_coc
  nnoremap <leader>dh <cmd>call CocActionAsync('definitionHover')<cr>
  nnoremap <leader>ds <cmd>call CocActionAsync('showSignatureHelp')<cr>
endif

if g:use_lsp
  nnoremap <leader>dh <cmd>lua vim.lsp.buf.hover()<cr>
  nnoremap <leader>ds <cmd>lua vim.lsp.buf.signature_help()<cr>
endif
"}}}

" Bindings - Normal mode - Leader key + e - Diagnostics "{{{
if g:use_coc
  nnoremap <leader>eE <cmd>Telescope coc workspace_diagnostics<cr>
  nnoremap <leader>eN <plug>(coc-diagnostic-next)
  nnoremap <leader>eP <plug>(coc-diagnostic-prev)
  nnoremap <leader>ed <plug>(coc-diagnostic-info)
  nnoremap <leader>ee <cmd>Telescope coc diagnostics<cr>
  nnoremap <leader>en <plug>(coc-diagnostic-next-error)
  nnoremap <leader>ep <plug>(coc-diagnostic-prev-error)
  nnoremap <leader>er <cmd>call CocActionAsync('diagnosticRefresh')<cr>
endif

if g:use_lsp
  nnoremap <leader>ec <cmd>lua vim.diagnostic.setloclist()<cr>
  nnoremap <leader>ee <cmd>Telescope diagnostics<cr>
  nnoremap <leader>ei <cmd>lua vim.diagnostic.open_float()<cr>
  nnoremap <leader>en <cmd>lua vim.diagnostic.goto_next()<cr>
  nnoremap <leader>ep <cmd>lua vim.diagnostic.goto_prev()<cr>
endif
"}}}

" Bindings - Normal mode - Leader key + F "{{{
nnoremap <leader>F <c-i>
"}}}

" Bindings - Normal mode - Leader key + f - Find within file "{{{
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

" Bindings - Normal mode - Leader key + g - Version control "{{{
"nnoremap <leader>gC <cmd>Telescope git_commits<cr>
"nnoremap <leader>gb <cmd>Telescope git_branches<cr>
"nnoremap <leader>gc <cmd>Telescope git_bcommits<cr>
"nnoremap <leader>gf <cmd>Telescope git_files<cr>
"nnoremap <leader>gs <cmd>Telescope git_status<cr>
"}}}

" Bindings - Normal mode - Leader key + h - Help "{{{
nnoremap <leader>h <cmd>Telescope help_tags<cr>
"}}}

" Bindings - Normal mode - Leader key + j "{{{
"}}}

" Bindings - Normal mode - Leader key + k "{{{
"}}}

" Bindings - Normal mode - Leader key + L "{{{
nnoremap <leader>L <cmd>NERDTreeClose<cr>
"}}}

" Bindings - Normal mode - Leader key + l - Explorer "{{{
nnoremap <leader>l <cmd>NERDTreeFind<cr>
"}}}

" Bindings - Normal mode - Leader key + m "{{{
"}}}

" Bindings - Normal mode - Leader key + n - Navigate "{{{
if g:use_coc
  nnoremap <leader>nd <cmd>Telescope coc definitions<cr>
  nnoremap <leader>ni <cmd>Telescope coc implementations<cr>
  nnoremap <leader>nu <cmd>Telescope coc references<cr>
endif

if g:use_lsp
  nnoremap <leader>nd <cmd>Telescope lsp_definitions<cr>
  nnoremap <leader>ni <cmd>Telescope lsp_implementations<cr>
  nnoremap <leader>nt <cmd>Telescope lsp_type_definitions<cr>
  nnoremap <leader>nu <cmd>Telescope lsp_references<cr>
endif
"}}}

" Bindings - Normal mode - Leader key + o "{{{
"}}}

" Bindings - Normal mode - Leader key + P "{{{
nnoremap <leader>P <c-o>
"}}}

" Bindings - Normal mode - Leader key + p - Paste "{{{
nnoremap <leader>pN <plug>(miniyank-cycleback)
nnoremap <leader>pP <plug>(miniyank-startPut)
nnoremap <leader>pn <plug>(miniyank-cycle)
nnoremap <leader>pp <plug>(miniyank-startput)
"}}}

" Bindings - Normal mode - Leader key + q "{{{
"}}}

" Bindings - Normal mode - Leader key + r - Refactor "{{{
if g:use_coc
  nnoremap <leader>rA <cmd>Telescope coc file_code_actions<cr>
  nnoremap <leader>ra <cmd>Telescope coc line_code_actions<cr>
  nnoremap <leader>rf <plug>(coc-format)
  nnoremap <leader>rn <plug>(coc-rename)
  nnoremap <leader>rr <plug>(coc-refactor)
endif

if g:use_lsp
  nnoremap <leader>ra <cmd>lua vim.lsp.buf.code_action()<cr>
  nnoremap <leader>rf <cmd>lua vim.lsp.buf.format()<cr>
  nnoremap <leader>rn <cmd>lua vim.lsp.buf.rename()<cr>
  nnoremap <leader>rr <cmd>lua vim.lsp.codelens.run()<cr>
endif
"}}}

" Bindings - Normal mode - Leader key + s - Find within working directory "{{{
if g:use_coc
  nnoremap <leader>sS <cmd>Telescope coc workspace_symbols<cr>
endif

if g:use_lsp
  nnoremap <leader>sS <cmd>Telescope lsp_dynamic_workspace_symbols<cr>
end

nnoremap <leader>sC <cmd>Telescope quickfixhistory<cr>
nnoremap <leader>sc <cmd>Telescope quickfix<cr>
nnoremap <leader>sf <cmd>Telescope find_files<cr>
nnoremap <leader>sg <cmd>Telescope live_grep<cr>
nnoremap <leader>sl <cmd>Telescope loclist<cr>
nnoremap <leader>sm <cmd>Telescope marks<cr>
nnoremap <leader>sp <cmd>Telescope jumplist<cr>
nnoremap <leader>sr <cmd>Telescope oldfiles<cr>

if g:use_coc
  nnoremap <leader>ss <cmd>lua require('telescope').extensions.coc.workspace_symbols({file_ignore_patterns = {'.asdf/', 'deps/'}})<cr>
endif

if g:use_lsp
  nnoremap <leader>ss <cmd>Telescope lsp_workspace_symbols<cr>
endif

nnoremap <leader>sw <cmd>Telescope grep_string<cr>
"}}}

" Bindings - Normal mode - Leader key + T "{{{
nnoremap <Leader>T <cmd>lua require('telescope.builtin').resume()<cr>
"}}}

" Bindings - Normal mode - Leader key + t - Buffers "{{{
"nnoremap <leader>tc <cmd>new<cr>
"nnoremap <leader>td <cmd>bdelete<cr>
nnoremap <leader>tt <cmd>Telescope buffers<cr>
"nnoremap <leader>tn <cmd>bnext<cr>
"nnoremap <leader>tp <cmd>bprevious<cr>
"nnoremap <leader>tw <cmd>ball<cr>
"nnoremap <leader>ty <cmd>tab ball<cr>
"}}}

" Bindings - Normal mode - Leader key + u - Find Within buffer directory "{{{
nnoremap <leader>uf <cmd>lua require('telescope.builtin').find_files({cwd = require('telescope.utils').buffer_dir()})<cr>
nnoremap <leader>ug <cmd>lua require('telescope.builtin').live_grep({cwd = require('telescope.utils').buffer_dir()})<cr>
nnoremap <leader>uw <cmd>lua require('telescope.builtin').grep_string({cwd = require('telescope.utils').buffer_dir()})<cr>
"}}}

" Bindings - Normal mode - Leader key + v - Visual "{{{
"nnoremap <leader>vv <c-v>
"}}}

" Bindings - Normal mode - Leader key + w - Windows "{{{
"nnoremap <leader>w= <c-w>=
"nnoremap <leader>wE <c-w>J
"nnoremap <leader>wI <c-w>K
"nnoremap <leader>wN <c-w>H
"nnoremap <leader>wO <c-w>L
"nnoremap <leader>wR <c-w>R
"nnoremap <leader>wS <cmd>split<cr>
"nnoremap <leader>wd <cmd>close<cr>
"nnoremap <leader>we <c-w>j
"nnoremap <leader>wh <cmd>only<cr>
"nnoremap <leader>wi <c-w>k
"nnoremap <leader>wn <c-w>h
"nnoremap <leader>wo <c-w>l
"nnoremap <leader>wr <c-w>r
"nnoremap <leader>ws <cmd>vsplit<cr>
"nnoremap <leader>wt <cmd>tab split<cr>
"}}}

" Bindings - Normal mode - Leader key + x - Text "{{{
"nnoremap <leader>xM <c-x>
"nnoremap <leader>xa <plug>(EasyAlign)
"nnoremap <leader>xm <c-a>
"nnoremap <leader>xu <cmd>GundoToggle<cr>
"xnoremap <leader>xs :sort<cr>
""}}}

"" Bindings - Visual mode - Leader key + x - Text "{{{
"xnoremap <leader>xa <plug>(EasyAlign)
"xnoremap <leader>xs :sort<cr>
"}}}

" Bindings - Normal mode - Leader key + y - Tabs "{{{
"nnoremap <leader>yc <cmd>tabnew<cr>
"nnoremap <leader>yd <cmd>tabclose<cr>
"nnoremap <leader>yf <cmd>tabfirst<cr>
"nnoremap <leader>yl <cmd>tablast<cr>
"nnoremap <leader>yn <cmd>tabnext<cr>
"nnoremap <leader>yp <cmd>tabprevious<cr>
""}}}

"" Bindings - Normal mode - Leader key + z - Vim "{{{
"nnoremap <leader>ze <cmd>edit $MYVIMRC<cr>
"nnoremap <leader>zz <cmd>source $MYVIMRC<cr>
"}}}

" Lua "{{{
"}}}

" Auto-source local vim profile "{{{
if filereadable(expand('~/.vimrc.local'))
  source ~/.vimrc.local
endif
"}}}
