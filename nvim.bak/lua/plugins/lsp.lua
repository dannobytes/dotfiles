return {
  -- Lua LSP support for Neovim config/plugin development (vim.* API completions)
  {
    "folke/lazydev.nvim",
    ft = "lua",
    dependencies = { "saghen/blink.cmp" },
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        { path = "snacks.nvim" },
        { path = "fzf-lua", words = { "FzfLua" } },
        { path = "conform.nvim" },
      },
    },
  },

  -- Bridges Mason and nvim-lspconfig to auto-configure installed LSP servers
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {},
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
    },
  },

  -- Formatter runner: runs oxfmt/prettier/stylua on save per filetype
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    ---@type conform.setupOpts
    opts = {
      formatters_by_ft = {
        css = { "oxfmt", "prettierd", "prettier", stop_after_first = true },
        html = { "oxfmt", "prettierd", "prettier", stop_after_first = true },
        javascript = { "oxfmt", "prettierd", "prettier", stop_after_first = true },
        javascriptreact = { "oxfmt", "prettierd", "prettier", stop_after_first = true },
        json = { "oxfmt", "prettierd", "prettier", stop_after_first = true },
        lua = { "stylua" },
        sass = { "prettierd", "prettier", stop_after_first = true },
        scss = { "prettierd", "prettier", stop_after_first = true },
        typescript = { "oxfmt", "prettierd", "prettier", stop_after_first = true },
        typescriptreact = { "oxfmt", "prettierd", "prettier", stop_after_first = true },
      },
      format_on_save = {
        async = false,
        quiet = false,
        lsp_format = "fallback",
        timeout_ms = 500,
      },
    },
  },

  -- Completion engine with LSP, buffer, path, and snippet sources
  {
    "saghen/blink.cmp",
    version = "*",
    opts = {
      completion = {
        menu = { border = "single" },
        documentation = { window = { border = "single" } },
      },
      signature = { window = { border = "single" } },
      keymap = {
        preset = "default",
        ["<C-@>"] = { "show", "fallback" },
        ["<Tab>"] = { "accept", "fallback" },
        ["<S-Tab>"] = { "select_prev", "fallback" },
      },
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "mono",
      },
      sources = {
        default = { "lazydev", "lsp", "path", "snippets", "buffer" },
        providers = {
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            score_offset = 100,
          },
        },
      },
    },
  },

  -- LSP client configs and keymaps; runs LspOxlintFixAll on save for JS/TS
  {
    "neovim/nvim-lspconfig",
    config = function()
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = { "*.js", "*.jsx", "*.ts", "*.tsx" },
        callback = function()
          if not pcall(vim.cmd, "LspOxlintFixAll") then pcall(vim.cmd, "LspEslintFixAll") end
        end,
      })

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("lsp_keymaps", { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, silent = true, desc = desc })
          end

          -- Diagnostics
          map(
            "[g",
            function() vim.diagnostic.jump({ count = -1, float = { border = "rounded", max_width = 80 } }) end,
            "Previous diagnostic"
          )
          map(
            "]g",
            function() vim.diagnostic.jump({ count = 1, float = { border = "rounded", max_width = 80 } }) end,
            "Next diagnostic"
          )
          -- map("<leader>d", "<cmd>FzfLua diagnostics_document<cr>", "Show all diagnostics")
          -- map("<leader>D", "<cmd>FzfLua diagnostics_workspace<cr>", "Show workspace diagnostics")

          -- Navigation
          -- map("gd", "<cmd>FzfLua lsp_definitions<cr>", "Go to definition")
          -- map("gy", "<cmd>FzfLua lsp_typedefs<cr>", "Go to type definition")
          -- map("gi", "<cmd>FzfLua lsp_implementations<cr>", "Go to implementation")
          -- map("gr", "<cmd>FzfLua lsp_references<cr>", "Go to references")

          -- Hover / docs
          map("K", function() vim.lsp.buf.hover({ border = "rounded", max_width = 80 }) end, "Show documentation")

          -- Refactoring
          map("<leader>rn", vim.lsp.buf.rename, "Rename symbol")
          map("<leader>ac", function() vim.lsp.buf.code_action({ apply = true }) end, "Quick fix current line")
          -- map("<leader>ac", "<cmd>FzfLua lsp_code_actions<cr>", "Code action")
          -- map("<leader>qf", function() vim.lsp.buf.code_action({ apply = true }) end, "Quick fix current line")

          -- Symbols
          -- map("<leader>o", "<cmd>FzfLua lsp_document_symbols<cr>", "Document outline")
          -- map("<leader>O", "<cmd>FzfLua lsp_finder<cr>", "LSP finder")
          -- map("<leader>s", "<cmd>FzfLua lsp_workspace_symbols<cr>", "Search workspace symbols")
        end,
      })
    end,
  },
}
