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
call plug#end()

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
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.9 } }
let g:fzf_preview_window = ['right:60%', 'ctrl-/']

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
let g:netrw_liststyle = 0
let g:netrw_keepdir = 1

" --------------------
" Auto commands
" --------------------
if has("autocmd")
  " Apply custom color overrides whenever color scheme changes
  function! CustomHighlights()
    highlight CocErrorFloat ctermfg=green guifg=green
    highlight Visual ctermbg=54 ctermfg=7
    highlight Search ctermbg=78
    highlight GitGutterDelete guifg=#ff5f87 ctermfg=204
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
    autocmd BufRead,BufNewFile *.hamlc set filetype=haml
    autocmd BufRead,BufNewFile *.pug set filetype=pug
    autocmd BufRead,BufNewFile *.coffee set filetype=coffee
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
      execute 'silent grep!' shellescape(grep_term) | copen 10
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
" Mappings
" --------------------
let mapleader = "\<Space>"

" Shortucts to open vimrc and re-source it
nnoremap <leader>vrc :edit $MYVIMRC<cr>
nnoremap <leader>vrso :source $MYVIMRC<cr>

" Shortcuts to work with windows and buffers easier
nnoremap <leader>bb :b#<cr>
nnoremap <leader>bd :ls<cr>:bd<space>

" Shortcut command to clear all buffers except the current one.
command! BufOnly silent! execute "%bd|e#|bd#"
cnoreabbrev bo BufOnly

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
nnoremap // yiw/\V<C-R>"<CR>
vnoremap // y/\V<C-R>"<CR>

" fzf-vim command mappings
" Entrypoints to open up new files, commits, buffers via filename/keywords
nnoremap <leader>B :BCommits<cr>
nnoremap <leader>C :Commits<cr>
nnoremap <leader>H :History<cr>
nnoremap <leader>? :GFiles?<cr>
nnoremap <c-p> :Files<cr>
nnoremap <c-t> :Buffers<cr>
nnoremap <c-\> :Rg<cr>

" Create shortcut command to perform a custom :Rg search based on input.
function! RgPrompt()
  let query = input("Enter Rg pattern: ")
  if !empty(query)
    execute 'Rg' shellescape(query)
  endif
endfunction
command! RgSearch call RgPrompt()
nnoremap <leader><c-\> :RgSearch<cr>

" Open up fuzzy search one directory above to fuzzy search in an adjacent path
nnoremap <leader><C-p> :FZF<space>../

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
nnoremap <c-n> :call ToggleNumber()<cr>

" Count number of matches for the word under the cursor
nnoremap ,* *<c-o>:%s///gn<cr>

" Navigate split windows easily
nnoremap <c-l> <c-w><c-l>
nnoremap <c-h> <c-w><c-h>
nnoremap <c-k> <c-w><c-k>
nnoremap <c-j> <c-w><c-j>

" ---------------------
" CoC mappings - Largely inspired by this example:
" https://github.com/neoclide/coc.nvim#example-vim-configuration
" --------------------
" Shortcuts to next/previous diagnostic errors.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Common goto code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction-cursor)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Show all diagnostics.
nnoremap <silent><nowait> <space>d :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o :<C-u>CocList outline<cr>

" --------------------
" General options
" --------------------
colorscheme monokai
filetype plugin indent on
syntax on

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
set nocompatible
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
set ttyfast                         " Foor smoother redraws
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
