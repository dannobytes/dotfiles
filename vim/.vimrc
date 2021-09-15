" --------------------
" Plugins
" --------------------
call plug#begin('~/.vim/plugged')
Plug 'airblade/vim-gitgutter'     " Git gutter integration
Plug 'ap/vim-css-color'           " CSS color previews
Plug 'crusoexia/vim-monokai'      " Colors
Plug 'dense-analysis/ale'         " Async linting
Plug 'editorconfig/editorconfig-vim'
Plug 'vim-airline/vim-airline'        " Status line
Plug 'vim-airline/vim-airline-themes' " Status line themes
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'moll/vim-node'              " Open files via ESM
Plug 'neoclide/coc.nvim', {'branch': 'release'}   " LSP client
Plug 'sheerun/vim-polyglot'       " Syntax highlighting for many languages
Plug 'sjl/badwolf'
Plug 'skwp/vim-html-escape'       " HTML entity escaping
Plug 'tomtom/tcomment_vim'        " Easy comments
Plug 'tpope/vim-fugitive'         " Git integration
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-rhubarb'          " Enables :GBrowse
Plug 'tpope/vim-surround'         " Matching surround pairs
call plug#end()

colorscheme monokai
filetype plugin indent on
syntax on

" --------------------
" Configure airline status/tabline
" --------------------
let g:airline_theme = 'bubblegum'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#show_splits = 0
let g:airline#extensions#tabline#show_tab_type = 0
let g:airline#extensions#tabline#tab_min_count = 2

" --------------------
" Configure editorconfig plugin to work well with fugitive.
" --------------------
let g:EditorConfig_exclude_patterns = ['fugitive://.*']

" --------------------
" Configure fzf.vim
" --------------------
let g:fzf_preview_window = ['right:60%', 'ctrl-/']

" --------------------
" Configure git gutter settings
" --------------------
let g:gitgutter_diff_relative_to = 'index'

" --------------------
" Configure ale async linting
" --------------------
let g:ale_fix_on_save = 1
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['remove_trailing_lines', 'trim_whitespace', 'eslint'],
\   'scss': ['remove_trailing_lines', 'trim_whitespace', 'stylelint'],
\}
let g:ale_linters_ignore = {
\   'json': ['eslint']
\}

" --------------------
" Configure netrw directory view
" --------------------
let g:netrw_liststyle = 0
let g:netrw_keepdir = 1

" --------------------
" Status line configuration
" --------------------
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filepath', 'modified' ] ],
      \   'right': [ [ 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'fileencoding', 'filetype' ] ]
      \ },
      \ 'inactive': {
      \   'left': [ [ 'filepath' ] ]
      \ },
      \ 'component': {
      \   'filepath': '%f'
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head'
      \ },
      \ }

" --------------------
" Custom color configurations
" --------------------
highlight Visual ctermbg=darkblue
highlight Search ctermbg=78
highlight GitGutterDelete guifg=#ff5f87 ctermfg=204

if has("autocmd")
  augroup editing
    " remove trailing white spaces
    autocmd!
    autocmd BufWritePre * %s/\s\+$//e
  augroup END

  " Apply file types to extensions not recognized.
  augroup fileTypes
    autocmd!
    autocmd BufRead,BufNewFile *.hamlc set filetype=haml
    autocmd BufRead,BufNewFile *.pug set filetype=pug
    autocmd BufRead,BufNewFile *.json set filetype=json
    autocmd BufRead,BufNewFile *.coffee set filetype=coffee
  augroup END

  " Extend my own custom format options to specific file types.
  augroup formatOptions
    autocmd!
    autocmd BufEnter *.scss setlocal formatoptions=roql
    autocmd BufEnter *.md setlocal formatoptions-=t
    autocmd BufEnter * setlocal formatoptions+=wj
    autocmd BufEnter * setlocal formatoptions-=c
    autocmd FileType gitcommit setlocal formatoptions-=t
  augroup END

  " Make `gf` work within files that have trouble with it.
  augroup gotoFile
    autocmd!
    autocmd BufEnter *.scss setlocal includeexpr=substitute(v:fname,'^\\~*','node_modules/','')
  augroup END
endif

" Toggle between relative number and line number
function! ToggleNumber()
  if(!&relativenumber && !&number)
    set number
  elseif(!&relativenumber)
    set relativenumber
  else
    set norelativenumber
  endif
