return {
  {
    'neovim/nvim-lspconfig',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    opts = {
      servers = {
        graphql = {},
        protols = {},
      },
    },
  },
}
