-- Configure leader keys as early as possible.
vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

---------------------------
-- LUA configuration setup
---------------------------
require('config.lazy')
require('config.options')
require('config.keymaps')
require('config.autocmds')

-- Enable syntax highlighting in markdown code blocks for the following languages
vim.g.markdown_fenced_languages = {
  'bash=sh',
  'css',
  'html',
  'javascript',
  'json',
  'lua',
  'python',
  'scss',
  'typescript',
  'typescriptreact',
  'vim',
  'yaml',
}

vim.cmd([[
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
" Plug 'airblade/vim-gitgutter'     " Git gutter integration
" Plug 'ap/vim-css-color'           " CSS color previews
" Plug 'crusoexia/vim-monokai'      " Colors
" Plug 'editorconfig/editorconfig-vim'
" Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
" Plug 'junegunn/fzf.vim'
" Plug 'github/copilot.vim'         " GitHub Copilot
" Plug 'ibhagwan/fzf-lua'           " Fuzzy finder written in Lua
" Plug 'iloginow/vim-stylus'        " Stylus syntax
" Plug 'moll/vim-node'              " Open files via ESM
" Plug 'neoclide/coc.nvim', {'branch': 'release'}   " LSP client
" Plug 'nvim-lualine/lualine.nvim'  " Fancier status line
" Plug 'sheerun/vim-polyglot'       " Syntax highlighting for many languages
" Plug 'skwp/vim-html-escape'       " HTML entity escaping
" Plug 'tomtom/tcomment_vim'        " Easy comments
" Plug 'tpope/vim-fugitive'         " Git integration
" Plug 'tpope/vim-rhubarb'          " Enables :GBrowse
" Plug 'tpope/vim-surround'         " Matching surround pairs
" CodeCompanion Plugins
" Plug 'MeanderingProgrammer/render-markdown.nvim'
" Plug 'echasnovski/mini.nvim'
" Plug 'nvim-tree/nvim-web-devicons'
" CodeCompanion Insallation Instructions
" https://codecompanion.olimorris.dev/installation.html#vim-plug
" Plug 'nvim-lua/plenary.nvim'
" Plug 'nvim-treesitter/nvim-treesitter'
" Plug 'nvim-treesitter/nvim-treesitter-context'
" Plug 'olimorris/codecompanion.nvim'
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
" Configure netrw directory view
" --------------------
let g:netrw_keepdir = 1
let g:netrw_liststyle = 0
let g:netrw_sort_by = "name"
let g:netrw_winsize = 30

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
endif
]])
