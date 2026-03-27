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
}
