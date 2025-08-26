vim.cmd[[
" Automatic installation for vim-plug
" https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" --------------------
" Plugins
" --------------------
call plug#begin('~/.vim/plugged')
Plug 'airblade/vim-gitgutter'     " Git gutter integration
Plug 'ap/vim-css-color'           " CSS color previews
Plug 'crusoexia/vim-monokai'      " Colors
Plug 'editorconfig/editorconfig-vim'
Plug 'iloginow/vim-stylus'        " Stylus syntax
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
Plug 'vim-airline/vim-airline'        " Status line
Plug 'vim-airline/vim-airline-themes' " Status line themes
Plug 'github/copilot.vim'         " GitHub Copilot
" CodeCompanion Plugins
Plug 'MeanderingProgrammer/render-markdown.nvim'
Plug 'echasnovski/mini.nvim'
Plug 'nvim-tree/nvim-web-devicons'
" CodeCompanion Insallation Instructions
" https://codecompanion.olimorris.dev/installation.html#vim-plug
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'olimorris/codecompanion.nvim'
call plug#end()

" -----------------------
" Python provider config
" -----------------------
let g:python3_host_prog = '/usr/bin/python3'

" --------------------
" CoC config
" https://github.com/neoclide/coc.nvim/wiki/Using-coc-extensions
" --------------------
let g:coc_global_extensions = [
\ 'coc-css',
\ 'coc-eslint',
\ 'coc-html',
\ 'coc-jest',
\ 'coc-json',
\ 'coc-marketplace',
\ 'coc-prettier',
\ 'coc-snippets',
\ 'coc-stylelintplus',
\ 'coc-svg',
\ 'coc-tsserver',
\ 'coc-yaml',
\ 'coc-yank',
\]

" Prevent missing cursor after :CocList
let g:coc_disable_transparent_cursor = 1

" --------------------
" Configure airline status/tabline
" --------------------
let g:airline_powerline_fonts = 1
let g:airline_section_b = airline#section#create(['hunks'])
let g:airline_section_y = airline#section#create([])
let g:airline_theme = 'molokai'
let g:airline#extensions#coc#show_coc_status = 0
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
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.9 } }
let g:fzf_preview_window = ['right:50%', 'ctrl-/']

command! -bang -nargs=? -complete=dir Files
\ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--info=inline']}), <bang>0)
command! -bang -nargs=? -complete=dir Buffers
\ call fzf#vim#buffers(<q-args>, fzf#vim#with_preview({'options': ['--info=inline']}), <bang>0)

" --------------------
" Configure git gutter settings
" --------------------
let g:gitgutter_diff_relative_to = 'index'

" --------------------
" Configure netrw directory view
" --------------------
let g:netrw_keepdir = 1
let g:netrw_liststyle = 0
let g:netrw_sort_by = "name"
let g:netrw_winsize = 30

" --------------------
" Auto commands
" --------------------
if has("autocmd")
  " Apply custom color overrides whenever color scheme changes
  function! CustomHighlights()
    highlight DiagnosticError ctermfg=210
    highlight DiagnosticWarn ctermfg=215
    highlight DiagnosticInfo ctermfg=157
    highlight DiagnosticHint ctermfg=159

    " CoC colors
    highlight CocFloating ctermfg=189 ctermbg=235
    highlight CocFloatActive ctermfg=209
    highlight CocFloatDividingLine ctermfg=245
    highlight! link CocErrorFloat DiagnosticError
    highlight! link CocWarningFloat DiagnosticWarn
    highlight! link CocInfoFloat DiagnosticInfo
    highlight! link CocHintFloat DiagnosticHint
    highlight CocErrorHighlight ctermfg=204 cterm=none
    highlight CocWarningHighlight ctermfg=209
    highlight CocInfoHighlight ctermfg=186
    highlight CocHintHighlight ctermfg=115
    highlight CocPumSearch ctermfg=208
    highlight CocNotificationProgress ctermfg=208
    highlight CocHighlightText ctermbg=58

    highlight Visual ctermbg=54 ctermfg=7
    highlight Search ctermbg=183
    highlight GitGutterDelete guifg=#ff5f87 ctermfg=204
    highlight link netrwMarkFile Search
  endfunc
  augroup customHighlights
    autocmd!
    autocmd ColorScheme * call CustomHighlights()
  augroup END

  augroup editing
    " remove trailing white spaces
    autocmd!
    autocmd BufWritePre * %s/\s\+$//e
  augroup END

  " Apply file types to extensions not recognized.
  augroup fileTypes
    autocmd!
    autocmd BufRead,BufNewFile *.coffee set filetype=coffee
    autocmd BufRead,BufNewFile *.hamlc set filetype=haml
    autocmd BufRead,BufNewFile *.md set shiftwidth=2
    autocmd BufRead,BufNewFile *.pug set filetype=pug
    autocmd BufRead,BufNewFile .eslintignore set filetype=gitignore
    autocmd BufRead,BufNewFile .stylelintignore set filetype=gitignore
  augroup END

  " Extend my own custom format options to specific file types.
  augroup formatOptions
    autocmd!
    autocmd BufEnter *.scss setlocal formatoptions=roql
    autocmd BufEnter *.md setlocal formatoptions-=t
    autocmd BufEnter * setlocal formatoptions+=wj
    autocmd BufEnter * setlocal formatoptions-=c
  augroup END

  augroup cocTweaks
    autocmd FileType css setl iskeyword+=-
    autocmd FileType scss setlocal iskeyword+=@-@
  augroup END

  " Make `gf` work within files that have trouble with it.
  augroup gotoFile
    autocmd!
    autocmd BufEnter *.scss setlocal includeexpr=substitute(v:fname,'^\\~*','node_modules/','')
  augroup END
endif

" --------------------------------------
" Use RipGrep as my default grep search.
" --------------------------------------
if executable('rg')
  set grepprg=rg\ --smart-case\ --vimgrep\ --no-heading\ --follow
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

  " Type `\` to initiate grep search across all files in a quickfix window.
  nnoremap \ :Search<CR>

  " Shortcut to grep search the word under the cursor in normal/visual mode.
  nnoremap \\ "ayiw :Search<CR><C-r>a<CR>
  vnoremap \\ "ay :Search<CR>'<C-r>a'<CR>
endif

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
set nobackup                        " CoC: Some LSPs have issues with backups.
set nowritebackup                   " CoC: Some LSPs have issues with backups.
set nocursorline                    " Prevent cursor line hight
set noshowmode
set noswapfile
set number
set relativenumber                  " start with relative line numbers
set shiftround
set shiftwidth=2
set shortmess+=c                    " CoC: No messages to |ins-completion-menu|.
set showcmd                         " show the current command
set signcolumn=auto
set smartcase
set splitbelow                      " put new split window below current
set splitright                      " put new split window to the right
set tabstop=2
set textwidth=80
set title                           " set the title to the value of 'titlestring'
set undofile                        " Persistent undo, even after closing vim
set updatetime=300
set visualbell                      " Set visual bell instad of a 'BEEP'
set wrap                            " wrap lines longer than the window width

if !has('nvim')
  " Create undodir to hold persistent undo files if it doesn't exist.
  if !isdirectory($HOME."/.vim/undodir")
    call mkdir($HOME."/.vim/undodir", "", 0700)
  endif
  set undodir=~/.vim/undodir          " Configure where undo files are stored
endif
]]

--------------------
-- General options
--------------------
vim.cmd('colorscheme monokai')
vim.cmd('syntax on')

--------------------------------
-- LUA configuration setup
--------------------------------
require('coding')
require('coding_markdown')
require('mappings')

