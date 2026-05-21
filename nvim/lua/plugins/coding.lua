return {
  -- Disabled in favor of copilot.lua, which is more actively maintained and has
  -- better support for newer Copilot features.
  -- {
  --   'github/copilot.vim',
  --   enabled = false,
  --   event = 'InsertEnter',
  --   cmd = 'Copilot',
  --   keys = {
  --     { '<c-l>', '<Plug>(copilot-accept-word)', mode = 'i', desc = 'Accept next Copilot suggestion word' },
  --   },
  -- },

  {
    'zbirenbaum/copilot.lua',
    opts = {
      suggestion = {
        keymap = {
          accept_word = '<C-l>',
          accept_line = '<C-j>',
        },
      },
    },
  },

  {
    'coder/claudecode.nvim',
    dependencies = { 'folke/snacks.nvim' },
    lazy = false,
    opts = {
      terminal = {
        -- no UI actions; server + tools remain available
        provider = 'none',
      },
    },
    keys = {
      { '<leader>am', '<cmd>ClaudeCodeSelectModel<cr>', desc = 'Select Claude model' },
      { '<leader>ab', '<cmd>ClaudeCodeAdd %<cr>', desc = 'Add current buffer' },
      { '<leader>as', '<cmd>ClaudeCodeSend<cr>', desc = 'Send to Claude', mode = 'v' },
      {
        '<leader>as',
        '<cmd>ClaudeCodeTreeAdd<cr>',
        desc = 'Add file',
        ft = { 'NvimTree', 'neo-tree', 'oil', 'minifiles', 'netrw' },
      },
      -- Diff management
      { '<leader>aa', '<cmd>ClaudeCodeDiffAccept<cr>', desc = 'Accept diff' },
      { '<leader>ad', '<cmd>ClaudeCodeDiffDeny<cr>', desc = 'Deny diff' },
    },
  },
}
