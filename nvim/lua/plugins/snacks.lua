return {
  "folke/snacks.nvim",
  ---@type snacks.Config
  opts = {
    picker = {
      enabled = true,
      layout = {
        layout = {
          width = 0.9,
          height = 0.85,
        },
      },
    },
    scroll = {
      animate = {
        duration = { step = 10, total = 150 },
        easing = "linear",
      },
    },
  },
  keys = {
    { "<leader>.", false },

    -- find
    { "<c-p>", function() Snacks.picker.files() end, desc = "Find Files" },
    { "<c-t>", function() Snacks.picker.buffers() end, desc = "Buffers" },
    { "<leader><c-p>", function() Snacks.picker.recent() end, desc = "Recent" },

    -- git
    { "<leader>gB", function() Snacks.picker.git_branches() end, desc = "Git Branches" },

    -- Grep
    { "<c-\\>", function() Snacks.picker.grep() end, desc = "Grep" },

    {
      "\\\\",
      function() Snacks.picker.grep_word() end,
      desc = "Visual selection or word",
      mode = { "n", "x" },
    },

    -- LSP
    { "<leader>D", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
    { "<leader>d", function() Snacks.picker.diagnostics_buffer() end, desc = "Buffer Diagnostics" },
  },
}
