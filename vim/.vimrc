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
Plug 'tpope/vim-surround'       " Matching surround pairs
Plug 'airblade/vim-gitgutter'   " Git integration
Plug 'tpope/vim-fugitive'
Plug 'itchyny/lightline.vim'    " Status line
Plug 'tomtom/tcomment_vim'      " Easy comments
Plug 'crusoexia/vim-monokai'    " Colors
Plug 'sjl/badwolf'
Plug 'morhetz/gruvbox'
Plug 'moll/vim-node'            " Open files via ESM
Plug 'w0rp/ale'                 " Async linting
call plug#end()

let g:EditorConfig_exclude_patterns = ['fugitive://.*']

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
highlight Visual ctermbg=4

if has("autocmd")
  " remove trailing white spaces
  autocmd BufWritePre * %s/\s\+$//e

  " Extend my own custom format options.
  autocmd BufRead *.scss setlocal formatoptions=croql
  autocmd BufRead * setlocal formatoptions+=awj
endif

if executable('rg')
  set grepprg=rg\ --smart-case\ --vimgrep\ --no-heading
  set grepformat=%f:%l:%c:%m,%f:%l:%m
  function! MySearch()
    let grep_term = input("Enter search term: ")
    if !empty(grep_term)
      execute 'silent grep!' grep_term | copen
    else
      echo "Empty search term"
    endif
    redraw!
  endfunction
  command! Search call MySearch()
  nnoremap \ :Search<CR>
  nnoremap K "ayiw :Search<CR><C-r>a<CR>
  vnoremap K "ay :Search<CR>'<C-r>a'<CR>
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
nmap <leader><C-p> :FZF<space>../
nmap <leader>w <C-w>

" Remappings
nnoremap <C-p> :FZF<cr>
nnoremap <C-t> :Buffers<cr>
nnoremap <C-n> :call ToggleNumber()<cr>

" Navigate split windows easily
nnoremap <C-l> <C-w><C-l>
nnoremap <C-h> <C-w><C-h>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-j> <C-w><C-j>

set autoindent
set autoread                        " display file changes immediately
set backspace=indent,eol,start      " allow backspacing over everything
set clipboard=unnamed
set colorcolumn=80
set conceallevel=0
set copyindent
set cursorline                      " highlight cursor line
set diffopt=vertical                " gdiff in vertical splits
set encoding=utf-8
set expandtab
set hidden                          " Allow dirty buffers
set history=500
set ignorecase
set incsearch
set laststatus=2                    " always show status line
set lazyredraw                      " disable redraw during actions
set list
set listchars=tab:»·,trail:·,nbsp:·
set mouse=a                         " Enable mouse support
set nocompatible
set nohlsearch
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
