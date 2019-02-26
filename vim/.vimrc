" --------------------
" Plugins
" --------------------
set rtp+=/usr/local/opt/fzf
call plug#begin('~/.vim/plugged')
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'pangloss/vim-javascript'
Plug 'kchmck/vim-coffee-script'
Plug 'airblade/vim-gitgutter'   " Git integration
Plug 'tpope/vim-surround'       " Matching surround pairs
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'itchyny/lightline.vim'    " Status line
Plug 'tomtom/tcomment_vim'      " Easy comments
Plug 'crusoexia/vim-monokai'    " Colors
Plug 'sjl/badwolf'
Plug 'morhetz/gruvbox'
Plug 'moll/vim-node'            " Open files via ESM
Plug 'w0rp/ale'                 " Async linting
Plug 'skwp/vim-html-escape'     " HTML entity escaping
Plug 'digitaltoad/vim-pug'      " Pug syntax highlighting
call plug#end()

let g:EditorConfig_exclude_patterns = ['fugitive://.*']

" Configure netrw directory view
let g:netrw_liststyle = 0
let g:netrw_keepdir = 1

" Status line configuration
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

colorscheme monokai
filetype plugin indent on
syntax on

" Custom colors
highlight Visual ctermbg=darkblue
highlight ALEError ctermbg=darkred ctermfg=white
highlight Search ctermbg=78

if has("autocmd")
  " remove trailing white spaces
  autocmd BufWritePre * %s/\s\+$//e

  " Apply file types to extensions not recognized.
  autocmd BufEnter *.hamlc set filetype=haml
  autocmd BufEnter *.pug set filetype=pug

  " Extend my own custom format options.
  autocmd BufEnter *.scss setlocal formatoptions=roql
  autocmd BufEnter * setlocal formatoptions+=wj
  autocmd BufEnter * setlocal formatoptions-=c
endif

if executable('rg')
  set grepprg=rg\ --smart-case\ --vimgrep\ --no-heading
  set grepformat=%f:%l:%c:%m,%f:%l:%m
  function! MySearch()
    let grep_term = input("Enter search term: ")
    if !empty(grep_term)
      execute 'silent grep!' grep_term | copen 15
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

let mapleader = "\<Space>"          " Map the leader to spacebar rather than \
nmap <leader>so :source $MYVIMRC<cr>
nmap <leader>vr :tabedit $MYVIMRC<cr>
nmap <leader>bb :b#<cr>
nmap <leader>bd :ls<cr>:bd<space>
nmap <leader>p :FZF<space>../
nmap <leader>w <C-w>
nmap <leader>h :noh<cr>
nmap <leader>ex :Ex<cr>
nmap <leader>..ex :Ex ../

" Resizing buffer splits
nmap <silent> + :exe "resize " . (winheight(0) * 9/8)<cr>
nmap <silent> _ :exe "resize " . (winheight(0) * 7/8)<cr>

" Search for whats visually selected
vnoremap // y/\V<C-R>"<CR>

" Remappings
nnoremap <c-p> :FZF<cr>
nnoremap <c-t> :Buffers<cr>
nnoremap <c-n> :call ToggleNumber()<cr>

" Count number of matches for the word under the cursor
nnoremap ,* *<c-o>:%s///gn<cr>

" Navigate split windows easily
nnoremap <c-l> <c-w><c-l>
nnoremap <c-h> <c-w><c-h>
nnoremap <c-k> <c-w><c-k>
nnoremap <c-j> <c-w><c-j>

set autoindent
set autoread                        " display file changes immediately
set autowrite
set autowriteall
set backspace=indent,eol,start      " allow backspacing over everything
set clipboard=unnamed
set colorcolumn=80
set conceallevel=0
set copyindent
set nocursorline                    " highlight cursor line
set diffopt=vertical                " gdiff in vertical splits
set encoding=utf-8
set expandtab
set formatoptions+=wj
set hidden                          " Allow dirty buffers
set history=500
set hlsearch
set ignorecase
set incsearch
set laststatus=2                    " always show status line
set lazyredraw                      " disable redraw during actions
set list
set listchars=tab:»·,trail:·,nbsp:·
set mouse=a                         " Enable mouse support
set nocompatible
set noshowmode
set noswapfile
set number
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
set updatetime=100
set visualbell                      " Set visual bell instad of a 'BEEP'
set wrap linebreak                  " wrap line when lines are longer than the window width
