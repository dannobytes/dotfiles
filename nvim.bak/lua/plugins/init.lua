return {
  -- UI and theming
  {
    'crusoexia/vim-monokai',
    priority = 1000, -- High priority to load early
    lazy = false, -- Load immediately on startup
    config = function() vim.cmd('colorscheme monokai') end,
  },
  { 'ap/vim-css-color' }, -- CSS color previews
  { 'nvim-tree/nvim-web-devicons' }, -- Web dev icons

  -- Legacy plugins still useful
  { 'tpope/vim-fugitive' }, -- Git integration
  { 'tpope/vim-rhubarb' }, -- Enables :GBrowse
  { 'tpope/vim-surround' }, -- Matching surround pairs
  { 'tomtom/tcomment_vim' }, -- Easy comments

  {
    'nvim-mini/mini.nvim',
    version = false,
    config = function() require('mini.sessions').setup() end,
  },

  -- Editor functionality
  {
    'editorconfig/editorconfig-vim',
    config = function() vim.g.EditorConfig_exclude_patterns = { 'fugitive://.*', 'scp://.*' } end,
  },

  -- Language support
  { 'sheerun/vim-polyglot' }, -- Syntax highlighting for many languages
  { 'iloginow/vim-stylus' }, -- Stylus syntax
  { 'moll/vim-node' }, -- Open files via ESM

  -- AI assistance
  {
    'github/copilot.vim',
    lazy = false,
    keys = {
      { '<c-l>', '<Plug>(copilot-accept-word)', mode = 'i', desc = 'Accept next Copilot suggestion word' },
    },
  },

  -- CodeCompanion dependencies
  { 'echasnovski/mini.nvim' },
  { 'nvim-treesitter/nvim-treesitter' },
  { 'nvim-treesitter/nvim-treesitter-context' },
}
