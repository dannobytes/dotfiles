return {
  "neoclide/coc.nvim",
  branch = "release",
  enabled = false,
  lazy = false,
  init = function()
    ----------------------
    -- CoC config
    -- https://github.com/neoclide/coc.nvim/wiki/Using-coc-extensions
    ----------------------
    vim.g.coc_global_extensions = {
      "coc-css",
      "coc-eslint",
      "coc-html",
      "coc-jest",
      "coc-json",
      "coc-lua",
      "coc-marketplace",
      "coc-prettier",
      "coc-snippets",
      "coc-stylelintplus",
      "coc-svg",
      "coc-tsserver",
      "coc-yaml",
      "coc-yank",
    }
  end,
  keys = {
    -- Confirm completion by pressing enter
    {
      "<CR>",
      function()
        if vim.fn["coc#pum#visible"]() == 1 then
          return vim.fn["coc#pum#confirm"]()
        else
          return vim.api.nvim_replace_termcodes("<CR>", true, false, true)
        end
      end,
      mode = "i",
      expr = true,
      silent = true,
      desc = "Confirm completion",
    },

    -- Diagnostic navigation
    { "[g", "<Plug>(coc-diagnostic-prev)", mode = "n", silent = true, desc = "Previous diagnostic" },
    { "]g", "<Plug>(coc-diagnostic-next)", mode = "n", silent = true, desc = "Next diagnostic" },

    -- Code navigation
    { "gd", "<Plug>(coc-definition)", mode = "n", silent = true, desc = "Go to definition" },
    { "gy", "<Plug>(coc-type-definition)", mode = "n", silent = true, desc = "Go to type definition" },
    { "gi", "<Plug>(coc-implementation)", mode = "n", silent = true, desc = "Go to implementation" },
    { "gr", "<Plug>(coc-references)", mode = "n", silent = true, desc = "Go to references" },

    -- Show documentation
    {
      "K",
      function()
        if vim.fn.CocHasProvider("hover") then
          vim.fn.CocActionAsync("definitionHover")
        else
          vim.fn.feedkeys("K", "in")
        end
      end,
      mode = "n",
      silent = true,
      desc = "Show documentation",
    },

    -- Code actions and refactoring
    { "<leader>rn", "<Plug>(coc-rename)", mode = "n", desc = "Rename symbol" },
    { "<leader>ac", "<Plug>(coc-codeaction-cursor)", mode = "n", desc = "Code action (cursor)" },
    -- { '<leader>as', '<Plug>(coc-codeaction-source)', mode = 'n', desc = 'Code action (source)' },
    { "<leader>qf", "<Plug>(coc-fix-current)", mode = "n", desc = "Quick fix current line" },

    -- Float window scrolling
    {
      "<C-f>",
      function()
        return vim.fn["coc#float#has_scroll"]() == 1 and vim.fn["coc#float#scroll"](1) or "<C-f>"
      end,
      mode = "n",
      expr = true,
      silent = true,
      nowait = true,
      desc = "Scroll float down",
    },
    {
      "<C-b>",
      function()
        return vim.fn["coc#float#has_scroll"]() == 1 and vim.fn["coc#float#scroll"](0) or "<C-b>"
      end,
      mode = "n",
      expr = true,
      silent = true,
      nowait = true,
      desc = "Scroll float up",
    },
    {
      "<C-f>",
      function()
        return vim.fn["coc#float#has_scroll"]() == 1 and "<C-r>=coc#float#scroll(1)<CR>" or "<Right>"
      end,
      mode = "i",
      expr = true,
      silent = true,
      nowait = true,
      desc = "Scroll float down (insert)",
    },
    {
      "<C-b>",
      function()
        return vim.fn["coc#float#has_scroll"]() == 1 and "<C-r>=coc#float#scroll(0)<CR>" or "<Left>"
      end,
      mode = "i",
      expr = true,
      silent = true,
      nowait = true,
      desc = "Scroll float up (insert)",
    },
    {
      "<C-f>",
      function()
        return vim.fn["coc#float#has_scroll"]() == 1 and vim.fn["coc#float#scroll"](1) or "<C-f>"
      end,
      mode = "v",
      expr = true,
      silent = true,
      nowait = true,
      desc = "Scroll float down (visual)",
    },
    {
      "<C-b>",
      function()
        return vim.fn["coc#float#has_scroll"]() == 1 and vim.fn["coc#float#scroll"](0) or "<C-b>"
      end,
      mode = "v",
      expr = true,
      silent = true,
      nowait = true,
      desc = "Scroll float up (visual)",
    },

    -- CocList commands
    {
      "<leader>d",
      "<Cmd>CocList diagnostics<CR>",
      mode = "n",
      silent = true,
      nowait = true,
      desc = "Show all diagnostics",
    },
    {
      "<leader>e",
      "<Cmd>CocList extensions<CR>",
      mode = "n",
      silent = true,
      nowait = true,
      desc = "Manage extensions",
    },
    {
      "<leader>c",
      "<Cmd>CocList commands<CR>",
      mode = "n",
      silent = true,
      nowait = true,
      desc = "Show commands",
    },
    {
      "<leader>o",
      "<Cmd>CocList outline<CR>",
      mode = "n",
      silent = true,
      nowait = true,
      desc = "Document outline",
    },
    { "<leader>s", "<Cmd>CocList -I symbols<CR>", mode = "n", silent = true, desc = "Search workspace symbols" },
  },
}
