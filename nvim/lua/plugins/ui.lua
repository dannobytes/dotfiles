return {
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      cmdline = { view = "cmdline" },
      presets = {
        lsp_doc_border = true, -- add a border to hover docs and signature help
      },
    },
  },
}
