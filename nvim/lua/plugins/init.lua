return {
  -- 💔 Disabled plugins from LazyVim
  { 'folke/flash.nvim', enabled = false },
  { 'akinsho/bufferline.nvim', enabled = false },

  -- Theming
  {
    'crusoexia/vim-monokai',
    priority = 1000, -- High priority to load early
    lazy = false, -- Load immediately on startup
    config = function() vim.cmd('colorscheme monokai') end,
  },
  {
    'LazyVim/LazyVim',
    opts = {
      colorscheme = 'monokai',
    },
  },

  -- UI
  { 'ap/vim-css-color' }, -- CSS color previews

  -- Editor functionality
  {
    'editorconfig/editorconfig-vim',
    config = function() vim.g.EditorConfig_exclude_patterns = { 'fugitive://.*', 'scp://.*' } end,
  },

  -- Legacy plugins still useful
  { 'tpope/vim-fugitive' }, -- Git integration
  { 'tpope/vim-rhubarb' }, -- Enables :GBrowse
  -- { 'tpope/vim-surround' }, -- Matching surround pairs
  -- { 'tomtom/tcomment_vim' }, -- Easy comments
  {
    'junegunn/fzf',
    dependencies = {
      'junegunn/fzf.vim',
    },
    keys = {
      { '<leader>gc', '<cmd>Commits<cr>', desc = 'Git commits' },
      { '<leader>gb', '<cmd>BCommits<cr>', desc = 'Git buffer commits' },
    },
  },
}
