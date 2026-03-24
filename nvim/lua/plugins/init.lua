return {
  {
    "crusoexia/vim-monokai",
    priority = 1000, -- High priority to load early
    lazy = false, -- Load immediately on startup
    config = function()
      vim.cmd("colorscheme monokai")
    end,
  },

  { "tpope/vim-fugitive" }, -- Git integration
  { "tpope/vim-rhubarb" }, -- Enables :GBrowse

  -- UI and theming
  { "ap/vim-css-color" }, -- CSS color previews
  { "nvim-tree/nvim-web-devicons" }, -- Web dev icons

  -- Editor functionality
  {
    "editorconfig/editorconfig-vim",
    config = function()
      vim.g.EditorConfig_exclude_patterns = { "fugitive://.*", "scp://.*" }
    end,
  },
  { "tpope/vim-surround" }, -- Matching surround pairs
  { "tomtom/tcomment_vim" }, -- Easy comments
  { "skwp/vim-html-escape" }, -- HTML entity escaping

  -- Language support
  { "sheerun/vim-polyglot" }, -- Syntax highlighting for many languages
  { "iloginow/vim-stylus" }, -- Stylus syntax
  { "moll/vim-node" }, -- Open files via ESM

  -- AI assistance
  {
    "github/copilot.vim",
    lazy = false,
    keys = {
      { "<c-l>", "<Plug>(copilot-accept-word)", mode = "i", desc = "Accept next Copilot suggestion word" },
    },
  }, -- GitHub Copilot

  -- CodeCompanion dependencies
  { "echasnovski/mini.nvim" },
  { "nvim-treesitter/nvim-treesitter" },
  { "nvim-treesitter/nvim-treesitter-context" },
}
