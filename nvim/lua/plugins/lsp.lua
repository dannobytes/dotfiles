return {
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },

  {
    "mason-org/mason-lspconfig.nvim",
    enabled = true,
    opts = {},
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
    },
  },

  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    opts = {
      formatters_by_ft = {
        css = { "prettierd", "prettier", stop_after_first = true },
        html = { "prettierd", "prettier", stop_after_first = true },
        javascript = { "prettierd", "prettier", stop_after_first = true },
        javascriptreact = { "prettierd", "prettier", stop_after_first = true },
        json = { "prettierd", "prettier", stop_after_first = true },
        lua = { "stylua" },
        typescript = { "prettierd", "prettier", stop_after_first = true },
        typescriptreact = { "prettierd", "prettier", stop_after_first = true },
      },
      format_on_save = {
        lsp_format = "fallback",
        timeout_ms = 500,
      },
    },
  },

  {
    "neovim/nvim-lspconfig",
    enabled = true,
    config = function()
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = { "*.js", "*.jsx", "*.ts", "*.tsx" },
        command = "LspEslintFixAll",
      })

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("lsp_keymaps", { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, silent = true, desc = desc })
          end

          -- Diagnostics
          map("[g", function()
            vim.diagnostic.jump({ count = -1, float = { border = "rounded" } })
          end, "Previous diagnostic")
          map("]g", function()
            vim.diagnostic.jump({ count = 1, float = { border = "rounded" } })
          end, "Next diagnostic")
          map("<leader>d", "<cmd>FzfLua diagnostics_document<cr>", "Show all diagnostics")
          map("<leader>D", "<cmd>FzfLua diagnostics_workspace<cr>", "Show workspace diagnostics")

          -- Navigation
          map("gd", "<cmd>FzfLua lsp_definitions<cr>", "Go to definition")
          map("gy", "<cmd>FzfLua lsp_typedefs<cr>", "Go to type definition")
          map("gi", "<cmd>FzfLua lsp_implementations<cr>", "Go to implementation")
          map("gr", "<cmd>FzfLua lsp_references<cr>", "Go to references")

          -- Hover / docs
          map("K", function()
            vim.lsp.buf.hover({
              border = "rounded", -- 'single', 'double', 'rounded', 'solid', 'shadow'
              max_width = 80,
            })
          end, "Show documentation")

          -- Refactoring
          map("<leader>rn", vim.lsp.buf.rename, "Rename symbol")
          map("<leader>ac", "<cmd>FzfLua lsp_code_actions<cr>", "Code action")
          map("<leader>qf", function()
            vim.lsp.buf.code_action({ apply = true })
          end, "Quick fix current line")

          -- Symbols
          map("<leader>o", "<cmd>FzfLua lsp_document_symbols<cr>", "Document outline")
          map("<leader>O", "<cmd>FzfLua lsp_finder<cr>", "LSP finder")
          map("<leader>s", "<cmd>FzfLua lsp_workspace_symbols<cr>", "Search workspace symbols")
        end,
      })
    end,
  },
}
