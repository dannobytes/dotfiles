return {
  {
    'neovim/nvim-lspconfig',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    opts = {
      servers = {
        graphql = {},
        -- buf's built-in LSP for Protobuf (`buf lsp serve`).
        buf_ls = {},
      },
    },
  },
}
