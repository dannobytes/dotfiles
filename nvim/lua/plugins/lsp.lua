return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = {
        float = { border = "rounded" }, -- Add rounded border
        virtual_text = false,
      },
      servers = {
        ts_ls = { enabled = false }, -- disabled in favor of vtsls
      },
    },
  },

  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      -- cmdline = { enabled = false },
      -- messages = { enabled = false },
      presets = {
        lsp_doc_border = true, -- add a border to hover docs and signature help
      },
    },
  },
}
