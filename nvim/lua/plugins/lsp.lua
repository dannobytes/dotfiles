return {
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        scss = { 'oxfmt', 'prettier', stop_after_first = true },
        sass = { 'oxfmt', 'prettier', stop_after_first = true },
      },
    },
  },

  {
    'neovim/nvim-lspconfig',
    opts = {
      diagnostics = {
        float = { border = 'rounded' }, -- Add rounded border
        virtual_text = false,
      },
      inlay_hints = {
        enabled = false,
      },
      servers = {
        oxlint = {
          settings = {
            fixKind = 'all',
          },
        },
      },
    },
  },
}
