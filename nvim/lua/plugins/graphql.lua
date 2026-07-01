return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = { ensure_installed = { 'graphql', 'proto' } },
  },
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        graphql = {},
        protols = {},
      },
    },
  },
}
