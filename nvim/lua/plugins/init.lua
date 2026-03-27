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

  -- AI assistance
  {
    "github/copilot.vim",
    lazy = false,
    keys = {
      { "<c-l>", "<Plug>(copilot-accept-word)", mode = "i", desc = "Accept next Copilot suggestion word" },
    },
  },

  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signs_staged_enable = true,
      signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
      numhl = true, -- Toggle with `:Gitsigns toggle_numhl`
      linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
      word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
      current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
      -- watch_gitdir = {
      --   follow_files = true,
      -- },
      -- auto_attach = true,
      -- attach_to_untracked = false,
      -- current_line_blame_opts = {
      --   virt_text = true,
      --   virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
      --   delay = 1000,
      --   ignore_whitespace = false,
      --   virt_text_priority = 100,
      --   use_focus = true,
      -- },
      -- current_line_blame_formatter = "<author>, <author_time:%R> - <summary>",
      -- sign_priority = 6,
      -- update_debounce = 100,
      -- status_formatter = nil, -- Use default
      -- max_file_length = 40000, -- Disable if file is longer than this (in lines)
      -- preview_config = {
      --   -- Options passed to nvim_open_win
      --   style = "minimal",
      --   relative = "cursor",
      --   row = 0,
      --   col = 1,
      -- },
    },
  },
}
