return {
  {
    'saghen/blink.cmp',
    opts = {
      completion = {
        menu = { border = 'rounded' },
        documentation = { window = { border = 'rounded' } },
      },
    },
  },

  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    opts = {
      cmdline = { view = 'cmdline' },
      messages = { enabled = false },
      presets = {
        lsp_doc_border = true, -- add a border to hover docs and signature help
      },
    },
  },
}
