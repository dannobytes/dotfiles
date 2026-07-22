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
    opts = function(_, opts)
      opts.suggestion = vim.tbl_deep_extend('force', opts.suggestion or {}, {
        keymap = {
          accept_word = '<C-l>',
          accept_line = '<C-j>',
        },
      })

      -- Disable Copilot inside the Lattice monorepo. Gate per-buffer (not at
      -- startup) so Copilot keeps working in other repos opened in the same
      -- session. A path-prefix match also covers in-repo worktrees
      -- (`.worktrees/`, `.conductor/`) since those live under the repo root.
      local lattice = vim.fs.normalize('~/Developer/lattice')
      opts.should_attach = function(bufnr, bufname)
        -- Preserve Copilot's default gating: listed, normal buffers only.
        if not vim.bo[bufnr].buflisted or vim.bo[bufnr].buftype ~= '' then
          return false
        end
        local path = vim.fs.normalize(bufname)
        return not (path == lattice or vim.startswith(path, lattice .. '/'))
      end
    end,
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
