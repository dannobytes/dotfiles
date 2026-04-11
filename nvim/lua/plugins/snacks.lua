return {
  'folke/snacks.nvim',
  ---@type snacks.Config
  opts = {
    ---@class snacks.explorer.Config
    explorer = {
      replace_netrw = false,
      trash = true,
    },
    picker = {
      enabled = true,
      layout = {
        layout = {
          width = 0.9,
          height = 0.85,
        },
      },
      sources = {
        explorer = {
          layout = {
            layout = {
              width = 40,
            },
          },
        },
        lsp_symbols = {
          filter = {
            typescript = {
              'Class',
              'Constructor',
              'Enum',
              'Field',
              'Function',
              'Interface',
              'Method',
              'Module',
              'Namespace',
              'Package',
              'Property',
              'Struct',
              'Trait',
              'Variable', -- New value not included in default filter.
            },
          },
        },
      },
    },
    scroll = {
      animate = {
        duration = { step = 10, total = 150 },
        easing = 'linear',
      },
    },
    terminal = { enabled = false },
  },
  keys = {
    -- disable scratch pad
    { '<leader>.', false },

    -- find
    { '<c-p>', function() Snacks.picker.files() end, desc = 'Find Files' },
    { '<c-t>', function() Snacks.picker.buffers() end, desc = 'Buffers' },
    { '<leader><c-p>', function() Snacks.picker.recent() end, desc = 'Recent' },

    -- git
    { '<leader>gB', function() Snacks.picker.git_branches() end, desc = 'Git Branches' },

    -- Grep
    { '<c-\\>', function() Snacks.picker.grep() end, desc = 'Grep' },

    {
      '\\\\',
      function() Snacks.picker.grep_word() end,
      desc = 'Visual selection or word',
      mode = { 'n', 'x' },
    },

    -- LSP
    { '<leader>D', function() Snacks.picker.diagnostics() end, desc = 'Diagnostics' },
    { '<leader>d', function() Snacks.picker.diagnostics_buffer() end, desc = 'Buffer Diagnostics' },
  },
}
