-- Configure leader keys as early as possible.
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.cmd [[
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
Plug 'ibhagwan/fzf-lua'
Plug 'moll/vim-node'              " Open files via ESM
Plug 'neoclide/coc.nvim', {'branch': 'release'}   " LSP client
Plug 'sheerun/vim-polyglot'       " Syntax highlighting for many languages
Plug 'sjl/badwolf'
Plug 'skwp/vim-html-escape'       " HTML entity escaping
Plug 'nvim-lualine/lualine.nvim'  " Fancier status line
Plug 'tomtom/tcomment_vim'        " Easy comments
Plug 'tpope/vim-fugitive'         " Git integration
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-rhubarb'          " Enables :GBrowse
Plug 'tpope/vim-surround'         " Matching surround pairs
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
" Configure editorconfig plugin to work well with fugitive.
" --------------------
let g:EditorConfig_exclude_patterns = ['fugitive://.*']

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
]]

--------------------
-- General options
--------------------
vim.cmd('colorscheme monokai')
vim.cmd('syntax on')

---------------------------
-- LUA configuration setup
---------------------------
require('coc')
require('coding')
require('coding_markdown')
require('fzf')
require('mappings')
require('options')
require('statusline')
