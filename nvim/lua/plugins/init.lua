return {
  {
    'crusoexia/vim-monokai',
    priority = 1000, -- High priority to load early
    lazy = false,    -- Load immediately on startup
    config = function()
      vim.cmd('colorscheme monokai')
    end,
  },

  -- Git and version control
  {
    'airblade/vim-gitgutter',
    enabled = false
  },                        -- Git gutter integration

  { 'tpope/vim-fugitive' }, -- Git integration
  { 'tpope/vim-rhubarb' },  -- Enables :GBrowse

  -- UI and theming
  { 'ap/vim-css-color' },            -- CSS color previews
  { 'nvim-tree/nvim-web-devicons' }, -- Web dev icons

  -- Editor functionality
  { 'editorconfig/editorconfig-vim' },
  { 'tpope/vim-surround' },   -- Matching surround pairs
  { 'tomtom/tcomment_vim' },  -- Easy comments
  { 'skwp/vim-html-escape' }, -- HTML entity escaping

  -- Language support
  { 'sheerun/vim-polyglot' }, -- Syntax highlighting for many languages
  { 'iloginow/vim-stylus' },  -- Stylus syntax
  { 'moll/vim-node' },        -- Open files via ESM

  -- Fuzzy finding
  {
    'junegunn/fzf',
    build = function() vim.fn['fzf#install']() end
  },
  { 'junegunn/fzf.vim' },
  { 'ibhagwan/fzf-lua' }, -- Fuzzy finder written in Lua

  -- LSP and completion
  {
    'neoclide/coc.nvim',
    branch = 'release'
  }, -- LSP client

  -- AI assistance
  { 'github/copilot.vim' }, -- GitHub Copilot

  -- CodeCompanion dependencies
  { 'echasnovski/mini.nvim' },
  { 'nvim-treesitter/nvim-treesitter' },
  { 'nvim-treesitter/nvim-treesitter-context' },
  {
    'olimorris/codecompanion.nvim',
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-treesitter/nvim-treesitter' },
    },
    keys = {
      { "<C-a>",          "<cmd>CodeCompanionActions<cr>",     mode = { "n", "v" }, desc = "CodeCompanion Actions" },
      { "<LocalLeader>a", "<cmd>CodeCompanionChat Toggle<cr>", mode = { "n", "v" }, desc = "Toggle CodeCompanion Chat" },
      { "ga",             "<cmd>CodeCompanionChat Add<cr>",    mode = "v",          desc = "Add to CodeCompanion Chat" },
    },
    opts = {
      adapters = {
        http = {
          anthropic = function()
            return require("codecompanion.adapters").extend("anthropic", {
              env = {
                api_key = "cmd:op read 'op://Private/Anthropic/api key' --no-newline",
              },
              schema = {
                extended_thinking = {
                  default = true,
                },
                model = {
                  default = "claude-sonnet-4-20250514",
                },
              },
            })
          end,
        }
      },
      display = {
        chat = {
          start_in_insert_mode = true, -- Open the chat buffer in insert mode?
        },
      },
      strategies = {
        chat = {
          adapter = "anthropic",
          keymaps = {
            send = {
              modes = {
                i = { "<C-cr>", "<C-s>" },
              },
            },
            close = {
              modes = { n = "<C-c>", i = "<C-c>" },
              opts = {},
            },
          },
          opts = {
            completion_provider = "coc", -- blink|cmp|coc|default
          },
          slash_commands = {
            ["buffer"] = {
              keymaps = {
                modes = {
                  -- i = "<C-t>",
                  n = { "<C-t>" },
                },
              },
            },
            ["file"] = {
              keymaps = {
                modes = {
                  -- i = "<C-p>",
                  n = { "<C-p>" },
                },
              },
            },
          },
        },
        inline = {
          adapter = "anthropic",
        },
      },
    }
  },
}