endfunc

" Type `\` to initiate an rg search across all files in a quickfix window
if executable('rg')
  set grepprg=rg\ --smart-case\ --vimgrep\ --no-heading
  set grepformat=%f:%l:%c:%m,%f:%l:%m
  function! MySearch()
    let grep_term = input("Enter search term: ")
    if !empty(grep_term)
      execute 'silent grep!' grep_term | copen 10
    else
      echo "Empty search term"
    endif
    redraw!
  endfunction
  command! Search call MySearch()
  nnoremap \ :Search<CR>
  nnoremap \\ "ayiw :Search<CR><C-r>a<CR>
  vnoremap \\ "ay :Search<CR>'<C-r>a'<CR>
endif

" Map the leader key to spacebar instead of `\`
let mapleader = "\<Space>"

" Shortcuts to skip to next/previous ALE errors
nnoremap [e :ALEPrevious<cr>
nnoremap ]e :ALENext<cr>

" Shortucts to open vimrc and re-source it
nnoremap <leader>vrc :tabedit $MYVIMRC<cr>
nnoremap <leader>vrso :source $MYVIMRC<cr>

" Shortcuts to work with windows and buffers easier
nnoremap <leader>bb :b#<cr>
nnoremap <leader>bd :ls<cr>:bd<space>

" Turn off search highlighting
nnoremap <leader>h :noh<cr>

" Shortcuts to netrw explorer
nnoremap <leader>./ :Ex<cr>
nnoremap <leader>../ :Ex ../

" Prettify into JSON format
nnoremap <leader>jt :%!python -m json.tool<cr>
vnoremap <leader>jt :'<,'>%!python -m json.tool<cr>

" Resizing buffer splits
nnoremap <silent> + :exe "resize +5"<cr>
nnoremap <silent> _ :exe "resize -5"<cr>

" Search for whats visually selected
vnoremap // y/\V<C-R>"<CR>

" Entrypoints to open up new files or buffers via filename/keywords
nnoremap <c-p> :Files<cr>
nnoremap <c-t> :Buffers<cr>
nnoremap <c-\> :Rg<cr>

" Open up fuzzy search one directory above to fuzzy search in an adjacent path
nnoremap <leader><C-p> :FZF<space>../

" Toggle relative line numbers
nnoremap <c-n> :call ToggleNumber()<cr>

" Count number of matches for the word under the cursor
nnoremap ,* *<c-o>:%s///gn<cr>

" Navigate split windows easily
nnoremap <c-l> <c-w><c-l>
nnoremap <c-h> <c-w><c-h>
nnoremap <c-k> <c-w><c-k>
nnoremap <c-j> <c-w><c-j>

" --------------------
" Settable options
" --------------------
set autoindent
set autoread                        " display file changes immediately
set autowrite
set autowriteall
set backspace=indent,eol,start      " allow backspacing over everything
set clipboard=unnamed
set colorcolumn=80
set conceallevel=0
set copyindent
set diffopt=vertical                " gdiff in vertical splits
set encoding=utf-8
set expandtab
set formatoptions+=wj
set hidden                          " Allow dirty buffers
set history=500
set hlsearch
set ignorecase
set incsearch
set isfname+=@-@                    " Always include `@` char in file names
set laststatus=2                    " Always show status line
set lazyredraw                      " Disable redraw during actions
set list
set listchars=tab:»·,trail:·,nbsp:·
set mouse=a                         " Enable mouse support
set nocompatible
set nocursorline                    " highlight cursor line
set noshowmode
set noswapfile
set number
set relativenumber                  " start with relative line numbers
set shiftround
set shiftwidth=2
set showcmd                         " show the current command
set smartcase
set splitbelow                      " put new split window below current
set splitright                      " put new split window to the right
set tabstop=2
set textwidth=80
set title                           " set the title to the value of 'titlestring'
set ttyfast                         " more characters sent to the screen to for smoother redraws

" Create undodir to hold persistent undo files if it doesn't exist.
if !isdirectory($HOME."/.vim/undodir")
  call mkdir($HOME."/.vim/undodir", "", 0700)
endif
set undodir=~/.vim/undodir          " Configure where undo files are stored
set undofile                        " Persistent undo, even after closing vim

set updatetime=100
set visualbell                      " Set visual bell instad of a 'BEEP'
set wrap                            " wrap line when lines are longer than the window width
