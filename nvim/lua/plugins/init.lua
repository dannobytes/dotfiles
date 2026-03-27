return {
  -- 💔 Disabled plugins from LazyVim
  { "folke/flash.nvim", enabled = false },
  { "nvim-mini/mini.pairs", enabed = false },
  { "akinsho/bufferline.nvim", enabled = false },

  -- Theming
  {
    "crusoexia/vim-monokai",
    priority = 1000, -- High priority to load early
    lazy = false, -- Load immediately on startup
    config = function() vim.cmd("colorscheme monokai") end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "monokai",
    },
  },

  -- Legacy plugins still useful
  { "tpope/vim-fugitive" }, -- Git integration
  { "tpope/vim-rhubarb" }, -- Enables :GBrowse
  { "tpope/vim-surround" }, -- Matching surround pairs

  -- UI
  { "ap/vim-css-color" }, -- CSS color previews
  -- { "nvim-tree/nvim-web-devicons" }, -- Web dev icons

  -- Editor functionality
  {
    "editorconfig/editorconfig-vim",
    config = function() vim.g.EditorConfig_exclude_patterns = { "fugitive://.*", "scp://.*" } end,
  },
}
